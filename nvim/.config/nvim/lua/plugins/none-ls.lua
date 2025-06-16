return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "williamboman/mason.nvim",
    "jay-babu/mason-null-ls.nvim",
  },
  config = function()
    local null_ls = require("null-ls")

    local formatting_augroup = vim.api.nvim_create_augroup("LspFormatting", { clear = true })

    null_ls.setup({
      sources = {
        -- Lua
        null_ls.builtins.formatting.stylua,

        -- JavaScript / TypeScript / React
        null_ls.builtins.diagnostics.eslint_d,
        null_ls.builtins.formatting.prettier,

        -- Python
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.isort,
        null_ls.builtins.diagnostics.flake8,
      },
      on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({ group = formatting_augroup, buffer = bufnr })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = formatting_augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ bufnr = bufnr })
            end,
          })
        end
      end,
    })

    require("mason-null-ls").setup({
      ensure_installed = {
        "prettier",
        "eslint_d",
        "black",
        "isort",
        "flake8",
        "stylua",
      },
      automatic_setup = true,
    })
  end,
}

