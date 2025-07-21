-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

-- General
opt.termguicolors = true
opt.background = "dark"
opt.clipboard = "unnamedplus"
opt.completeopt = "menu,menuone,noselect"
opt.conceallevel = 2
opt.confirm = true
opt.cursorline = true
opt.expandtab = true
opt.formatoptions = "jcroqlnt"
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.ignorecase = true
opt.inccommand = "nosplit"
opt.laststatus = 3
opt.list = true
opt.mouse = "a"
opt.number = true
opt.pumblend = 10
opt.pumheight = 10
opt.relativenumber = true
opt.scrolloff = 4
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
opt.shiftround = true
opt.shiftwidth = 2
opt.shortmess:append({ W = true, I = true, c = true, C = true })
opt.showmode = false
opt.sidescrolloff = 8
opt.signcolumn = "yes"
opt.smartcase = true
opt.smartindent = true
opt.spelllang = { "en" }
opt.splitbelow = true
opt.splitkeep = "screen"
opt.splitright = true
opt.tabstop = 2
opt.timeoutlen = 300
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200
opt.virtualedit = "block"
opt.wildmode = "longest:full,full"
opt.winminwidth = 5
opt.wrap = false

-- Hyprland specific settings
opt.title = true
opt.titlestring = "%t - Neovim"

-- Better file handling
opt.backup = false
opt.writebackup = false
opt.swapfile = false

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0

-- GitHub Copilot settings
vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
vim.g.copilot_tab_fallback = ""

-- Copilot node command (ajustar según tu instalación de Node.js)
-- vim.g.copilot_node_command = "node"

-- Copilot proxy settings (si necesitas proxy)
-- vim.g.copilot_proxy = "http://proxy.example.com:8080"
-- vim.g.copilot_proxy_strict_ssl = false

-- Configuración de workspace para Copilot
vim.g.copilot_workspace_folders = { vim.fn.getcwd() }

-- Arch Linux + Hyprland specific optimizations
vim.opt.clipboard = "unnamedplus" -- Use system clipboard (Wayland compatible)
vim.opt.mouse = "a" -- Enable mouse support
vim.opt.mousemodel = "extend" -- Right-click extends selection

-- Performance optimizations for Arch Linux
vim.opt.updatetime = 250 -- Faster completion
vim.opt.timeoutlen = 300 -- Faster key sequence timeout
vim.opt.redrawtime = 10000 -- More time for syntax highlighting
vim.opt.synmaxcol = 240 -- Don't highlight very long lines
vim.opt.lazyredraw = false -- Don't redraw during macros (can cause issues)

-- Better file handling for Arch Linux
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("state") .. "/undo"

-- Memory management
vim.opt.maxmempattern = 20000 -- Increase pattern matching memory
vim.opt.history = 1000 -- Command history

-- Hyprland window integration
vim.opt.title = true
vim.opt.titlestring = "Neovim - %F"
vim.opt.titlelen = 70

-- Better search for large codebases
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- File encoding for international support
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.fileencodings = "utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936"

-- Better diff mode
vim.opt.diffopt:append("internal,algorithm:patience")
vim.opt.diffopt:append("indent-heuristic")

-- Arch Linux specific paths
if vim.fn.executable("rg") == 1 then
  vim.opt.grepprg = "rg --vimgrep --smart-case --follow"
end

if vim.fn.executable("fd") == 1 then
  vim.env.FZF_DEFAULT_COMMAND = "fd --type f --hidden --follow --exclude .git"
end