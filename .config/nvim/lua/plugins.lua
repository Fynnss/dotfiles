local fn = vim.fn
-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
	use("wbthomason/packer.nvim") -- Have packer manage itself
	-- use 'olimorris/onedarkpro.nvim' -- one dark pro theme
	use("navarasu/onedark.nvim")
	use("windwp/nvim-autopairs") -- Autopairs, integrates with both cmp and treesitter
	use("numToStr/Comment.nvim") -- Commenting
	use("lewis6991/gitsigns.nvim")
	use("nvim-lua/popup.nvim") -- An implementation of the Popup API from vim in Neovim
	use("nvim-lua/plenary.nvim") -- Useful lua functions used ny lots of plugins
	use("mhartington/formatter.nvim")
	-- use 'Mofiqul/dracula.nvim'
	-- Highlights
	use({
		"nvim-treesitter/nvim-treesitter",
		requires = {
			"nvim-treesitter/nvim-treesitter-refactor",
			"RRethy/nvim-treesitter-textsubjects",
		},
		run = ":TSUpdate",
	})

	-- Search
	use("kdheepak/lazygit.nvim")
	use({
		"nvim-telescope/telescope.nvim",
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	use({
		"ojroques/nvim-lspfuzzy",
		requires = {
			{ "junegunn/fzf" },
			{ "junegunn/fzf.vim" }, -- to enable preview (optional)
		},
	})

	use({
		"iamcco/markdown-preview.nvim",
		run = "cd app && npm install",
		setup = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	})

	-- golang
	use("ray-x/go.nvim")
	use("ray-x/guihua.lua") -- recommended if need floating window support

	-- cmp plugins
	use("hrsh7th/nvim-cmp") -- The completion plugin
	use("hrsh7th/cmp-buffer") -- buffer completions
	use("hrsh7th/cmp-path") -- path completions
	use("hrsh7th/cmp-cmdline") -- cmdline completions
	use("saadparwaiz1/cmp_luasnip") -- snippet completions
	use("hrsh7th/cmp-nvim-lsp")
	use("MunifTanjim/prettier.nvim")

	-- LSP
	-- use "neovim/nvim-lspconfig" -- enable LSP
	-- use "williamboman/nvim-lsp-installer" -- simple to use language server installer
	-- use "tamago324/nlsp-settings.nvim" -- language server settings defined in json for
	-- use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters
	use({ "williamboman/mason.nvim" })
	use("williamboman/mason-lspconfig.nvim")
	use("neovim/nvim-lspconfig")

	-- snippets
	use("L3MON4D3/LuaSnip") --snippet engine
	use("rafamadriz/friendly-snippets") -- a bunch of snippets to use

	-- status line
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})
	use("akinsho/bufferline.nvim")
	use("kyazdani42/nvim-tree.lua")

	-- dashboard alpha
	use("goolord/alpha-nvim")

	-- term
	use("akinsho/toggleterm.nvim")
	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
