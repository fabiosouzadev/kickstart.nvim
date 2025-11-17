return {
  {
    'olimorris/codecompanion.nvim',
    event = 'VeryLazy',
    cmd = { 'CodeCompanion', 'CodeCompanionChat', 'CodeCompanionActions' },
    dependencies = {
      'j-hui/fidget.nvim', -- Display status
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      { 'echasnovski/mini.pick', config = true },
      { 'ibhagwan/fzf-lua', config = true },
      {
        'HakonHarnes/img-clip.nvim',
        opts = {
          filetypes = {
            codecompanion = {
              prompt_for_file_name = false,
              template = '[Image]($FILE_PATH)',
              use_absolute_path = true,
            },
          },
        },
      },
      'ravitemer/mcphub.nvim',
      {
        'MeanderingProgrammer/render-markdown.nvim',
        ft = { 'markdown', 'codecompanion' },
      },
    },
    init = function()
      vim.cmd [[cab cc CodeCompanion]]
      -- Carrega e inicializa o módulo fidget-spinner
      -- Verifica se o fidget.nvim está disponível
      local ok, _ = pcall(require, 'fidget.progress')
      if ok then
        local fidget_spinner = require 'custom.fidget-spinner'
        fidget_spinner:init()
      end
    end,
    opts = {
      -- NOTE: The log_level is in `opts.opts`
      opts = {
        log_level = 'DEBUG',
        language = 'Portuguese',
      },
      extensions = {
        mcphub = {
          callback = 'mcphub.extensions.codecompanion',
          opts = {
            make_vars = true,
            make_slash_commands = true,
            show_result_in_chat = true,
          },
        },
      },
      adapters = {
        http = {

          --- Qwen 2.5 ---
          ollamaqwen25coder05b = function()
            return require('codecompanion.adapters').extend('ollama', {
              name = 'ollamaqwen25coder05b', -- give this adapter a different name to differentiate it from the default ollama adapter
              opts = {
                vision = true,
                stream = true,
              },
              schema = {
                model = {
                  default = 'qwen2.5-coder:0.5b',
                },
                num_ctx = {
                  default = 2048,
                },
                -- keep_alive = {
                --   default = '5m',
                -- },
              },
            })
          end,

          ollamaqwen25coder15b = function()
            return require('codecompanion.adapters').extend('ollama', {
              name = 'ollamaqwen25coder15b', -- give this adapter a different name to differentiate it from the default ollama adapter
              opts = {
                vision = true,
                stream = true,
              },
              schema = {
                model = {
                  default = 'qwen2.5-coder:1.5b',
                },
                num_ctx = {
                  default = 4096,
                },
                keep_alive = {
                  default = '15m',
                },
              },
            })
          end,

          ollamaqwen25coder3b = function()
            return require('codecompanion.adapters').extend('ollama', {
              name = 'ollamaqwen25coder3b', -- give this adapter a different name to differentiate it from the default ollama adapter
              opts = {
                vision = true,
                stream = true,
              },
              schema = {
                model = {
                  default = 'qwen2.5-coder:3b',
                },
                num_ctx = {
                  default = 4096 * 2,
                },
                keep_alive = {
                  default = '15m',
                },
              },
            })
          end,

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

        acp = {
          gemini_cli = function()
            return require('codecompanion.adapters').extend('gemini_cli', {
              -- commands = {
              --   default = {
              --     'node',
              --     '/Users/Oli/Code/try/gemini-cli/packages/cli',
              --     '--experimental-acp',
              --   },
              -- },
              defaults = {
                auth_method = 'gemini-api-key',
                mcpServers = {},
                timeout = 20000, -- 20 seconds
              },
              env = {
                GEMINI_API_KEY = 'GEMINI_API_KEY',
              },
            })
          end,
        },
      },
      strategies = {
        chat = {
          adapter = 'ollamaqwen25coder15b',
        },
        inline = {
          adapter = 'ollamaqwen25coder15b',
        },
        cmd = {
          adapter = 'ollamaqwen25coder05b',
        },
      },
    },
    keys = {
      {
        '<C-a>',
        '<cmd>CodeCompanionActions<CR>',
        desc = 'Open the action palette',
        mode = { 'n', 'v' },
      },
      {
        '<Leader>a',
        '<cmd>CodeCompanionChat Toggle<CR>',
        desc = 'Toggle a chat buffer',
        mode = { 'n', 'v' },
      },
      {
        'ga',
        '<cmd>CodeCompanionChat Add<CR>',
        desc = 'Add code to a chat buffer',
        mode = { 'v' },
      },
    },
  },
  {
    'saghen/blink.cmp',
    optional = true,
    opts = function(_, opts)
      opts.sources.default = opts.sources.default or {}
      vim.list_extend(opts.sources.default, { 'codecompanion' })

      opts.sources.providers = vim.tbl_extend('keep', {
        codecompanion = {
          enabled = true,
          module = 'codecompanion.providers.completion.blink',
          name = 'CodeCompanion',
        },
      }, opts.sources.providers or {})
    end,
  },
}
