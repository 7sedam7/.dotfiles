require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.wrap = false
    -- vim.opt_local.list = false
  end,
})

vim.opt.relativenumber = true

-- Folding
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    -- vim.opt_local.foldmethod = "syntax"
    -- vim.opt_local.foldlevel = 1
    vim.opt_local.foldmethod = "expr"
    vim.opt_local.foldexpr = "nvim_treesitter#foldexpr()"
    vim.opt_local.foldlevel = 99
  end,
})
