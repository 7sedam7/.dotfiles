return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	}
  -- },

  -- {
  --
  --    "williamboman/mason.nvim",
  -- },

  {
    "mrcjkb/rustaceanvim",
    version = "^5", -- Recommended
    lazy = false, -- This plugin is already lazy
    ft = "rust",
    config = function()
      local mason_registry = require "mason-registry"
      local codelldb = mason_registry.get_package "codelldb"
      local extension_path = codelldb:get_install_path() .. "/extension/"
      local codelldb_path = extension_path .. "adapter/codelldb"
      local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"
      -- If you are on Linux, replace the line above with the line below:
      -- local liblldb_path = extension_path .. "lldb/lib/liblldb.so"
      local cfg = require "rustaceanvim.config"

      vim.g.rustaceanvim = {
        dap = {
          adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
        },
        server = {
          cmd = function()
            if mason_registry.is_installed "rust-analyzer" then
              -- This may need to be tweaked depending on the operating system.
              local ra = mason_registry.get_package "rust-analyzer"
              local ra_filename = ra:get_receipt():get().links.bin["rust-analyzer"]
              return { ("%s/%s"):format(ra:get_install_path(), ra_filename or "rust-analyzer") }
            else
              -- global installation
              return { "rust-analyzer" }
            end
          end,
        },
      }
    end,
  },

  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function()
      vim.g.rustfmt_autosave = 1
    end,
  },

  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap, dapui = require "dap", require "dapui"
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
    end,
  },

  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      require("dapui").setup()
    end,
  },

  {
    "saecki/crates.nvim",
    ft = { "toml" },
    config = function()
      require("crates").setup {
        completion = {
          cmp = {
            enabled = true,
          },
        },
      }
      require("cmp").setup.buffer {
        sources = { { name = "crates" } },
      }
    end,
  },
  {
    "7sedam7/perec.nvim",
    dir = "~/repos/perec",
    dev = true,
    init = function()
      require("perec").setup()
    end,
  },
  {
    "github/copilot.vim",
    lazy = false,
    config = function()
      -- Mapping tab is already used by NvChad
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_assume_mapped = true
      vim.g.copilot_tab_fallback = ""
      -- The mapping is set to other key, see custom/lua/mappings
      -- or run <leader>ch to see copilot mapping section
    end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      -- { "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = {
      -- See Configuration section for options
    },
    keys = {
      { "<leader>ac", ":CopilotChatToggle<CR>", mode = "n", desc = "Toggle CopilotChat" },
      { "<leader>ac", ":CopilotChatToggle<CR>", mode = "v", desc = "Toggle CopilotChat" },
      { "<leader>ae", ":CopilotChatExplain<CR>", mode = "v", desc = "Explain selected code" },
      { "<leader>ar", ":CopilotChatReview<CR>", mode = "v", desc = "Review selected code" },
      { "<leader>ad", ":CopilotChatDocs<CR>", mode = "v", desc = "Generate docs for selected code" },
      { "<leader>am", ":CopilotChatModels<CR>", mode = "n", desc = "Select model" },
      { "<leader>at", ":CopilotChatTests<CR>", mode = "v", desc = "Generate tests for selected code" },
      -- fix, optimize, test
    },
    -- See Commands section for default commands if you want to lazy load on them
    init = function()
      require("CopilotChat").setup()
    end,
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      file_types = { "markdown" },
      -- pipe_table = { enabled = false },
      -- checxkbox = { enabled = false },
      -- code = {
      --   disable_background = { "diff", "krafna" },
      -- },
    },
    ft = { "markdown" },
  },
  -- {
  --   "yetone/avante.nvim",
  --   event = "VeryLazy",
  --   lazy = false,
  --   dependencies = {
  --     "nvim-tree/nvim-web-devicons",
  --     "stevearc/dressing.nvim",
  --     "nvim-lua/plenary.nvim",
  --     "MunifTanjim/nui.nvim",
  --     {
  --       "MeanderingProgrammer/render-markdown.nvim",
  --       opts = {
  --         file_types = { "markdown", "Avante" },
  --         -- pipe_table = { enabled = false },
  --         -- checxkbox = { enabled = false },
  --       },
  --       ft = { "markdown", "Avante" },
  --     },
  --   },
  --   -- build = "make",
  --   opts = { provider = "copilot", model = "anthropic:claude-3-5-sonnet" },
  -- },
  {
    "hedyhli/outline.nvim",
    init = function()
      --     -- Example mapping to toggle outline
      vim.keymap.set("n", "<leader>o", "<cmd>Outline<CR>", { desc = "Toggle Outline" })
      --
      require("outline").setup {
        -- Your setup opts here (leave empty to use defaults)
      }
    end,
  },
  {
    "nanotee/zoxide.vim",
    lazy = false,
  },
}
