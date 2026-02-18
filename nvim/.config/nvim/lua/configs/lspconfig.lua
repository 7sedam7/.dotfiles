-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

-- ensure Mason-installed servers are on PATH
vim.env.PATH = vim.fn.stdpath "data" .. "/mason/bin:" .. vim.env.PATH

-- OVERRIDE NvChad's diagnostic defaults
vim.diagnostic.config {
  virtual_text = false,
  virtual_lines = false,
}

local nvlsp = require "nvchad.configs.lspconfig"

-- shared config for all LSP servers
vim.lsp.config("*", {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
})

-- servers with default config
vim.lsp.enable { "html", "cssls", "gopls", "svelte" }

-- rust analyzer
vim.lsp.config("rust_analyzer", {
  filetypes = { "rust" },
  root_markers = { "Cargo.toml" },
  settings = {
    ["rust-analyzer"] = {
      diagnostics = {
        enable = false,
      },
      cargo = {
        allFeatures = true,
      },
    },
  },
})
vim.lsp.enable "rust_analyzer"

-- md setup
vim.lsp.config("marksman", {
  filetypes = { "markdown" },
})
vim.lsp.enable "marksman"
