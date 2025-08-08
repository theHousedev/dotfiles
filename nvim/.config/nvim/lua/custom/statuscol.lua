return {
  'luukvbaal/statuscol.nvim',
  config = function()
    -- local builtin = require("statuscol.builtin")
    require('statuscol').setup {
      text = { '%C' }, -- table of strings or functions returning a string
      click = 'v:lua.ScFa', -- %@ click function label, applies to each text element
      hl = 'FoldColumn', -- %# highlight group label, applies to each text element
      condition = { true }, -- table of booleans or functions returning a boolean
      fold = {
        width = 3, -- current width of the fold column
        -- 'fillchars' option values:
        close = '', -- foldclose
        open = '', -- foldopen
        sep = ' ', -- foldsep
      },
    }
  end,
}

-- return {
--   'luukvbaal/statuscol.nvim',
--   event = 'BufReadPre',
--   config = function()
--     local builtin = require 'statuscol.builtin'
--     require('statuscol').setup {
--       relculright = true,
--       ft_ignore = { 'neo-tree' },
--       segments = {
--         { sign = { name = { 'Dap' }, maxwidth = 1, auto = false }, click = 'v:lua.ScSa' },
--         { sign = { name = { 'todo*' }, maxwidth = 1 } },
--         {
--           sign = { namespace = { 'diagnostic' }, maxwidth = 1, auto = false },
--           click = 'v:lua.ScSa',
--         },
--         {
--           sign = { namespace = { 'gitsigns*' }, maxwidth = 1, colwidth = 2, auto = false },
--           click = 'v:lua.ScSa',
--         },
--         { text = { builtin.lnumfunc, '  ' }, click = 'v:lua.ScLa' },
--         { text = { builtin.foldfunc, ' ' }, click = 'v:lua.ScFa' },
--       },
--     }
--   end,
-- }
