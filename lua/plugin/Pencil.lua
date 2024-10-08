return {
  {
    "preservim/vim-pencil",
    ft = {"markdown", "tex", "bib", "typst"},
    config = function()
      vim.cmd[[let g:pencil#conceallevel = 2]] -- no conceal
      vim.cmd[[autocmd Filetype markdown PencilSoft]]
      vim.cmd[[autocmd Filetype tex Pencil]]
      vim.cmd[[autocmd Filetype bib Pencil]]

      -- vim.cmd[[autocmd Filetype markdown set nobreakindent]] -- this is set by pencil and its slow af


      -- Wrapping
      vim.cmd[[autocmd Filetype markdown set linebreak]]
      vim.cmd[[autocmd Filetype markdown set breakindentopt=list:-1]]
    end,
  },

}
