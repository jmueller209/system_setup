-- GitHub Copilot Integration
return {
  'github/copilot.vim',
  config = function()
    -- Disable the default <Tab> mapping
    vim.g.copilot_no_tab_map = true

    -- Map Shift+Enter to accept Copilot suggestion
    vim.api.nvim_set_keymap('i', '<S-CR>', 'copilot#Accept("<CR>")', { silent = true, expr = true, replace_keycodes = false })

    -- (Optional) Make Copilot less intrusive
    vim.g.copilot_assume_mapped = true
    vim.g.copilot_tab_fallback = ''
  end,
}
