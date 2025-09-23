return {
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    config = function()
      require('toggleterm').setup {
        direction = 'float',
        float_opts = { border = 'curved' },
      }

      -- Atalhos rápidos
      vim.keymap.set('n', '<leader>ta', "<cmd>TermExec cmd='aichat'<cr>", { desc = 'Abrir Aichat' })
      -- vim.keymap.set('n', '<leader>tl', "<cmd>TermExec cmd='llm -m ollama:llama3'<cr>", { desc = 'Abrir LLM CLI' })
      -- vim.keymap.set('n', '<leader>ti', "<cmd>TermExec cmd='aider --model ollama:deepseek-coder'<cr>", { desc = 'Abrir Aider' })
    end,
  },
}
