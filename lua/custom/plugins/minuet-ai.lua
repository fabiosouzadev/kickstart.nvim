return {
  {
    'milanglacier/minuet-ai.nvim',
    config = function()
      require('minuet').setup {
        -- Your configuration options here
        virtualtext = {
          auto_trigger_ft = { 'typescript' },
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
        provider = 'openai_fim_compatible', -- Ollama
        -- provider = 'gemini', -- Gemini
        n_completions = 1, -- recommend for local model for resource saving
        -- I recommend beginning with a small context window size and incrementally
        -- expanding it, depending on your local computing power. A context window
        -- of 512, serves as an good starting point to estimate your computing
        -- power. Once you have a reliable estimate of your local computing power,
        -- you should adjust the context window to a larger value.
        context_window = 512,
        provider_options = {
          -- Ollama --
          openai_fim_compatible = {
            api_key = 'TERM',
            name = 'Ollama',
            end_point = 'http://localhost:11434/v1/completions',
            -- model = 'qwen2.5-coder:3b',
            model = 'qwen2.5-coder:1.5b',
            -- model = 'qwen2.5-coder:0.5b',
            optional = {
              max_tokens = 56,
              top_p = 0.9,
            },
          },
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
          openai_compatible = {
            api_key = 'OPENROUTER_API_KEY',
            end_point = 'https://openrouter.ai/api/v1/chat/completions',
            model = 'moonshotai/kimi-k2',
            name = 'Openrouter',
            optional = {
              max_tokens = 56,
              top_p = 0.9,
              provider = {
                -- Prioritize throughput for faster completion
                sort = 'throughput',
              },
            },
          },
        },
        -- Providers --
      }
    end,
  },
  {
    'saghen/blink.cmp',
    optional = true,
    opts = {
      keymap = {
        ['<A-y>'] = {
          function(cmp)
            cmp.show { providers = { 'minuet' } }
          end,
        },
      },
      sources = {
        -- if you want to use auto-complete
        -- default = { 'minuet' },
        providers = {
          minuet = {
            name = 'minuet',
            module = 'minuet.blink',
            async = true,
            timeout_ms = 3000,
            score_offset = 50,
          },
        },
      },
      completion = { trigger = { prefetch_on_insert = false } },
    },
  },
}
