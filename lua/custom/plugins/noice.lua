return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  opts = {
    -- add any options here
  },
  config = function()
    require('noice').setup {
      routes = {
        {
          filter = {
            event = 'msg_show',
            kind = '',
            any = {

              { find = 'no lines in buffer' },
              -- Edit
              { find = '%d+ less lines' },
              { find = '%d+ fewer lines' },
              { find = '%d+ more lines' },
              { find = '%d+ change;' },
              { find = '%d+ line less;' },
              { find = '%d+ more lines?;' },
              { find = '%d+ fewer lines;?' },
              { find = '".+" %d+L, %d+B' },
              { find = '%d+ lines yanked' },
              { find = '^Hunk %d+ of %d+$' },
              { find = '%d+L, %d+B$' },
              { find = '^[/?].*' }, -- Searching up/down
              { find = 'E486: Pattern not found:' }, -- Searcingh not found
              { find = '%d+ changes?;' }, -- Undoing/redoing
              { find = '%d+ fewer lines' }, -- Deleting multiple lines
              { find = '%d+ more lines' }, -- Undoing deletion of multiple lines
              { find = '%d+ lines ' }, -- Performing some other verb on multiple lines
              { find = 'Already at newest change' }, -- Redoing
              { find = '"[^"]+" %d+L, %d+B' }, -- Saving

              -- Save
              { find = ' bytes written' },

              -- Redo/Undo
              { find = ' changes; before #' },
              { find = ' changes; after #' },
              { find = '1 change; before #' },
              { find = '1 change; after #' },

              -- Yank
              { find = ' lines yanked' },

              -- Move lines
              { find = ' lines moved' },
              { find = ' lines indented' },

              -- Bulk edit
              { find = ' fewer lines' },
              { find = ' more lines' },
              { find = '1 more line' },
              { find = '1 line less' },

              -- General messages
              { find = 'Already at newest change' }, -- Redoing
              { find = 'Already at oldest change' },
            },
          },
          opts = { skip = true },
        },
      },
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
        },
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        -- command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
      },
    }
    vim.keymap.set('n', '<C-c>', function()
      vim.cmd 'Noice dismiss'
      vim.cmd 'nohlsearch'
    end)

    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'noice',
      callback = function()
        vim.keymap.set('i', '<Esc>', '<Nop>', { buffer = true })
        vim.keymap.set('n', '<Esc>', '<Nop>', { buffer = true })
        vim.keymap.set('i', '<C-k>', '<Up>', { buffer = true })
        vim.keymap.set('i', '<C-j>', '<Down>', { buffer = true })
      end,
    })
  end,
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    'MunifTanjim/nui.nvim',
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    'rcarriga/nvim-notify',
  },
}
