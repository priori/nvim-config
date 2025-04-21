-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  'smoka7/hop.nvim',
  version = '*',
  opts = {
    keys = 'etovxqpdygfblzhckisuran',
  },
  config = function()
    local hop = require 'hop'
    local hint = require 'hop.hint'
    vim.keymap.set('', '<leader>1', function()
      hop.hint_char1 { current_line_only = false }
    end, { remap = true })
    vim.keymap.set('', '<leader>2', function()
      hop.hint_char2 { current_line_only = false }
    end, { remap = true })
    vim.keymap.set('', '<leader>f', function()
      hop.hint_words { current_line_only = false }
    end, { remap = true })

    vim.keymap.set('', 'f', function()
      hop.hint_char1 { direction = hint.HintDirection.AFTER_CURSOR, current_line_only = true }
    end, { remap = true })
    vim.keymap.set('', 'F', function()
      hop.hint_char1 { direction = hint.HintDirection.BEFORE_CURSOR, current_line_only = true }
    end, { remap = true })
    vim.keymap.set('', 't', function()
      hop.hint_char1 { direction = hint.HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 }
    end, { remap = true })
    vim.keymap.set('', 'T', function()
      hop.hint_char1 { direction = hint.HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 }
    end, { remap = true })

    hop.setup()
  end,
  {
    'windwp/nvim-ts-autotag',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    event = 'InsertEnter',
    config = function()
      require('nvim-ts-autotag').setup()
    end,
  },
}
