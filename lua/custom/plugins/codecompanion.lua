-- lazy.nvim
return {
  'olimorris/codecompanion.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  opts = {
    -- NOTE: The log_level is in `opts.opts`
    opts = {
      language = 'portuguese',
      log_level = 'DEBUG', -- or "TRACE"
    },
    display = {
      chat = {
        show_settings = true,
      },
    },
    strategies = {
      chat = { adapter = 'gemini' },
      inline = {
        adapter = 'gemini',
        layout = 'horizontal',
        keymaps = {
          accept_change = { modes = { n = 'ga' }, description = 'Accept the suggested change' },
          reject_change = { modes = { n = 'gx' }, description = 'Reject the suggested change' },
        },
      },
      agent = { adapter = 'gemini' },
      cmd = {
        adapter = 'gemini',
      },
    },
  },
  keys = {
    { '<leader>[', '<cmd>CodeCompanionActions<cr>', desc = 'CodeCompanion Action' },
    { '<leader>cc', '<cmd>CodeCompanionChat Toggle<cr>', desc = 'CodeCompanion Toggle' },
  },
}
