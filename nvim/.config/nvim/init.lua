vim.g.mapleader = " "

-- Plugins
vim.pack.add({
  "https://github.com/folke/tokyonight.nvim",
  { src = "https://github.com/saghen/blink.cmp", version = "v1.10.2" },
  "https://github.com/github/copilot.vim",
  "https://github.com/folke/snacks.nvim",
  "https://github.com/folke/which-key.nvim",
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/mikavilpas/yazi.nvim",
  "https://github.com/esmuellert/codediff.nvim",
  "https://github.com/MeanderingProgrammer/render-markdown.nvim",
  "https://github.com/folke/flash.nvim",
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/mistweaverco/kulala.nvim",
  "https://github.com/lewis6991/gitsigns.nvim",
})

-- Local plugin (dev)
-- vim.opt.rtp:prepend("~/repos/Krafna/perec")
-- require("perec").setup()

-- Theme
vim.cmd.colorscheme("tokyonight")

-- Which-key (shows keymaps on leader press)
require("which-key").setup()

-- Blink completion
-- Run `mise run nvim-setup` after first launch to build fuzzy matcher
require("blink.cmp").setup({
  sources = { default = { "lsp", "path", "buffer" } },
  completion = {
    list = {
      selection = {
        preselect = function() return true end,
        auto_insert = function() return true end,
      },
    },
  },
  keymap = {
    preset = "enter",
    ["<Tab>"] = { "select_next", "fallback" },
    ["<S-Tab>"] = { "select_prev", "fallback" },
    ["<Esc>"] = { "cancel", "fallback" },
  },
})

-- LSP (native 0.12 config)
-- brew install lua-language-server
vim.lsp.config["lua_ls"] = {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { ".luarc.json", ".git" },
  settings = { Lua = { diagnostics = { globals = { "vim" } } } },
}
vim.lsp.enable("lua_ls")

-- cargo install --git https://github.com/artempyanykh/marksman
vim.lsp.config["marksman"] = {
  cmd = { "marksman", "server" },
  filetypes = { "markdown" },
  root_markers = { ".marksman.toml", ".git" },
}
vim.lsp.enable("marksman")

-- rustup component add rust-analyzer (not included by default in rustup)
vim.lsp.config["rust_analyzer"] = {
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
  root_markers = { "Cargo.toml", ".git" },
}
vim.lsp.enable("rust_analyzer")

-- npm install -g svelte-language-server
vim.lsp.config["svelte"] = {
  cmd = { "svelteserver", "--stdio" },
  filetypes = { "svelte" },
  root_markers = { "svelte.config.js", "package.json", ".git" },
}
vim.lsp.enable("svelte")

-- Render markdown
require("render-markdown").setup()

-- Default LSP keymaps in 0.12: gd, K, gra, grn, grr, grt

-- Snacks
require("snacks").setup({
  picker = { enabled = true },
  terminal = { enabled = true },
})
vim.keymap.set("n", "<leader>ff", function() Snacks.picker.files() end, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", function() Snacks.picker.grep() end, { desc = "Grep" })
vim.keymap.set("n", "<leader>fb", function() Snacks.picker.buffers() end, { desc = "Buffers" })
vim.keymap.set("n", "<leader>fh", function() Snacks.picker.help() end, { desc = "Help" })
vim.keymap.set("n", "<leader>fs", function() Snacks.picker.lsp_symbols() end, { desc = "LSP symbols" })
vim.keymap.set("n", "<leader>gl", function() Snacks.picker.git_log() end, { desc = "Git log" })
vim.keymap.set("n", "<leader>gd", function() Snacks.picker.git_diff() end, { desc = "Git diff" })
vim.keymap.set("n", "<leader>gs", function() Snacks.picker.git_status() end, { desc = "Git status" })
vim.keymap.set("n", "<C-t>", function() Snacks.terminal.toggle() end, { desc = "Toggle terminal" })
vim.keymap.set("t", "<C-t>", function() Snacks.terminal.toggle() end, { desc = "Toggle terminal" })

-- Yazi
require("yazi").setup({})
vim.keymap.set("n", "<leader>yf", "<cmd>Yazi<cr>", { desc = "Yazi at file" })
vim.keymap.set("n", "<leader>yd", "<cmd>Yazi cwd<cr>", { desc = "Yazi at cwd" })

-- Copilot (ghost text, C-y to accept)
vim.g.copilot_no_tab_map = true
vim.keymap.set("i", "<C-y>", 'copilot#Accept("\\<CR>")', { expr = true, replace_keycodes = false })

-- Options
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.signcolumn = "yes"
vim.opt.clipboard = "unnamedplus"
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.linebreak = true

-- Window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("n", ";", ":")
vim.keymap.set("n", "<leader>cd", "<cmd>CodeDiff<cr>", { desc = "CodeDiff" })

-- Flash (motions)
require("flash").setup()
vim.keymap.set({ "n", "x", "o" }, "s", function() require("flash").jump() end, { desc = "Flash jump" })
vim.keymap.set({ "n", "x", "o" }, "S", function() require("flash").treesitter() end, { desc = "Flash treesitter" })

-- Treesitter (auto-install parsers)
-- cargo install --locked tree-sitter-cli (needed to compile some parsers)
local ok, ts = pcall(require, "nvim-treesitter.configs")
if ok then
  ts.setup({
    ensure_installed = { "rust", "svelte", "javascript", "typescript", "html", "css", "json", "http", "markdown", "markdown_inline" },
    auto_install = true,
    highlight = { enable = true },
  })
end

-- Kulala (HTTP client)
require("kulala").setup()
vim.keymap.set("n", "<leader>hr", function() require("kulala").run() end, { desc = "Run request" })
vim.keymap.set("n", "<leader>ha", function() require("kulala").run_all() end, { desc = "Run all requests" })
vim.keymap.set("n", "<leader>hp", function() require("kulala").jump_prev() end, { desc = "Prev request" })
vim.keymap.set("n", "<leader>hn", function() require("kulala").jump_next() end, { desc = "Next request" })

-- Gitsigns (git diff in gutter)
require("gitsigns").setup({
  on_attach = function(bufnr)
    local gs = require("gitsigns")
    local opts = { buffer = bufnr }
    vim.keymap.set("n", "]h", gs.next_hunk, opts)
    vim.keymap.set("n", "[h", gs.prev_hunk, opts)
    vim.keymap.set("n", "<leader>hp", gs.preview_hunk, opts)
    vim.keymap.set("n", "<leader>hb", gs.blame_line, opts)
  end,
})

-- Custom gx for markdown links
vim.keymap.set("n", "gx", function()
  local file = vim.fn.expand("<cfile>")
  if file:match("%.md$") then
    local current_dir = vim.fn.expand("%:p:h")
    local target = current_dir .. "/" .. file:gsub("^/", "")
    vim.cmd("edit " .. target)
  else
    vim.ui.open(file)
  end
end, { desc = "Open file/URL" })
