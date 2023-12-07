local config = require("plugins.configs.lspconfig")
local on_attach =config.on_attach
local capabilities =config.capabilities

local lspconfig =require("lspconfig")
local util = require("lspconfig/util")

local function organize_imports()
  local params = {
    command ="_typescript.organizeImports",
    arguments = {vim.api.nvim_buf_get_name(0)},

  }
  vim.lsp.buf.execute_command(params)
end

lspconfig.jdtls.setup{
  cmd={"jdtls"}
}

lspconfig.tailwindcss.setup{
  cmd= { "tailwindcss-language-server", "--stdio" },
  filetypes= { "aspnetcorerazor", "astro", "astro-markdown", "blade", "clojure", "django-html", "htmldjango", "edge", "eelixir", "elixir", "ejs", "erb", "eruby", "gohtml", "gohtmltmpl", "haml", "handlebars", "hbs", "html", "html-eex", "heex", "jade", "leaf", "liquid", "markdown", "mdx", "mustache", "njk", "nunjucks", "php", "razor", "slim", "twig", "css", "less", "postcss", "sass", "scss", "stylus", "tsx", "ts", "sugarss", "javascript", "javascriptreact", "reason", "rescript", "typescript", "typescriptreact", "vue", "svelte" },
  init_options= {
  userLanguages = {
    eelixir = "html-eex",
    eruby = "erb"
  }
},
  root_dir=util.root_pattern('tailwind.config.js', 'tailwind.config.cjs', 'tailwind.config.mjs', 'tailwind.config.ts', 'postcss.config.js', 'postcss.config.cjs', 'postcss.config.mjs', 'postcss.config.ts', 'package.json', 'node_modules', '.git'),
  settings={
  tailwindCSS = {
    classAttributes = { "class", "className", "class:list", "classList", "ngClass" },
    lint = {
      cssConflict = "warning",
      invalidApply = "error",
      invalidConfigPath = "error",
      invalidScreen = "error",
      invalidTailwindDirective = "error",
      invalidVariant = "error",
      recommendedVariantOrder = "warning"
    },
    validate = true
  }
},
}
lspconfig.gopls.setup{
  on_attach= on_attach,
  capabilities= capabilities,
  cmd= {"gopls"},
  filetypes= {"go","gomod","gowork","gotmpl"},
  root_dir= util.root_pattern("go.work", "go.mod", ".git"),
  settings= {
    gopls={
      completeUnimported=true,
      usePlaceHolders=true,
      analyses={
        unusedparams=true
      }
    },
  }
}

lspconfig.clangd.setup{
  on_attach=function (client, bufnr)
    client.server_capabilities.signatureHelpProvider=false
    on_attach(client, bufnr)
  end,
  capabilities= capabilities,
  filetypes= {"cpp", "hpp", "h", "c"}
}

lspconfig.tsserver.setup{
  on_attach= on_attach,
  capabilities=capabilities,
  init_options= {
    prefrences={
      disableSuggestions=true,
    }
  },
  commands ={
    OrganizeImports = {
      organize_imports,
      description = "Organize Imports",
    }
  }
}
