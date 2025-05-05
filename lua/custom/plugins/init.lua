-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'pmizio/typescript-tools.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    opts = {},
    config = function()
      -- local api = require 'typescript-tools.api'
      require('typescript-tools').setup {
        --   handlers = {
        --     ['textDocument/publishDiagnostics'] = api.filter_diagnostics, -- Ignore 'This may be converted to an async function' diagnostics. { 80006 },
        --   },
        settings = {
          expose_as_code_action = 'all',
        },
      }
    end,
  },
  require 'custom.plugins.noice',
  {
    'github/copilot.vim',
  },
  require 'custom.plugins.flash',
  {
    'windwp/nvim-ts-autotag',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    event = 'InsertEnter',
    config = function()
      require('nvim-ts-autotag').setup()
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    event = 'VeryLazy',
    config = function()
      require('treesitter-context').setup {
        enable = true,
        max_lines = 0,
        trim_scope = 'outer',
        min_window_height = 0,
        line_numbers = true,
        mode = 'cursor',
        separator = nil,
      }
    end,
  },
  require 'custom.plugins.harpoon',
}
