return {
  -- Mason configuration for LSP server management
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
          }
        }
      })
    end
  },

  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    lazy = false,
    config = function()
      require("mason-lspconfig").setup {
        ensure_installed = { 'clangd', 'rust_analyzer', 'bashls', 'lua_ls', 'marksman', 'pylsp', 'jsonls', 'texlab', 'omnisharp' },
        automatic_installation = true,
        handlers = {
          function(server_name)
            local opts = {}

            if server_name == "clangd" then
              opts.cmd = {
                "clangd",
                "--background-index",
                "--suggest-missing-includes",
                "--clang-tidy",
                "--header-insertion=iwyu",
                "--header-insertion-decorators"
              }
            elseif server_name == "lua_ls" then
              opts.settings = {
                Lua = {
                  diagnostics = { globals = { 'vim', 'bufnr' } },
                  workspace = {
                    library = vim.api.nvim_get_runtime_file("", true),
                    checkThirdParty = false,
                  },
                  telemetry = { enable = false },
                },
              }
            elseif server_name == "pylsp" then
              opts.settings = {
                pylsp = {
                  plugins = {
                    pycodestyle = { maxLineLength = 140 },
                  },
                },
              }
            elseif server_name == "omnisharp" then
              opts.cmd = {
                "env", "VINTAGE_STORY=" .. os.getenv("VINTAGE_STORY"),
                "dotnet",
                vim.fn.stdpath("data") .. "/mason/packages/omnisharp/libexec/OmniSharp.dll",
                "--languageserver",
                "--hostPID", tostring(vim.fn.getpid())
              }
              opts.settings = {
                omnisharp = {
                  useGlobalMono = "always",
                  enableRoslynAnalyzers = true,
                  enableEditorConfigSupport = true,
                  analyzeOpenDocumentsOnly = false,
                  MsBuild = {
                    LoadProjectsOnDemand = false,
                    ProvideSearchPaths = true,
                  },
                  FormattingOptions = {
                    EnableEditorConfigSupport = true
                  }
                }
              }
            end

            require("lspconfig")[server_name].setup(opts)
          end,
        }
      }
    end,
  },

  -- LuaSnip configuration
  {
    "L3MON4D3/LuaSnip",
    lazy = false,
    dependencies = {
      "rafamadriz/friendly-snippets",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },

  -- nvim-lspconfig for setting up LSP servers
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/nvim-cmp",
    },
    lazy = false,
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then return end

          if client.supports_method('textDocument/formatting') then
            vim.api.nvim_create_autocmd('BufWritePre', {
              buffer = args.buf,
              callback = function()
                vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
              end,
            })
          end
        end,
      })
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
    end,
  },

  {
    "folke/neodev.nvim",
    lazy = false,
    config = function()
      require("neodev").setup({
        library = { plugins = { "nvim-treesitter" }, types = true },
      })
    end,
  },
}

