local utils = require('utils')
local api = vim.api
local opt = vim.opt
local env = vim.env
local cmd = vim.cmd
local fn = vim.fn

local indent = 2
local XDG_DATA_HOME = env.XDG_DATA_HOME or env.HOME .. "/.local/share"
local backupdir = XDG_DATA_HOME .. "/nvim/backup//"
local swapdir = XDG_DATA_HOME .. "/nvim/swap//"
local undodir = XDG_DATA_HOME .. "/nvim/swap/"
local viewdir = XDG_DATA_HOME .. "/nvim/view//"

-- Create required folders
for _, d in pairs({ backupdir, swapdir, undodir, viewdir }) do
	fn.system("mkdir -p '" .. d .. "'")
end

local indents = {
	cabal = { expandtab = true },
	haskell = { expandtab = true },
	html = { autoindent = false },
	javascript = { expandtab = true, indent = 2, trim = true, autoindent = false },
	json = { expandtab = true, trim = true },
	php = { expandtab = true, trim = true, autoindent = true, indent = 4 },
	python = { expandtab = true },
	ruby = { indent = 2 },
	rust = { expandtab = true, trim = true },
	sql = { autoindent = false },
	xml = { expandtab = true, indent = 2, trim = true },
	yaml = { indent = 2 },
}

local indentgroup = {}

for k, v in pairs(indents) do
  utils.addIndentCommands(indentgroup, k, v)
end

-- Search
utils.opt('o', 'smartcase', true)
utils.opt('o', 'ignorecase', true)

-- Files
opt.fileencoding = "utf-8"
opt.fileencodings = "ucs-bom,utf-8"
opt.binary = true -- Allow binary file ediding without mangling to UTF-8
opt.eol = false -- Do not append linebreak at EOF
opt.backup = true -- Backup files
opt.undofile = true -- Save undo in files

-- Tabs and indent
opt.tabstop = indent
opt.shiftwidth = indent
opt.foldenable = false
utils.autogroup("indent", indentgroup)
-- cmd 'set smartindent'

-- We have to replace the list to avoid having backups in the current folder
opt.backupdir = { backupdir }
opt.directory = { swapdir }
opt.undodir = undodir
opt.viewdir = viewdir

utils.opt('o', 'hidden', true)
utils.opt('o', 'scrolloff', 4 )
utils.opt('o', 'shiftround', true)
utils.opt('o', 'splitbelow', true)
utils.opt('o', 'splitright', true)
utils.opt('o', 'wildmode', 'list:longest')
utils.opt('w', 'number', true)
utils.opt('w', 'relativenumber', false)
utils.opt('o', 'clipboard','unnamed,unnamedplus')

-- Highlight on yank
vim.cmd 'au TextYankPost * lua vim.highlight.on_yank {on_visual = false}'

-- Syntax
cmd 'filetype plugin indent on'
cmd 'syntax on'
cmd 'colorscheme snazzy'
vim.o.termguicolors = true


-- Global function for stripping whitespace from files
function _G.StripTrailingWhitespace()
	local c = api.nvim_win_get_cursor(0)

	cmd("%s/\\s\\+$//e")

	api.nvim_win_set_cursor(0, c)
end
