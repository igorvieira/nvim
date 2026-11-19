return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    local js_fts = { "javascript", "typescript", "javascriptreact", "typescriptreact" }

    -- The project's own eslint (node_modules/.bin, searched upward from the file).
    local function local_eslint(bufnr)
      local name = vim.api.nvim_buf_get_name(bufnr or 0)
      if name == "" then
        return nil
      end
      return vim.fs.find("node_modules/.bin/eslint", {
        path = vim.fs.dirname(name),
        upward = true,
        type = "file",
      })[1]
    end

    -- Order: project eslint, then eslint_d, then a global eslint.
    local warned = false
    local function pick_linter(bufnr)
      if local_eslint(bufnr) then
        return "eslint"
      elseif vim.fn.executable("eslint_d") == 1 then
        return "eslint_d"
      elseif vim.fn.executable("eslint") == 1 then
        return "eslint"
      end
      if not warned then
        warned = true
        vim.schedule(function()
          vim.notify("ESLint not found (no project eslint, eslint_d or global eslint)", vim.log.levels.WARN)
        end)
      end
      return nil
    end

    -- Run eslint from the project binary when there is one.
    lint.linters.eslint = vim.tbl_extend("force", {}, lint.linters.eslint, {
      cmd = function()
        return local_eslint(0) or "eslint"
      end,
    })

    lint.linters_by_ft = {}

    local function safe_try_lint()
      local bufnr = vim.api.nvim_get_current_buf()
      if not vim.tbl_contains(js_fts, vim.bo[bufnr].filetype) then
        return
      end
      local linter = pick_linter(bufnr)
      if not linter then
        return
      end
      local root = vim.fs.root(bufnr, {
        "eslint.config.js", "eslint.config.mjs", "eslint.config.ts",
        ".eslintrc.json", ".eslintrc.js", ".eslintrc.cjs", "package.json",
      })
      local ok, err = pcall(lint.try_lint, linter, { cwd = root })
      if not ok then
        vim.notify("Lint error: " .. tostring(err), vim.log.levels.ERROR)
      end
    end

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = safe_try_lint,
    })

    vim.keymap.set("n", "<leader>ll", safe_try_lint, { desc = "Run linting" })
  end,
}
