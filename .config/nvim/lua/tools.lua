local actions = require("telescope.actions")
require("telescope").setup({
	defaults = {
		-- Default configuration for telescope goes here:
		-- config_key = value,
		mappings = {
			i = {
				-- map actions.which_key to <C-h> (default: <C-/>)
				-- actions.which_key shows the mappings for your picker,
				-- e.g. git_{create, delete, ...}_branch for the git_branches picker
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
				["?"] = actions.which_key,
				["<esc>"] = actions.close,
			},
		},
	},
})

-- Utilities for creating configurations
local util = require("formatter.util")

-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
require("formatter").setup({
	-- Enable or disable logging
	logging = true,
	-- Set the log level
	log_level = vim.log.levels.WARN,
	-- All formatter configurations are opt-in
	filetype = {
		-- Formatter configurations for filetype "lua" go here
		-- and will be executed in order
		go = {
			function()
				return {
					exe = "goimports",
					args = {
						"-w",
						vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
					},
					stdin = false,
				}
			end,
		},
		lua = {
			require("formatter.filetypes.lua").stylua,
			function()
				-- Supports conditional formatting
				if util.get_current_buffer_file_name() == "special.lua" then
					return nil
				end

				-- Full specification of configurations is down below and in Vim help
				-- files
				return {
					exe = "stylua",
					args = {
						"--search-parent-directories",
						"--stdin-filepath",
						util.escape_path(util.get_current_buffer_file_path()),
						"--",
						"-",
					},
					stdin = true,
				}
			end,
		},
	},
})

-- lsp fuzzy
require("lspfuzzy").setup({
	methods = "all", -- either 'all' or a list of LSP methods (see below)
	jump_one = true, -- jump immediately if there is only one location
	save_last = false, -- save last location results for the :LspFuzzyLast command
	callback = nil, -- callback called after jumping to a location
	fzf_preview = { -- arguments to the FZF '--preview-window' option
		"right:+{2}-/2", -- preview on the right and centered on entry
	},
	fzf_action = { -- FZF actions
		["ctrl-t"] = "tab split", -- go to location in a new tab
		["ctrl-v"] = "vsplit", -- go to location in a vertical split
		["ctrl-x"] = "split", -- go to location in a horizontal split
	},
	fzf_modifier = ":~:.", -- format FZF entries, see |filename-modifiers|
	fzf_trim = true, -- trim FZF entries
})

-- git sign
require("gitsigns").setup({})

require("Comment").setup({
	---LHS of toggle mappings in NORMAL + VISUAL mode
	---@type table
	toggler = {
		---Line-comment toggle keymap
		line = "<leader>cc",
		---Block-comment toggle keymap
		block = "<leader>bc",
	},

	---@type table
	opleader = {
		---Line-comment keymap
		line = "gc",
		---Block-comment keymap
		block = "gb",
	},

	---LHS of extra mappings
	---@type table
	extra = {
		---Add comment on the line above
		above = "gcO",
		---Add comment on the line below
		below = "gco",
		---Add comment at the end of line
		eol = "gcA",
	},
	---@type boolean|table
	mappings = {
		---Operator-pending mapping
		---Includes `gcc`, `gbc`, `gc[count]{motion}` and `gb[count]{motion}`
		---NOTE: These mappings can be changed individually by `opleader` and `toggler` config
		basic = true,
		---Extra mapping
		---Includes `gco`, `gcO`, `gcA`
		extra = false,
		---Extended mapping
		---Includes `g>`, `g<`, `g>[count]{motion}` and `g<[count]{motion}`
		extended = false,
	},

	---Pre-hook, called before commenting the line
	---@type fun(ctx: Ctx):string
	pre_hook = nil,

	---Post-hook, called after commenting is done
	---@type fun(ctx: Ctx)
	post_hook = nil,
})

require("nvim-autopairs").setup({})

require("nvim-treesitter.configs").setup({
	ensure_installed = { "c", "cpp", "lua", "go", "markdown", "json", "comment", "gomod", "proto", "python", "sql" }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
	sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
	ignore_install = { "" }, -- List of parsers to ignore installing
	highlight = {
		-- `false` will disable the whole extension
		enable = true,

		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = false,
	},
})

local check_backspace = function()
	local col = vim.fn.col(".") - 1
	return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

--   פּ ﯟ   some other good icons
local kind_icons = {
	Text = "",
	Method = "m",
	Function = "",
	Constructor = "",
	Field = "",
	Variable = "",
	Class = "",
	Interface = "",
	Module = "",
	Property = "",
	Unit = "",
	Value = "",
	Enum = "",
	Keyword = "",
	Snippet = "",
	Color = "",
	File = "",
	Reference = "",
	Folder = "",
	EnumMember = "",
	Constant = "",
	Struct = "",
	Event = "",
	Operator = "",
	TypeParameter = "",
}
