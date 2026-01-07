return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("gitsigns").setup({
      signs = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
      },
      current_line_blame = true, -- Enable blame
      current_line_blame_opts = {
        virt_text = false, -- Don't show as virtual text
        virt_text_pos = 'eol',
        delay = 100, -- Fast delay
        ignore_whitespace = false,
        virt_text_priority = 100,
      },
      current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
      
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation between hunks
        map("n", "]c", function()
          if vim.wo.diff then return "]c" end
          vim.schedule(function() gs.next_hunk() end)
          return "<Ignore>"
        end, { expr = true, desc = "Next hunk" })

        map("n", "[c", function()
          if vim.wo.diff then return "[c" end
          vim.schedule(function() gs.prev_hunk() end)
          return "<Ignore>"
        end, { expr = true, desc = "Previous hunk" })

        -- Git operations
        map("n", "<leader>hs", gs.stage_hunk, { desc = "Stage hunk" })
        map("n", "<leader>hr", gs.reset_hunk, { desc = "Reset hunk" })
        map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview hunk" })
        map("n", "<leader>hb", function() 
          gs.blame_line({ full = true }) 
        end, { desc = "Show full git blame" })
        map("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "Toggle blame in statusline" })
        map("n", "<leader>hd", gs.diffthis, { desc = "Diff this" })
        map("n", "<leader>hD", function() gs.diffthis("~") end, { desc = "Diff this ~" })
        map("n", "<leader>td", gs.toggle_deleted, { desc = "Toggle deleted" })

        -- Visual mode mappings
        map({"o", "x"}, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select hunk" })
        map({"n", "v"}, "<leader>hs", ":Gitsigns stage_hunk<CR>", { desc = "Stage hunk" })
        map({"n", "v"}, "<leader>hr", ":Gitsigns reset_hunk<CR>", { desc = "Reset hunk" })
        map("n", "<leader>hS", gs.stage_buffer, { desc = "Stage buffer" })
        map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Undo stage hunk" })
        map("n", "<leader>hR", gs.reset_buffer, { desc = "Reset buffer" })
      end,
    })

    -- Optimize lualine refresh - only update on blame changes, not every cursor move
    local augroup = vim.api.nvim_create_augroup("GitBlameStatusline", { clear = true })
    local last_blame = ""

    vim.api.nvim_create_autocmd("CursorHold", {
      group = augroup,
      callback = function()
        local current_blame = vim.b.gitsigns_blame_line or ""
        if current_blame ~= last_blame then
          last_blame = current_blame
          vim.schedule(function()
            if package.loaded.lualine then
              require('lualine').refresh()
            end
          end)
        end
      end,
    })

    -- Clear blame when leaving buffer
    vim.api.nvim_create_autocmd("BufLeave", {
      group = augroup,
      callback = function()
        vim.b.gitsigns_blame_line = ""
        last_blame = ""
        if package.loaded.lualine then
          require('lualine').refresh()
        end
      end,
    })
  end,
}
