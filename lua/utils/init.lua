local utils = { }

local scopes = {o = vim.o, b = vim.bo, w = vim.wo}

function utils.opt(scope, key, value)
    scopes[scope][key] = value
    if scope ~= 'o' then scopes['o'][key] = value end
end

function utils.map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Use an autogroup to avoid multiple groups being registered

function utils.autogroup(name, commands)
	vim.cmd("augroup " .. name)
	vim.cmd("autocmd!")

	for _, line in ipairs(commands) do
		local command = table.concat(vim.tbl_flatten{ "autocmd", line }, " ")

		vim.cmd(command)
	end

	vim.cmd("augroup END")
end

function utils.addIndentCommands(autogroup, filetype, config)
	setmetatable(config, { __index = {
		indent = nil,
		expandtab = false,
		trim = false,
		autoindent = true,
	} } )

	if config.indent then
		table.insert(autogroup, {"FileType", filetype, "setlocal", "shiftwidth=" .. config.indent, "tabstop=" .. config.indent})
	end

	if config.expandtab then
		table.insert(autogroup, {"FileType", filetype, "setlocal", "expandtab"})
	end

	if config.trim then
		table.insert(autogroup, {"FileType", filetype, "autocmd", "BufWritePre", "<buffer>", "lua StripTrailingWhitespace()"})
	end

	if not config.autoindent then
		table.insert(autogroup, {"FileType", filetype, "setlocal", "indentexpr="})
	end
end

-- Context sensitive format function
function utils.format()
  if vim.bo.filetype == 'rust' then
    vim.cmd('RustFmt')
  else
    vim.cmd('CocCommand prettier.forceFormatDocument')
  end
end

return utils

