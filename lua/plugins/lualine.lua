return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    -- Git blame component com cor mais clara
    local git_blame = {
      function()
        local blame_text = vim.b.gitsigns_blame_line
        if not blame_text or blame_text == "" then
          return ""
        end
        
        -- Parse blame info para formato limpo
        local author = blame_text:match("^([^,]+)")
        local date = blame_text:match("(%d%d%d%d%-%d%d%-%d%d)")
        local summary = blame_text:match("- (.+)$")
        
        if author and date and summary then
          -- Calcular tempo relativo
          local current_time = os.time()
          local blame_date = string.gsub(date, "%-", "")
          local year = tonumber(string.sub(blame_date, 1, 4))
          local month = tonumber(string.sub(blame_date, 5, 6))
          local day = tonumber(string.sub(blame_date, 7, 8))
          
          local blame_time = os.time({year = year, month = month, day = day})
          local diff = current_time - blame_time
          local days = math.floor(diff / 86400)
          local hours = math.floor(diff / 3600)
          
          local time_str = ""
          if days > 0 then
            time_str = days == 1 and "1 day ago" or days .. " days ago"
          elseif hours > 0 then
            time_str = hours == 1 and "1 hour ago" or hours .. " hours ago"
          else
            time_str = "now"
          end
          
          -- Truncar summary se muito longo
          if #summary > 25 then
            summary = summary:sub(1, 22) .. "..."
          end
          
          return string.format("Blame %s (%s)", author, time_str)
        else
          return "Blame " .. blame_text
        end
      end,
      icon = "🍋",
      color = { fg = "#F8F8F2", gui = "bold" }, -- Branco claro do Dracula + bold
      cond = function()
        return vim.b.gitsigns_blame_line ~= nil and vim.b.gitsigns_blame_line ~= ""
      end
    }

    require("lualine").setup({
      options = {
        theme = "dracula",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        globalstatus = true,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { 
          "filename",
          git_blame -- Git blame com cor clara
        },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
    })
  end,
}
