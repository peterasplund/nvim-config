-- Set up all LSP clients and handle settings
-- lsp_defaults as global settings and then overrides in local ones

local lspconfig = require('lspconfig')

local lsp_defaults = {
  flags = {
    debounce_text_changes = 150,
  },
  capabilities = require('cmp_nvim_lsp').default_capabilities(
    vim.lsp.protocol.make_client_capabilities()
  ),
  on_attach = function(client, bufnr)
    vim.api.nvim_exec_autocmds('User', {pattern = 'LspAttached'})
  end
}

lspconfig.util.default_config = vim.tbl_deep_extend(
  'force',
  lspconfig.util.default_config,
  lsp_defaults
)

if not lspconfig.emmet_ls then
  configs.emmet_ls = {
    default_config = {
      cmd = {'emmet-ls', '--stdio'};
      filetypes = {'scss', 'css'};
      snippetSupport = true;
      root_dir = function(_)
        return vim.loop.cwd()
      end;
      settings = {};
    };
  }
end

lspconfig.efm.setup{
	filetypes = {"lua", "python", "javascriptreact", "javascript", "sh", "html", "css", "yaml", "markdown"},
}

lspconfig.emmet_ls.setup{}

lspconfig.flow.setup{}

lspconfig.psalm.setup{
	cmd = {"x", "psalm", "--language-server"},
}

lspconfig.rust_analyzer.setup({
	settings = {
		["rust-analyzer"] = {
			assist = {
				importGranularity = "module",
				importPrefix = "self",
			},
			cargo = {
				loadOutDirsFromCheck = true
			},
			procMacro = {
				enable = true
			},
			checkOnSave = {
					allFeatures = true,
					overrideCommand = {
							'cargo', 'clippy', '--workspace', '--message-format=json',
							'--all-targets', '--all-features'
					}
			},
		}
	}
})

lspconfig.tsserver.setup({
	filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
	on_attach = function(client, bufnr)
		vim.api.nvim_exec_autocmds('User', {pattern = 'LspAttached'})

		--[[
		client.resolved_capabilities.document_formatting = false
		client.resolved_capabilities.document_range_formatting = false
		local ts_utils = require("nvim-lsp-ts-utils")
		ts_utils.setup({})
		ts_utils.setup_client(client)
		on_attach(client, bufnr)
		--]]
	end,
	
})

--require'lspconfig'.pyright.setup{}

--[[
if not lspconfig.xo_custom then
  configs.xo_custom = {
    default_config = {
      cmd = {'xo', '--stdio'};
      filetypes = {'js', 'jsx'};
      root_dir = function(_)
        return vim.loop.cwd()
      end;
      settings = {};
    };
  }
end

lspconfig.xo_custom.setup{}
--]]

lspconfig.gdscript.setup{
	on_attach = on_attach,
  flags = {
    debounce_text_changes = 250,
  },
}

lspconfig.ccls.setup{
	on_attach = on_attach,
}
