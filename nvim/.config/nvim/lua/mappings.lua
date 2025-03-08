require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Nvim DAP
map("n", "<Leader>dl", "<cmd>lua require'dap'.step_into()<CR>", { desc = "Debugger step into" })
map("n", "<Leader>dj", "<cmd>lua require'dap'.step_over()<CR>", { desc = "Debugger step over" })
map("n", "<Leader>dk", "<cmd>lua require'dap'.step_out()<CR>", { desc = "Debugger step out" })
map("n", "<Leader>dc", "<cmd>lua require'dap'.continue()<CR>", { desc = "Debugger continue" })
map("n", "<Leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", { desc = "Debugger toggle breakpoint" })
map(
  "n",
  "<Leader>dd",
  "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
  { desc = "Debugger set conditional breakpoint" }
)
map("n", "<Leader>dx", "<cmd>lua require'dap'.terminate()<CR>", { desc = "Debugger terminate" })
map("n", "<Leader>dr", "<cmd>lua require'dap'.run_last()<CR>", { desc = "Debugger run last" })

-- rustaceanvim
map("n", "<Leader>dt", "<cmd>lua vim.cmd('RustLsp testables')<CR>", { desc = "Debugger testables" })

-- Copilot
map("i", "<C-l>", "<cmd>lua vim.fn.feedkeys(vim.fn['copilot#Accept'](), '')<CR>", { desc = "Copilot Accept" })

-- Marked files
function OpenMarkedFiles()
  require("telescope.pickers")
    .new({}, {
      prompt_title = "Marked Files",
      finder = require("telescope.finders").new_table {
        results = vim.fn.readfile(vim.fn.expand "~/.config/.nvim-marked-files"),
      },
      previewer = require("telescope.config").values.file_previewer {},
      sorter = require("telescope.config").values.generic_sorter {},
    })
    :find()
end
map("n", "<Leader>hh", OpenMarkedFiles, { desc = "Search marked files" })

-- Create an autocommand to format on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.lua" },
  callback = function(args)
    require("conform").format { async = false, lsp_fallback = true }
  end,
})

-- Outline
-- map("n", "<leader>o", "<cmd>Outline<CR>", { desc = "Toggle Outline" })

-- Search symbols
map("n", "<leader>ss", "<cmd>Telescope lsp_document_symbols<CR>", { desc = "Search symbols" })

-- Development
local function unload_project(modname)
  for k, _ in pairs(package.loaded) do
    if k:find("^" .. modname .. "[.]*") then
      package.loaded[k] = nil
    end
  end
end
vim.keymap.set("n", "<leader>rr", function()
  unload_project "perec"
  -- Reload your plugin's init.lua
  vim.cmd("source " .. vim.fn.expand "~/repos/perec/lua/perec/init.lua")
end, { desc = "Reload Project" })
