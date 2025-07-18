return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		opts = {
			bigfile = { enabled = true },
			dashboard = {
				enabled = true,
				sections = {
					{ section = "header" },
					{ section = "keys", gap = 1, padding = 1 },
					{ pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
					{
						pane = 2,
						icon = " ",
						title = "Git Status",
						section = "terminal",
						enabled = function()
							return Snacks.git.get_root() ~= nil
						end,
						cmd = "git status --short --branch --renames",
						height = 10,
						padding = 1,
						ttl = 5 * 60,
						indent = 3,
					},
					{ section = "startup" },
				},
			},
			explorer = { enabled = false },
			indent = {
				priority = 1,
				enabled = true, -- enable indent guides
				char = "│",
				only_scope = false, -- only show indent guides of the scope
				only_current = false, -- only show indent guides in the current window
				hl = "SnacksIndent", ---@type string|string[] hl groups for indent guides
				-- can be a list of hl groups to cycle through
				-- hl = {
				--     "SnacksIndent1",
				--     "SnacksIndent2",
				--     "SnacksIndent3",
				--     "SnacksIndent4",
				--     "SnacksIndent5",
				--     "SnacksIndent6",
				--     "SnacksIndent7",
				--     "SnacksIndent8",
				-- },
				-- animate scopes. Enabled by default for Neovim >= 0.10
				-- Works on older versions but has to trigger redraws during animation.
				---@class snacks.indent.animate: snacks.animate.Config
				---@field enabled? boolean
				--- * out: animate outwards from the cursor
				--- * up: animate upwards from the cursor
				--- * down: animate downwards from the cursor
				--- * up_down: animate up or down based on the cursor position
				---@field style? "out"|"up_down"|"down"|"up"
				animate = {
					enabled = true,
					style = "out",
					easing = "linear",
					duration = {
						step = 20, -- ms per step
						total = 500, -- maximum duration
					},
				},
				---@class snacks.indent.Scope.Config: snacks.scope.Config
				scope = {
					enabled = true, -- enable highlighting the current scope
					priority = 200,
					char = "│",
					underline = false, -- underline the start of the scope
					only_current = false, -- only show scope in the current window
					hl = "SnacksIndentScope", ---@type string|string[] hl group for scopes
				},
				chunk = {
					-- when enabled, scopes will be rendered as chunks, except for the
					-- top-level scope which will be rendered as a scope.
					enabled = false,
					-- only show chunk scopes in the current window
					only_current = false,
					priority = 200,
					hl = "SnacksIndentChunk", ---@type string|string[] hl group for chunk scopes
					char = {
						corner_top = "┌",
						corner_bottom = "└",
						-- corner_top = "╭",
						-- corner_bottom = "╰",
						horizontal = "─",
						vertical = "│",
						arrow = ">",
					},
				},
				-- filter for buffers to enable indent guides
				filter = function(buf)
					return vim.g.snacks_indent ~= false and vim.b[buf].snacks_indent ~= false and
						vim.bo[buf].buftype == ""
				end,
			},
			input = { enabled = true },
			notifier = {
				enabled = true,
				timeout = 3000, -- default timeout in ms
				width = { min = 40, max = 0.4 },
				height = { min = 1, max = 0.6 },
				-- editor margin to keep free. tabline and statusline are taken into account automatically
				margin = { top = 0, right = 1, bottom = 0 },
				padding = true,  -- add 1 cell of left/right padding to the notification window
				sort = { "level", "added" }, -- sort by level and time
				-- minimum log level to display. TRACE is the lowest
				-- all notifications are stored in history
				level = vim.log.levels.TRACE,
				icons = {
					error = " ",
					warn = " ",
					info = " ",
					debug = " ",
					trace = " ",
				},
				keep = function(notif)
					return vim.fn.getcmdpos() > 0
				end,
				---@type snacks.notifier.style
				style = "compact",
				top_down = true, -- place notifications from top to bottom
				date_format = "%R", -- time format for notifications
				-- format for footer when more lines are available
				-- `%d` is replaced with the number of lines.
				-- only works for styles with a border
				---@type string|boolean
				more_format = " ↓ %d lines ",
				refresh = 50, -- refresh at most every 50ms
			},
			picker = {
				enabled = true,
				win = {
					input = {
						keys = {
							["<c-x>"] = { "delete_buffer", mode = { "n", "i" } },
							["/"] = "toggle_focus",
							["<C-Down>"] = { "history_forward", mode = { "i", "n" } },
							["<C-Up>"] = { "history_back", mode = { "i", "n" } },
							["<C-c>"] = { "cancel", mode = "i" },
							["<C-w>"] = { "<c-s-w>", mode = { "i" }, expr = true, desc = "delete word" },
							["<CR>"] = { "confirm", mode = { "n", "i" } },
							["<Down>"] = { "list_down", mode = { "i", "n" } },
							["<Esc>"] = "cancel",
							["<S-CR>"] = { { "pick_win", "jump" }, mode = { "n", "i" } },
							["<S-Tab>"] = { "select_and_prev", mode = { "i", "n" } },
							["<Tab>"] = { "select_and_next", mode = { "i", "n" } },
							["<Up>"] = { "list_up", mode = { "i", "n" } },
							["<a-d>"] = { "inspect", mode = { "n", "i" } },
							["<a-f>"] = { "toggle_follow", mode = { "i", "n" } },
							["<a-h>"] = { "toggle_hidden", mode = { "i", "n" } },
							["<a-i>"] = { "toggle_ignored", mode = { "i", "n" } },
							["<a-m>"] = { "toggle_maximize", mode = { "i", "n" } },
							["<a-p>"] = { "toggle_preview", mode = { "i", "n" } },
							["<a-w>"] = { "cycle_win", mode = { "i", "n" } },
							["<c-a>"] = { "select_all", mode = { "n", "i" } },
							["<c-k>"] = { "preview_scroll_up", mode = { "i", "n" } },
							["<c-j>"] = { "preview_scroll_down", mode = { "i", "n" } },
							["<c-u>"] = { "list_scroll_up", mode = { "i", "n" } },
							["<c-d>"] = { "list_scroll_down", mode = { "i", "n" } },
							["<c-n>"] = { "list_down", mode = { "i", "n" } },
							["<c-p>"] = { "list_up", mode = { "i", "n" } },
							["<c-g>"] = { "toggle_live", mode = { "i", "n" } },
							["<c-q>"] = { "qflist", mode = { "i", "n" } },
							["<c-s>"] = { "edit_split", mode = { "i", "n" } },
							["<c-t>"] = { "tab", mode = { "n", "i" } },
							["<c-v>"] = { "edit_vsplit", mode = { "i", "n" } },
							["<c-r>#"] = { "insert_alt", mode = "i" },
							["<c-r>%"] = { "insert_filename", mode = "i" },
							["<c-r><c-a>"] = { "insert_cWORD", mode = "i" },
							["<c-r><c-f>"] = { "insert_file", mode = "i" },
							["<c-r><c-l>"] = { "insert_line", mode = "i" },
							["<c-r><c-p>"] = { "insert_file_full", mode = "i" },
							["<c-r><c-w>"] = { "insert_cword", mode = "i" },
							["<c-w>H"] = "layout_left",
							["<c-w>J"] = "layout_bottom",
							["<c-w>K"] = "layout_top",
							["<c-w>L"] = "layout_right",
							["?"] = "toggle_help_input",
							["G"] = "list_bottom",
							["gg"] = "list_top",
							["j"] = "list_down",
							["k"] = "list_up",
							["q"] = "close",
						},
					}
				},
				sources = {
					buffers = {
						finder = "buffers",
						format = "buffer",
						hidden = false,
						unloaded = true,
						current = true,
						sort_lastused = true,
						win = {
							input = {
								keys = {
									["<c-x>"] = { "bufdelete", mode = { "n", "i" } },
								},
							},
							list = { keys = { ["dd"] = "bufdelete" } },
						},
					},
					files = {
						finder = "files",
						format = "file",
						show_empty = true,
						hidden = true,
						ignored = false,
						follow = false,
						supports_live = true,
						exclude = {
							'node_modules',
							'%.git/',
							'site%-packages',
							'%.terraform'
						}
					},
					grep = {
						finder = "grep",
						regex = true,
						format = "file",
						hidden = true,
						show_empty = true,
						live = true, -- live grep by default
						supports_live = true,
						exclude = {
							'node_modules',
							'%.git/',
							'site%-packages',
							'%.terraform'
						}
					},
					cliphist = {
						finder = "system_cliphist",
						format = "text",
						preview = "preview",
						confirm = { "copy", "close" },
					}
				}
			},
			quickfile = { enabled = true },
			scope = { enabled = true },
			scroll = {
				enabled = true,
				animate = {
					duration = { step = 15, total = 250 },
					easing = "linear",
				},
				-- faster animation when repeating scroll after delay
				animate_repeat = {
					delay = 100, -- delay in ms before using the repeat animation
					duration = { step = 5, total = 50 },
					easing = "linear",
				},
				-- what buffers to animate
				filter = function(buf)
					return vim.g.snacks_scroll ~= false and vim.b[buf].snacks_scroll ~= false and
						vim.bo[buf].buftype ~= "terminal"
				end,
			},
			statuscolumn = {
				enabled = true,
				left = { "mark", "sign" }, -- priority of signs on the left (high to low)
				right = { "fold", "git" }, -- priority of signs on the right (high to low)
				folds = {
					open = false, -- show open fold icons
					git_hl = false, -- use Git Signs hl for fold icons
				},
				git = {
					-- patterns to match Git signs
					patterns = { "GitSign" },
				},
				refresh = 50, -- refresh at most every 50ms
			},
			words = { enabled = true },
			styles = {
				notification = {
					{
						border = "rounded",
						zindex = 100,
						ft = "markdown",
						wo = {
							winblend = 5,
							wrap = false,
							conceallevel = 2,
							colorcolumn = "",
						},
						bo = { filetype = "snacks_notif" },
					}
				},
				notification_history = {
					border = "rounded",
					zindex = 100,
					width = 0.6,
					height = 0.6,
					minimal = false,
					title = " Notification History ",
					title_pos = "center",
					ft = "markdown",
					bo = { filetype = "snacks_notif_history", modifiable = false },
					wo = { winhighlight = "Normal:SnacksNotifierHistory" },
					keys = { q = "close" },
				},
				input = {
					backdrop = false,
					position = "float",
					border = "rounded",
					title_pos = "center",
					height = 1,
					width = 60,
					relative = "editor",
					noautocmd = true,
					row = 2,
					-- relative = "cursor",
					-- row = -3,
					-- col = 0,
					wo = {
						winhighlight =
						"NormalFloat:SnacksInputNormal,FloatBorder:SnacksInputBorder,FloatTitle:SnacksInputTitle",
						cursorline = false,
					},
					bo = {
						filetype = "snacks_input",
						buftype = "prompt",
					},
					--- buffer local variables
					b = {
						completion = false, -- disable blink completions in input
					},
					keys = {
						n_esc = { "<esc>", { "cmp_close", "cancel" }, mode = "n", expr = true },
						i_esc = { "<esc>", { "cmp_close", "stopinsert" }, mode = "i", expr = true },
						i_cr = { "<cr>", { "cmp_accept", "confirm" }, mode = { "i", "n" }, expr = true },
						i_tab = { "<tab>", { "cmp_select_next", "cmp" }, mode = "i", expr = true },
						i_ctrl_w = { "<c-w>", "<c-s-w>", mode = "i", expr = true },
						i_up = { "<up>", { "hist_up" }, mode = { "i", "n" } },
						i_down = { "<down>", { "hist_down" }, mode = { "i", "n" } },
						q = "cancel",
					},
				},
				zen = {
					enter = true,
					fixbuf = false,
					minimal = false,
					width = 120,
					height = 0,
					backdrop = { transparent = true, blend = 40 },
					keys = { q = false },
					zindex = 40,
					wo = {
						winhighlight = "NormalFloat:Normal",
					},
					w = {
						snacks_main = true,
					},
				}
			}
		},
		keys = {
			-- Top Pickers & Explorer
			{ "<leader>?",  function() Snacks.picker.smart() end,                 desc = "Smart Find Files" },
			{ "<leader>:",  function() Snacks.picker.command_history() end,       desc = "Command History" },
			{ "<leader>n",  function() Snacks.picker.notifications() end,         desc = "Notification History" },
			-- { "<leader>,",       function() Snacks.picker.buffers() end,                                 desc = "Buffers" },
			-- { "<leader>/",       function() Snacks.picker.grep() end,                                    desc = "Grep" },
			-- { "<leader>e",       function() Snacks.explorer() end,                                       desc = "File Explorer" },
			-- find
			{ "<leader>sf", function() Snacks.picker.files() end,                 desc = "Search Files" },
			{ "<leader>sb", function() Snacks.picker.buffers() end,               desc = "Search opened Buffers" },
			-- { "<leader>sf",      function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
			{ "<leader>fp", function() Snacks.picker.projects() end,              desc = "Projects" },
			{ "<leader>fr", function() Snacks.picker.recent() end,                desc = "Recent" },
			-- git
			{ "<C-g>f",     function() Snacks.picker.git_files() end,             desc = "Find Git Files" },
			{ "<C-g>b",     function() Snacks.picker.git_branches() end,          desc = "Git Branches" },
			{ "<C-g>l",     function() Snacks.picker.git_log() end,               desc = "Git Log" },
			{ "<C-g>L",     function() Snacks.picker.git_log_line() end,          desc = "Git Log Line" },
			{ "<C-g>s",     function() Snacks.picker.git_status() end,            desc = "Git Status" },
			{ "<C-g>S",     function() Snacks.picker.git_stash() end,             desc = "Git Stash" },
			{ "<C-g>d",     function() Snacks.picker.git_diff() end,              desc = "Git Diff (Hunks)" },
			{ "<C-g>lf",    function() Snacks.picker.git_log_file() end,          desc = "Git Log File" },
			-- Grep
			-- { "<leader>sb",      function() Snacks.picker.lines() end,                 desc = "Buffer Lines" },
			{ "<leader>sg", function() Snacks.picker.grep() end,                  desc = "Grep" },
			{ "<leader>sB", function() Snacks.picker.grep_buffers() end,          desc = "Grep Open Buffers" },
			{ "<leader>sw", function() Snacks.picker.grep_word() end,             desc = "Visual selection or word", mode = { "n", "x" } },
			-- search
			{ '<leader>s"', function() Snacks.picker.registers() end,             desc = "Registers" },
			{ '<leader>s/', function() Snacks.picker.search_history() end,        desc = "Search History" },
			{ "<leader>sa", function() Snacks.picker.autocmds() end,              desc = "Autocmds" },
			-- { "<leader>sb",      function() Snacks.picker.lines() end,                 desc = "Buffer Lines" },
			{ "<leader>sc", function() Snacks.picker.command_history() end,       desc = "Command History" },
			{ "<leader>sC", function() Snacks.picker.commands() end,              desc = "Commands" },
			{ "<leader>sd", function() Snacks.picker.diagnostics() end,           desc = "Diagnostics" },
			{ "<leader>sD", function() Snacks.picker.diagnostics_buffer() end,    desc = "Buffer Diagnostics" },
			{ "<leader>sh", function() Snacks.picker.help() end,                  desc = "Help Pages" },
			{ "<leader>sH", function() Snacks.picker.highlights() end,            desc = "Highlights" },
			{ "<leader>si", function() Snacks.picker.icons() end,                 desc = "Icons" },
			{ "<leader>sj", function() Snacks.picker.jumps() end,                 desc = "Jumps" },
			{ "<leader>sk", function() Snacks.picker.keymaps() end,               desc = "Keymaps" },
			{ "<leader>sl", function() Snacks.picker.loclist() end,               desc = "Location List" },
			{ "<leader>sm", function() Snacks.picker.marks() end,                 desc = "Marks" },
			{ "<leader>sM", function() Snacks.picker.man() end,                   desc = "Man Pages" },
			-- { "<leader>sp",      function() Snacks.picker.lazy() end,                  desc = "Search for Plugin Spec" },
			{ "<leader>sq", function() Snacks.picker.qflist() end,                desc = "Quickfix List" },
			{ "<leader>sR", function() Snacks.picker.resume() end,                desc = "Resume" },
			{ "<leader>su", function() Snacks.picker.undo() end,                  desc = "Undo History" },
			{ "<leader>uC", function() Snacks.picker.colorschemes() end,          desc = "Colorschemes" },
			-- LSP
			{ "gd",         function() Snacks.picker.lsp_definitions() end,       desc = "Goto Definition" },
			{ "gD",         function() Snacks.picker.lsp_declarations() end,      desc = "Goto Declaration" },
			{ "gr",         function() Snacks.picker.lsp_references() end,        nowait = true,                     desc = "References" },
			{ "gI",         function() Snacks.picker.lsp_implementations() end,   desc = "Goto Implementation" },
			{ "gy",         function() Snacks.picker.lsp_type_definitions() end,  desc = "Goto T[y]pe Definition" },
			{ "<leader>ss", function() Snacks.picker.lsp_symbols() end,           desc = "LSP Symbols" },
			{ "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
			-- Other
			{ "<leader>z",  function() Snacks.zen() end,                          desc = "Toggle Zen Mode" },
			{ "<leader>Z",  function() Snacks.zen.zoom() end,                     desc = "Toggle Zoom" },
			{ "<leader>.",  function() Snacks.scratch() end,                      desc = "Toggle Scratch Buffer" },
			{ "<leader>S",  function() Snacks.scratch.select() end,               desc = "Select Scratch Buffer" },
			{ "<leader>n",  function() Snacks.notifier.show_history() end,        desc = "Notification History" },
			{ "<leader>bd", function() Snacks.bufdelete() end,                    desc = "Delete Buffer" },
			{ "<leader>rf", function() Snacks.rename.rename_file() end,           desc = "Rename File" },
			{ "<leader>gB", function() Snacks.gitbrowse() end,                    desc = "Git Browse",               mode = { "n", "v" } },
			-- { "<leader>gg",      function() Snacks.lazygit() end,                      desc = "Lazygit" },
			{ "<leader>un", function() Snacks.notifier.hide() end,                desc = "Dismiss All Notifications" },
			{ "<c-t>",      function() Snacks.terminal() end,                     desc = "Toggle Terminal" },
			-- { "<c-_>",           function() Snacks.terminal() end,                     desc = "which_key_ignore" },
			{ "]]",         function() Snacks.words.jump(vim.v.count1) end,       desc = "Next Reference",           mode = { "n", "t" } },
			{ "[[",         function() Snacks.words.jump(-vim.v.count1) end,      desc = "Prev Reference",           mode = { "n", "t" } },
			{
				"<leader>N",
				desc = "Neovim News",
				function()
					Snacks.win({
						file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
						width = 0.6,
						height = 0.6,
						wo = {
							spell = false,
							wrap = false,
							signcolumn = "yes",
							statuscolumn = " ",
							conceallevel = 3,
						},
					})
				end,
			}
		},
		init = function()
			vim.api.nvim_create_autocmd("User", {
				pattern = "VeryLazy",
				callback = function()
					-- Setup some globals for debugging (lazy-loaded)
					_G.dd = function(...)
						Snacks.debug.inspect(...)
					end
					_G.bt = function()
						Snacks.debug.backtrace()
					end
					vim.print = _G.dd -- Override print to use snacks for `:=` command

					-- Create some toggle mappings
					Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
					Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
					Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
					Snacks.toggle.diagnostics():map("<leader>ud")
					Snacks.toggle.line_number():map("<leader>ul")
					Snacks.toggle.option("conceallevel",
						{ off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<leader>uc")
					Snacks.toggle.treesitter():map("<leader>uT")
					Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map(
						"<leader>ub")
					Snacks.toggle.inlay_hints():map("<leader>uh")
					Snacks.toggle.indent():map("<leader>ug")
					Snacks.toggle.dim():map("<leader>uD")
				end,
			})
		end,
	}
}
