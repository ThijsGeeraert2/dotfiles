return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      'saghen/blink.cmp',
      {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
    config = function()
      local capabilities = require('blink.cmp').get_lsp_capabilities()
      require("mason").setup()
      require("mason-lspconfig").setup()
      require("mason-lspconfig").setup_handlers {
        function (server_name) -- default handler (optional)
          require("lspconfig")[server_name].setup {
            capabilities = capabilities,
            settings = {
              Lua = {
                diagnostics = { globals = {'vim'} } -- to remove the unkown global 'vim' warning
              }
            }
          }
        end
      }
    end
  }
}
