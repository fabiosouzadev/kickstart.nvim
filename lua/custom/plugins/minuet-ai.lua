return {
  {
    'milanglacier/minuet-ai.nvim',
    config = function()
      require('minuet').setup {
        blink = {
          enable_auto_complete = false,
        },
        virtualtext = {
          -- auto_trigger_ft = { 'typescript', 'javascript', 'python' },
          keymap = {
            -- accept whole completion
            accept = '<A-A>',
            -- accept one line
            accept_line = '<A-a>',
            -- accept n lines (prompts for number)
            -- e.g. "A-z 2 CR" will accept 2 lines
            accept_n_lines = '<A-z>',
            -- Cycle to prev completion item, or manually invoke completion
            prev = '<A-[>',
            -- Cycle to next completion item, or manually invoke completion
            next = '<A-]>',
            dismiss = '<A-e>',
          },
        },
        --- Providers ----
        provider = 'gemini', -- Ollama
        -- provider = 'gemini', -- Gemini
        notify = 'debug',
        -- notify = 'warn',
        request_timeout = 10,
        -- throttle = 2000,
        -- n_completions = 1,
        -- context_window = 4096,
        add_single_line_entry = false,
        provider_options = {

          -- Ollama --
          openai_fim_compatible = {
            api_key = 'TERM',
            name = 'ollama-local',
            end_point = 'http://localhost:11434/v1/completions',
            -- model = 'qwen2.5-coder:3b',
            -- model = 'qwen2.5-coder:1.5b',
            model = 'qwen2.5-coder:0.5b',
            optional = {
              max_tokens = 64,
              top_p = 0.9,
              stop = { '<|endoftext|>' },
            },
          },

          -- Ollama BFF --
          -- openai_fim_compatible = {
          --   api_key = 'TERM',
          --   name = 'Ollama',
          --   end_point = 'http://localhost:11434/v1/completions',
          --   -- model = 'qwen2.5-coder:3b',
          --   -- model = 'qwen2.5-coder:1.5b',
          --   model = 'qwen2.5-coder:0.5b',
          --   optional = {
          --     max_tokens = 64,
          --     top_p = 0.9,
          --   },
          -- },
          --

          -- Gemini --
          gemini = {
            model = 'gemini-2.5-flash-lite',
            optional = {
              generationConfig = {
                maxOutputTokens = 256,
                -- When using `gemini-2.5-flash`, it is recommended to entirely
                -- disable thinking for faster completion retrieval.
                thinkingConfig = {
                  thinkingBudget = 0,
                },
              },
              safetySettings = {
                {
                  -- HARM_CATEGORY_HATE_SPEECH,
                  -- HARM_CATEGORY_HARASSMENT
                  -- HARM_CATEGORY_SEXUALLY_EXPLICIT
                  category = 'HARM_CATEGORY_DANGEROUS_CONTENT',
                  -- BLOCK_NONE
                  threshold = 'BLOCK_ONLY_HIGH',
                },
              },
            },
          },

          -- Gemini --
          -- request_timeout = 2.5,
          -- throttle = 1500, -- Increase to reduce costs and avoid rate limits
          -- debounce = 600, -- Increase to reduce costs and avoid rate limits

          -- openai_compatible = {
          --   api_key = 'AIML_API_KEY',
          --   end_point = 'https://api.aimlapi.com/v1/chat/completions',
          --   model = 'google/gemma-3-12b-it',
          --   name = 'AIML',
          --   optional = {
          --     max_tokens = 56,
          --     top_p = 0.9,
          --     provider = {
          --       -- Prioritize throughput for faster completion
          --       sort = 'throughput',
          --     },
          --   },
          -- },
          --

          -- CHUTES --
          -- openai_compatible = {
          --   model = 'openai/gpt-oss-20b',
          --   stream = true,
          --   end_point = 'https://llm.chutes.ai/v1/chat/completions',
          --   api_key = 'CHUTES_API_KEY',
          --   name = 'Chutes',
          --   optional = {
          --     stop = nil,
          --     max_tokens = 256,
          --     -- pass any additional parameters you want to send to OpenAI request,
          --     -- e.g.
          --     -- stop = { 'end' },
          --     -- max_completion_tokens = 256,
          --     top_p = 0.9,
          --     reasoning_effort = 'low',
          --     -- reasoning_effort = 'none'
          --   },
          -- },
          --

          -- Openrouter --
          openai_compatible = {
            api_key = 'OPENROUTER_API_KEY',
            end_point = 'https://openrouter.ai/api/v1/chat/completions',
            model = 'moonshotai/kimi-k2:free',
            name = 'Openrouter',
            optional = {
              max_tokens = 64,
              top_p = 0.9,
              provider = {
                -- Prioritize throughput for faster completion
                sort = 'throughput',
              },
            },
          },

          -- Providers --
        },
      }
    end,
  },
  {
    'saghen/blink.cmp',
    optional = true,
    opts = function(_, opts)
      opts.sources.default = opts.sources.default or {}
      vim.list_extend(opts.sources.default, { 'minuet' })

      opts.sources.providers = vim.tbl_extend('keep', {
        minuet = {
          name = 'minuet',
          module = 'minuet.blink',
          async = true,
          -- timeout_ms = 3000,
          score_offset = 100,
        },
      }, opts.sources.providers or {})

      opts.completion = vim.tbl_extend('keep', {
        trigger = { prefetch_on_insert = false },
      }, opts.completion or {})

      opts.keymap = vim.tbl_extend('keep', {
        ['<A-y>'] = require('minuet').make_blink_map(),
      }, opts.keymap or {})
    end,
  },
}
