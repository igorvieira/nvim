local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = { { import = "plugins" } },
  defaults = { lazy = false, version = false },
  install = { colorscheme = { "dracula" } },
  checker = { enabled = false, notify = false },
  change_detection = { enabled = false, notify = false },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip", "matchit", "matchparen", "netrwPlugin", "tarPlugin", "tohtml", "tutor", "zipPlugin",
      },
    },
  },
})

vim.keymap.set("n", "<leader>lu", "<cmd>Lazy update<CR>", { desc = "Atualizar plugins" })
vim.keymap.set("n", "<leader>lc", "<cmd>Lazy check<CR>", { desc = "Verificar atualizações" })
