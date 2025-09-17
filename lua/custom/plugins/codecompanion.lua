return {
  'olimorris/codecompanion.nvim',
  opts = {
    adapters = {
      http = {
        openrouter = function()
          return require('codecompanion.adapters').extend('openai_compatible', {
            env = {
              url = 'https://openrouter.ai/api',
              api_key = 'OPENROUTER_API_KEY',
              chat_url = '/v1/chat/completions',
            },
            schema = {
              model = {
                default = 'moonshotai/kimi-dev-72b:free',
              },
            },
          })
        end,
      },
    },
    strategies = {
      chat = {
        adapter = 'openrouter',
        model = 'moonshotai/kimi-dev-72b:free',
      },
      inline = {
        adapter = 'openrouter',
      },
      cmd = {
        adapter = 'openrouter',
        model = 'moonshotai/kimi-dev-72b:free',
      },
    },
    -- NOTE: The log_level is in `opts.opts`
    opts = {
      log_level = 'DEBUG',
    },
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    'j-hui/fidget.nvim', -- Display status
    -- { "echasnovski/mini.pick", config = true },
    -- { "ibhagwan/fzf-lua", config = true },
  },
}
