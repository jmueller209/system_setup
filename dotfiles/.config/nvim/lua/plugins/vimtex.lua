-- For compiling Latex

return {
  'lervag/vimtex',
  lazy = false, -- load immediately
  init = function()
    -- PDF viewer
    vim.g.vimtex_view_method = 'zathura'

    -- Use Tectonic instead of latexmk
    vim.g.vimtex_compiler_method = 'latexmk'

    -- Continuous compilation (auto-recompile on save)
    vim.g.vimtex_compiler_continuous = 1

    -- Enable default VimTeX key mappings (\ll, \lv, etc.)
    vim.g.vimtex_mappings_enabled = 1

    -- Optional: syntax highlighting and indentation
    vim.g.vimtex_syntax_enabled = 1
    vim.g.vimtex_indent_enabled = 1
  end,
}
