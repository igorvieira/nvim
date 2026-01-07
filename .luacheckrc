-- Luacheck configuration
std = "lua51+luajit"
globals = {
  "vim",
  "describe",
  "it",
  "before_each",
  "after_each",
  "assert",
  "pending",
}
ignore = {
  "212", -- unused argument
  "631", -- line too long
}
exclude_files = {
  ".tests/",
  "lazy-lock.json",
}
