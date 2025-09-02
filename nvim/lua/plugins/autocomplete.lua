return {
  {
    "saadparwaiz1/cmp_luasnip", -- Snippet source
    "L3MON4D3/LuaSnip",         -- Snippet engine
  },
  {
    "hrsh7th/nvim-cmp",  -- Autocompletion plugin
    dependendencies = {
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },
    config = function()
      -- See `:help cmp`
      local cmp = require "cmp"

      cmp.setup {
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        auto_brackets = {},
        completion = { completeopt = "menu,menuone,noinsert" },

        mapping = cmp.mapping.preset.insert {
          -- Select the [n]ext/[p]revious item
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-p>"] = cmp.mapping.select_prev_item(),

          -- Scroll the documentation window [b]ack/[f]orward
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),

          -- Accept ([y]es) or [e]xit the completion.
          --  This will auto-import if your LSP supports it.
          --  This will expand snippets if the LSP sent a snippet.
          ["<CR>"] = cmp.mapping.confirm { select = true },
          ["<C-e>"] = cmp.mapping.abort(),

          -- Manually trigger a completion from nvim-cmp.
          ["<C-Space>"] = cmp.mapping.complete {},

          -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
          --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
        },
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" },
          { name = "buffer", option = { keyword_length = 3, }, },
        },
      }

    end
  }
}
