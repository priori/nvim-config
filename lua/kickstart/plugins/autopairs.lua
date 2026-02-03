-- autopairs
-- https://github.com/windwp/nvim-autopairs

return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  opts = {},
  config = function(_, opts)
    local npairs = require 'nvim-autopairs'

    -- Run default setup first
    npairs.setup(opts)

    -- Remove pairs the user doesn't want to auto-complete
    npairs.remove_rule('"')
    npairs.remove_rule('{')
    npairs.remove_rule('[')
    npairs.remove_rule('(')
    npairs.remove_rule('`')
    npairs.remove_rule("'")
  end,
}
