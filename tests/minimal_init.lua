-- Minimal init.lua for testing
-- Sets up plugin manager and loads plugins in isolated environment

local M = {}

function M.setup()
  -- Set up paths
  local root = vim.fn.fnamemodify("./.tests", ":p")

  -- Set stdpaths to use .tests directory
  for _, name in ipairs({ "config", "data", "state", "cache" }) do
    vim.env[("XDG_%s_HOME"):format(name:upper())] = root .. "/" .. name
  end

  -- Bootstrap lazy.nvim
  local lazypath = root .. "/plugins/lazy.nvim"
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "--single-branch",
      "https://github.com/folke/lazy.nvim.git",
      lazypath,
    })
  end
  vim.opt.runtimepath:prepend(lazypath)

  -- Set leader keys
  vim.g.mapleader = " "
  vim.g.maplocalleader = " "

  -- Setup lazy.nvim
  require("lazy").setup({
    spec = {
      { import = "plugins" },
    },
    install = {
      colorscheme = { "dracula" },
    },
    ui = {
      backdrop = 100,
    },
  })
end

return M
