#!/usr/bin/env -S nvim -l

-- Simple test runner for Neovim config tests
-- Usage: nvim -l tests/test_runner.lua

local stats = {
  passed = 0,
  failed = 0,
  total = 0,
}

local function test(description, fn)
  stats.total = stats.total + 1
  local ok, err = pcall(fn)

  if ok then
    stats.passed = stats.passed + 1
    print("[PASS] " .. description)
  else
    stats.failed = stats.failed + 1
    print("[FAIL] " .. description)
    print("  Error: " .. tostring(err))
  end
end

local function assert_true(condition, message)
  if not condition then
    error(message or "Assertion failed: expected true")
  end
end

local function assert_false(condition, message)
  if condition then
    error(message or "Assertion failed: expected false")
  end
end

local function assert_equals(expected, actual, message)
  if expected ~= actual then
    error(message or string.format("Expected %s but got %s", tostring(expected), tostring(actual)))
  end
end

local function assert_not_nil(value, message)
  if value == nil then
    error(message or "Expected non-nil value")
  end
end

-- Make assertions global for tests
_G.assert_true = assert_true
_G.assert_false = assert_false
_G.assert_equals = assert_equals
_G.assert_not_nil = assert_not_nil
_G.test = test

print("\n=== Running Neovim Configuration Tests ===\n")

-- Load init.lua
vim.cmd("source " .. vim.fn.stdpath("config") .. "/init.lua")

-- Wait for plugins to load
vim.wait(2000, function() return false end)

-- Run tests
print("\nTesting Core Options...")
test("Number and relative number should be enabled", function()
  assert_true(vim.opt.number:get())
  assert_true(vim.opt.relativenumber:get())
end)

test("Tab settings should be 2 spaces", function()
  assert_equals(2, vim.opt.tabstop:get())
  assert_equals(2, vim.opt.shiftwidth:get())
  assert_true(vim.opt.expandtab:get())
end)

test("Termguicolors should be enabled", function()
  assert_true(vim.opt.termguicolors:get())
end)

test("Signcolumn should be set to yes", function()
  assert_equals("yes", vim.opt.signcolumn:get())
end)

test("Undofile should be enabled", function()
  assert_true(vim.opt.undofile:get())
end)

test("Swap files should be disabled", function()
  assert_false(vim.opt.swapfile:get())
end)

print("\nTesting Keymaps...")
test("Leader key should be space", function()
  assert_equals(" ", vim.g.mapleader)
end)

test("Save file keymap should exist", function()
  local maps = vim.api.nvim_get_keymap("n")
  local found = false
  for _, map in ipairs(maps) do
    if map.lhs == " w" then
      found = true
      break
    end
  end
  assert_true(found, "<leader>w mapping not found")
end)

print("\nTesting Autocommands...")
test("YankHighlight autogroup should exist", function()
  local augroups = vim.api.nvim_get_autocmds({ group = "YankHighlight" })
  assert_true(#augroups > 0)
end)

test("LastLocation autogroup should exist", function()
  local augroups = vim.api.nvim_get_autocmds({ group = "LastLocation" })
  assert_true(#augroups > 0)
end)

print("\nTesting Plugin Loading...")
test("Lazy.nvim should be loaded", function()
  local ok, lazy = pcall(require, "lazy")
  assert_true(ok)
  assert_not_nil(lazy)
end)

test("Lockfile should exist", function()
  local lockfile = vim.fn.stdpath("config") .. "/lazy-lock.json"
  assert_equals(1, vim.fn.filereadable(lockfile))
end)

test("No duplicate mason.lua files", function()
  local mason_main = vim.fn.filereadable(vim.fn.stdpath("config") .. "/lua/plugins/mason.lua")
  local mason_lsp = vim.fn.filereadable(vim.fn.stdpath("config") .. "/lua/plugins/lsp/mason.lua")

  assert_equals(1, mason_main, "Main mason.lua should exist")
  assert_equals(0, mason_lsp, "Duplicate lsp/mason.lua should not exist")
end)

print("\nTesting Health Checks...")
test("Neovim version should be 0.10+", function()
  local version = vim.version()
  assert_true(version.major > 0 or (version.major == 0 and version.minor >= 10))
end)

test("Git should be available", function()
  assert_equals(1, vim.fn.executable("git"))
end)

test("Ripgrep should be available", function()
  assert_equals(1, vim.fn.executable("rg"))
end)

test("Config directory should exist", function()
  local config_dir = vim.fn.stdpath("config")
  assert_not_nil(config_dir)
  assert_equals(1, vim.fn.isdirectory(config_dir))
end)

-- Print summary
print("\n=== Test Summary ===")
print(string.format("Total:  %d", stats.total))
print(string.format("Passed: %d", stats.passed))
if stats.failed > 0 then
  print(string.format("Failed: %d", stats.failed))
end

local success_rate = math.floor((stats.passed / stats.total) * 100)
print(string.format("\nSuccess Rate: %d%%", success_rate))

-- Exit with appropriate code
os.exit(stats.failed == 0 and 0 or 1)
