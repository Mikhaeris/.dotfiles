return {
  'oribarilan/lensline.nvim',
  enabled = false,
  branch = 'release/2.x',
  event = 'LspAttach',
  config = function()
    require('lensline').setup {
      profiles = {
        {
          name = 'minimal',
          style = {
            placement = 'inline',
            prefix = '',
          },
        },
      },
      debug_mode = false,
    }
  end,}
