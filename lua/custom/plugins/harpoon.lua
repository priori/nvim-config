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
        vim.keymap.set({ 'n', 'v' }, '<Esc>', function()
          -- nop
        end, { buffer = cx.bufnr })
        vim.keymap.set({ 'n', 'v' }, '<C-c>', function()
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end, { buffer = cx.bufnr })
      end,
    }

    vim.keymap.set('n', '<leader>a', function()
      local list = harpoon:list()
      list:add()
      vim.defer_fn(function()
        local lines = {}
        for i, item in ipairs(list.items) do
          table.insert(lines, i .. '. ' .. item.value)
        end
        local message = table.concat(lines, '\n')
        require('noice').notify(message, 'info', { title = '󰈙 Harpoon' })
      end, 10)
    end, { desc = 'Add file to Harpoon' })

    vim.keymap.set('n', '<C-g>', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end)

    vim.keymap.set('n', '<leader>1', function()
      harpoon:list():select(1)
    end)
    vim.keymap.set('n', '<leader>2', function()
      harpoon:list():select(2)
    end)
    vim.keymap.set('n', '<leader>3', function()
      harpoon:list():select(3)
    end)
    vim.keymap.set('n', '<leader>4', function()
      harpoon:list():select(4)
    end)
    vim.keymap.set('n', '<leader>5', function()
      harpoon:list():select(5)
    end)
    vim.keymap.set('n', '<leader>6', function()
      harpoon:list():select(6)
    end)

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set('n', '<leader><Tab>', function()
      harpoon:list():next()
    end)
    vim.keymap.set('n', '<leader><S-Tab>', function()
      harpoon:list():prev()
    end)
  end,
}
