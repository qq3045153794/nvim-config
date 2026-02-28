-- require("mason").setup({
--     ui = {
--         icons = {
--             package_installed = "✓",
--             package_pending = "➜",
--             package_uninstalled = "✗"
--         }
--     }
-- })
--
-- local lspconfig = require('lspconfig')
--
-- require("mason-lspconfig").setup {
--     ensure_installed = { "clangd", "jsonls", "pyright", "lua_ls" },
--     -- ensure_installed = { "clangd", "pyright", "lua_ls" },
--     automatic_installation = true,
--     -- jsonls 配置（语法检查 + schema 提示）
--     ["jsonls"] = function ()
--       lspconfig.jsonls.setup {
--         settings = {
--           json = {
--             validate = { enable = true },
--             format = { enable = true },
--             schemas = require('schemastore').json.schemas(), -- 需要安装 b0o/schemastore.nvim
--           }
--         }
--       }
--     end
-- }


-- local lspconfig = require('lspconfig')
--
-- require("mason-lspconfig").setup_handlers({
--     function (server_name)
--         require("lspconfig")[server_name].setup {}
--     end,
--     ["clangd"] = function ()
--       lspconfig.clangd.setup {
--         cmd = {
--         "clangd",
--         "--background-index",
--         "--compile-commands-dir=build",  -- ${workspaceFolder}/build 需改为相对路径
--         "-j=4",
--         "--clang-tidy",
--         "--clang-tidy-checks=performance-*,bugprone-*",
--         "--all-scopes-completion",
--         "--completion-style=detailed",
--         "--header-insertion=iwyu",
--         "--pch-storage=disk",
--         -- "--compile-args=-msse,-msse2"  -- $屏蔽opencv SIMD报错
--         }
--       }
--     end
-- })

require("mason").setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
})

require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    "clangd", "jsonls", "pyright", "lua_ls",
    "ts_ls",       -- TS/JS 核心 (原 tsserver)
    "eslint",      -- Lint 工具
    "tailwindcss", -- Tailwind CSS (如果用的话)
    "cssls",       -- CSS
    "html",        -- HTML
  },
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require("lspconfig")

require("mason-lspconfig").setup_handlers({
  function(server_name)
    lspconfig[server_name].setup({ capabilities = capabilities })
  end,

  ["jsonls"] = function()
    lspconfig.jsonls.setup({
      capabilities = capabilities,
      settings = {
        json = {
          validate = { enable = true },
          format = { enable = true },
          schemas = {},
        },
      },
    })
  end,
})
