return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        path_display = { "truncate" },
        hidden = true,
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-q>"] = function(prompt_bufnr)
              actions.send_selected_to_qflist(prompt_bufnr)
              actions.open_qflist(prompt_bufnr)
            end,
          },
        },
      },
      pickers = {
        find_files = {
          hidden = true,
          find_command = { "rg", "--files", "--hidden", "--glob", "!**/node_modules/*" },
        },
        live_grep = {
          additional_args = function()
            return { "--hidden", "--glob", "!**/node_modules/*" }
          end,
        },
        grep_string = {
          additional_args = function()
            return { "--hidden", "--glob", "!**/node_modules/*" }
          end,
        },
      },
    })

    telescope.load_extension("fzf")

    local keymap = vim.keymap
    keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
    keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Find recent files" })
    keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string" })
    keymap.set("n", "<leader>fsp", function()
      local clipboard_text = vim.fn.getreg('+')
      require("telescope.builtin").live_grep({
        default_text = clipboard_text,
      })
    end, { desc = "Find string (paste from clipboard)" })
    keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor" })
    keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find buffers" })
    keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Find help" })
    keymap.set("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "Find keymaps" })
    keymap.set("n", "<leader>fd", "<cmd>Telescope diagnostics<cr>", { desc = "Find diagnostics" })
    keymap.set("n", "<leader>fg", "<cmd>Telescope git_files<cr>", { desc = "Find git files" })
    keymap.set("n", "<leader>fa", function()
      require("telescope.builtin").find_files({
        hidden = true,
        no_ignore = true,
        follow = true,
      })
    end, { desc = "Find all files (including ignored)" })
    keymap.set("n", "<leader>fgit", function()
      require("telescope.builtin").find_files({
        cwd = vim.fn.getcwd() .. "/.git",
        hidden = true,
        no_ignore = true,
      })
    end, { desc = "Find files in .git folder" })
    keymap.set("n", "<leader>fnm", function()
      require("telescope.builtin").find_files({
        search_dirs = { "node_modules" },
        hidden = true,
        no_ignore = true,
      })
    end, { desc = "Find files in node_modules" })
    keymap.set("n", "<leader>fsgit", function()
      require("telescope.builtin").live_grep({
        search_dirs = { ".git" },
        additional_args = function()
          return { "--hidden", "--no-ignore" }
        end,
      })
    end, { desc = "Search text in .git folder" })
    keymap.set("n", "<leader>fsnm", function()
      require("telescope.builtin").live_grep({
        search_dirs = { "node_modules" },
        additional_args = function()
          return { "--hidden", "--no-ignore" }
        end,
      })
    end, { desc = "Search text in node_modules" })
  end,
}
