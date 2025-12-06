-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

-- OVERRIDE NvChad's diagnostic defaults
vim.diagnostic.config {
  virtual_text = false,
  virtual_lines = false,
}

local lspconfig = require "lspconfig"
local util = require "lspconfig/util"

-- EXAMPLE
local servers = { "html", "cssls", "gopls", "svelte-language-serve" }
local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

-- configuring single server, example: typescript
-- lspconfig.ts_ls.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }
--
lspconfig.rust_analyzer.setup {
  on_attach = nvlsp.on_attach,
  capabilities = nvlsp.capabilities,
  filetypes = { "rust" },
  root_dir = util.root_pattern "Cargo.toml",
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
}

-- md setup
lspconfig.marksman.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  filetypes = { "markdown" },
  -- root_dir = os.getenv('PEREC_DIR'),
}
