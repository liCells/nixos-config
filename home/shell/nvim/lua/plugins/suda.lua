return {
  {
    "lambdalisue/suda.vim",
    lazy = false,
    config = function()
      vim.cmd([[cnoreabbrev <expr> w!! getcmdtype() == ':' && getcmdline() == 'w!!' ? 'SudaWrite' : 'w!!']])
    end,
  },
}
