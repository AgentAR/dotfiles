local plugins ={
  {
    'nvim-neorg/neorg',
    ft = 'norg', -- lazy load on filetype
    cmd = 'Neorg', -- lazy load on command, allows you to autocomplete :Neorg regardless of whether it's loaded yet
    --  (you could also just remove both lazy loading things)
    priority = 30, -- treesitter is on default priority of 50, neorg should load after it.
    config = function()
      require('neorg').setup {
        load = {
        ["core.defaults"] = {}, -- Loads default behaviour
        ["core.concealer"] = {}, -- Adds pretty icons to your documents
    ["core.keybinds"] = {
    config = {        
              default_keybinds = true,
            }
          },
        ["core.dirman"] = { -- Manages Neorg workspaces
          config = {
            workspaces = {
              dev = "~/notes/dev",
              study = "~/notes/study",
              stuff = "~/notes/stuff",
            },
            default_workspace= "stuff",
          },
    }}}
    end
  },
  {
    "christoomey/vim-tmux-navigator",
    lazy=false,
  },
 {
    "simrat39/rust-tools.nvim",
    ft="rust",
    dependencies= "neovim/nvim-lspconfig",
    opts =function ()
      return require "custom.configs.rust-tools"
    end,
    config = function (_, opts)
      require("rust-tools").setup(opts)
    end
  },
  {
    "rust-lang/rust.vim",
    ft="rust",
    init =function ()
      vim.g.rustfmt_autosave = 1
    end
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    event= "VeryLazy",
    opts= function ()
      return require "custom.configs.null-ls"
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = "mfussenegger/nvim-dap",
    config = function ()
      local dap =require("dap")
      local dapui =require("dapui")
      require("dapui").setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end
  },
  {
    "mfussenegger/nvim-dap",
    config=function ()
      require "custom.configs.dap"
      require("core.utils").load_mappings("dap")
    end
  },
  {
    "mhartington/formatter.nvim",
    event= "VeryLazy",
    opts = function ()
      return require "custom.configs.formatter"
    end
  },
  {
    "mfussenegger/nvim-lint",
    event= "VeryLazy",
    config = function ()
      require "custom.configs.lint"
    end
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed={
        "typescript-language-server",
        "js-debug-adapter",
        "eslint-lsp",
        "prettier",
        "clangd",
        "clang-format",
        "codelldb",
        "rust-analyzer",
        "gopls",
        "jdtls"
      }
    }
  },
  {
    "neovim/nvim-lspconfig",
     opts = {
            setup = {
                -- disable jdtls config from lspconfig
                jdtls = function()
                    return true
                end,
            },
    },
    config=function ()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end
  },
}
return plugins
