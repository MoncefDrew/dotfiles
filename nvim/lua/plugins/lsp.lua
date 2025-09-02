return {
  'neovim/nvim-lspconfig',
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    -- custom hover
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
      vim.lsp.handlers.hover,
      { border = "single" }
    )

    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    local lsp_keymaps = function()
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {buffer = 0})
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, {buffer = 0})
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {buffer = 0})
      vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, {buffer = 0})
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {buffer = 0})
      vim.keymap.set("n", "<leader>df", vim.diagnostic.goto_next, {buffer = 0})
      vim.keymap.set("n", "<leader>dp", vim.diagnostic.goto_prev, {buffer = 0})
      vim.keymap.set("n", "<leader>dl", "<cmd>Telescope diagnostics<cr>", {buffer = 0})
      vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, {buffer = 0})
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {buffer = 0})
      vim.keymap.set("n", "<leader>fr", require("telescope.builtin").lsp_references, {buffer = 0})
      vim.keymap.set("n", "<leader>e", function()
        vim.diagnostic.open_float(nil, {focusable = false, scope = "line", max_width = 80, border = "single"})
      end, {buffer = 0})
    end
    require'lspconfig'.clangd.setup{
      capabilities = capabilities,
      on_attach = lsp_keymaps,
      cmd = { "clangd", "--compile-commands-dir=build" },
      root_dir = require("lspconfig.util").root_pattern("compile_commands.json", ".git"),
    }
    require'lspconfig'.gopls.setup{
      capabilities = capabilities,
      on_attach = lsp_keymaps,
    }
    require'lspconfig'.pyright.setup{
      capabilities = capabilities,
      on_attach = lsp_keymaps,
    }
  end,
}
