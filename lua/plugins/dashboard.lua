return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local logo = [[
███╗   ██╗██╗   ██╗██╗███╗   ███╗
████╗  ██║██║   ██║██║████╗ ████║
██╔██╗ ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██║   ██║██║██║╚██╔╝██║
██║ ╚████║╚██████╔╝██║██║ ╚═╝ ██║
╚═╝  ╚═══╝ ╚═════╝ ╚═╝╚═╝     ╚═╝
    ]]

    local date = os.date("📅 %Y-%m-%d %H:%M:%S")
    local phrase = "Don't waste your time"

    require("dashboard").setup({
      theme = "hyper",
      config = {
        week_header = {
          enable = true,
        },
        header = vim.split(logo, "\n"),
        shortcut = {
          { desc = " Update", group = "@property", action = "Lazy update", key = "u" },
          { desc = "󰈞 Files", group = "Label", action = "Telescope find_files", key = "f" },
          { desc = "󰍳 Apps", group = "Number", action = "Telescope app", key = "a" },
          { desc = " dotfiles", group = "Constant", action = "Telescope find_files cwd=~/.config/nvim", key = "d" },
        },
        project = {
          enable = true,
          limit = 7,
          label = "  Recently Projects:",
          icon = "🗃️ ",
        },
        mru = {
          limit = 10,
          label = "  Most Recent Files:",
          cwd_only = false,
        },
        footer = {
          "",
          "🚀 Sharp tools make good work.",
          date .. "  " .. phrase,
        },
      },
    })
  end,
}

