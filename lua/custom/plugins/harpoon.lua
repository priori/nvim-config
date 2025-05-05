return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local harpoon = require 'harpoon'
    harpoon:setup {
      settings = {
        save_on_toggle = true,
        sync_on_ui_close = false,
      },
    }
    harpoon:extend {
      UI_CREATE = function(cx)
        vim.keymap.set('n', '<Esc>', function()
          -- nop
        end, { buffer = cx.bufnr })
        vim.keymap.set('n', '<C-c>', function()
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end, { buffer = cx.bufnr })
      end,
    }

    vim.keymap.set('n', '<leader>a', function()
      harpoon:list():add()
    end)

    vim.keymap.set('n', '<C-g>', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end)

    vim.keymap.set('n', '<C-h>', function()
      harpoon:list():select(1)
    end)
    vim.keymap.set('n', '<C-j>', function()
      harpoon:list():select(2)
    end)
    vim.keymap.set('n', '<C-k>', function()
      harpoon:list():select(3)
    end)
    vim.keymap.set('n', '<C-l>', function()
      harpoon:list():select(4)
    end)

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set('n', '<Tab>', function()
      harpoon:list():prev()
    end)
    vim.keymap.set('n', '<S-Tab>', function()
      harpoon:list():next()
    end)
  end,
}
