-- Add ascii.nvim as a dependency
return {
  'goolord/alpha-nvim',
  dependencies = {
    { 'nvim-tree/nvim-web-devicons' }, -- optional icons
    { 'MaximilianLloyd/ascii.nvim', dependencies = { 'MunifTanjim/nui.nvim' } },
  },
  config = function()
    local alpha = require 'alpha'
    local dashboard = require 'alpha.themes.dashboard'
    local ascii = require 'ascii'

    dashboard.section.header.val = ascii.get_random('movies', 'starwars')
    dashboard.section.buttons.val = {
      dashboard.button('e', '📝  New File', ':ene <BAR> startinsert<CR>'),
      dashboard.button('f', '🔍  Find File', ':Telescope find_files<CR>'),
      dashboard.button('r', '🕑  Recent Files', ':Telescope oldfiles<CR>'),
      dashboard.button('q', '❌  Quit', ':qa<CR>'),
    }

    dashboard.section.footer.val = '⚡ May the Source be with you ⚡'

    alpha.setup(dashboard.opts)
  end,
}
