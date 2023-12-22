    local defaults = require("formatter.defaults")
local M={
  filetype={
    javascript ={
      require("formatter.filetypes.javascript").prettier
    },
    typescript ={
      require("formatter.filetypes.typescript").prettier
    },
    cpp ={defaults.clangformat},
    c ={defaults.clangformat},
    -- go ={defaults.standard},
    go = {
      function()
        return {
          exe = "gofmt",
          --args = {
          --  "-w",
          --  vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
          --},
          stdin = true,
        }
      end,
    },
    ["*"]= {
      require("formatter.filetypes.any").remove_trailing_whitespaces
    }
  }
}

vim.api.nvim_create_autocmd({"BufWritePost"}, {
  command = "FormatWriteLock"
})

return M
