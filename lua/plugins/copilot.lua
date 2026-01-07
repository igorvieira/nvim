return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  config = function()
    require("copilot").setup({
      panel = {
        enabled = true,
        auto_refresh = false,
        keymap = {
          jump_prev = "[[",
          jump_next = "]]",
          accept = "<CR>",
          refresh = "gr",
          open = "<M-CR>"
        },
        layout = {
          position = "bottom",
          ratio = 0.4
        },
      },
      suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 75,
        keymap = {
          accept = false, -- Disabled, using custom double-tab instead
          accept_word = false,
          accept_line = false,
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
      },
      filetypes = {
        yaml = false,
        markdown = false,
        help = false,
        gitcommit = false,
        gitrebase = false,
        hgcommit = false,
        svn = false,
        cvs = false,
        ["."] = false,
      },
      copilot_node_command = 'node',
      server_opts_overrides = {},
    })

    -- Double-Tab to accept Copilot suggestion
    local last_tab_time = 0
    local double_tab_threshold = 300 -- 300ms to consider double-tab

    vim.keymap.set("i", "<Tab>", function()
      -- Check if blink.cmp menu is visible (priority: let blink handle it)
      local has_blink, blink = pcall(require, "blink.cmp")
      if has_blink and blink and blink.is_visible and blink.is_visible() then
        return "<Tab>" -- Let blink.cmp handle Tab navigation
      end

      local current_time = vim.loop.now()
      local time_diff = current_time - last_tab_time

      if time_diff < double_tab_threshold then
        -- Double-tab detected! Accept Copilot suggestion if visible
        last_tab_time = 0 -- Reset
        if require("copilot.suggestion").is_visible() then
          require("copilot.suggestion").accept()
          return ""
        end
      else
        -- First Tab or too much time between tabs
        last_tab_time = current_time
      end

      -- Normal Tab behavior (indentation or regular tab)
      return "<Tab>"
    end, { expr = true, silent = true, desc = "Double-tab accepts Copilot" })
  end,
}
