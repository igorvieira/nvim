return {
  "sindrets/diffview.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewFileHistory" },
  keys = {
    { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Open diff view" },
    { "<leader>gc", "<cmd>DiffviewClose<cr>", desc = "Close diff view" },
    { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "File history (current file)" },
    { "<leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "File history (all files)" },
  },
  config = function()
    require("diffview").setup({
      enhanced_diff_hl = true, -- Better syntax highlighting in diffs
      view = {
        default = {
          layout = "diff2_horizontal", -- Side-by-side diff
        },
        merge_tool = {
          layout = "diff3_horizontal",
        },
      },
      file_panel = {
        listing_style = "tree", -- or "list"
        tree_options = {
          flatten_dirs = true,
          folder_statuses = "only_folded",
        },
        win_config = {
          position = "left",
          width = 35,
        },
      },
      file_history_panel = {
        log_options = {
          git = {
            single_file = {
              diff_merges = "combined",
            },
            multi_file = {
              diff_merges = "first-parent",
            },
          },
        },
        win_config = {
          position = "bottom",
          height = 16,
        },
      },
      keymaps = {
        view = {
          { "n", "<tab>", "<cmd>DiffviewToggleFiles<cr>", { desc = "Toggle file panel" } },
          { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close diffview" } },
        },
        file_panel = {
          { "n", "j", "j", { desc = "Next file" } },
          { "n", "k", "k", { desc = "Previous file" } },
          { "n", "<cr>", "<cmd>lua require('diffview.actions').select_entry()<cr>", { desc = "Open diff" } },
          { "n", "s", "<cmd>lua require('diffview.actions').toggle_stage_entry()<cr>", { desc = "Stage/unstage" } },
          { "n", "R", "<cmd>lua require('diffview.actions').refresh_files()<cr>", { desc = "Refresh" } },
          { "n", "<tab>", "<cmd>DiffviewToggleFiles<cr>", { desc = "Toggle file panel" } },
          { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close diffview" } },
        },
        file_history_panel = {
          { "n", "g!", "<cmd>lua require('diffview.actions').options()<cr>", { desc = "Options" } },
          { "n", "<cr>", "<cmd>lua require('diffview.actions').select_entry()<cr>", { desc = "Open commit" } },
          { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close diffview" } },
        },
      },
    })
  end,
}
