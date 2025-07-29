local status_ok, minuet = pcall(require, "minuet")
if not status_ok then
	return
end

local status_ok, codecompanion = pcall(require, "codecompanion")
if not status_ok then
	return
end


minuet.setup {
	virtualtext = {
		auto_trigger_ft = {},
		keymap = {
			-- accept whole completion
			accept = '<A-A>',
			-- accept one line
			accept_line = '<A-a>',
			-- accept n lines (prompts for number)
			-- e.g. "A-z 2 CR" will accept 2 lines
			accept_n_lines = '<A-z>',
			-- Cycle to prev completion item, or manually invoke completion
			prev = '<A-[>',
			-- Cycle to next completion item, or manually invoke completion
			next = '<A-]>',
			dismiss = '<A-e>',
		},
	},
	lsp = {
		enabled_ft = { 'toml', 'lua', 'cpp' },
		-- Enables automatic completion triggering using `vim.lsp.completion.enable`
		enabled_auto_trigger_ft = { 'cpp', 'lua' },
	},
	provider = 'codestral',
	provider_options = {
		codestral = {
			model = 'codestral-latest',
			end_point = 'https://codestral.mistral.ai/v1/fim/completions',
			api_key = 'CODESTRAL_API_KEY',
			stream = true,
			optional = {
				max_tokens = 256,
				stop = { '\n\n' },
			},
		},
	}
}

codecompanion.setup({
	strategies = {
		chat = {
			adapter = {
				name = "gemini",
				model = "gemini-2.5-pro",
			},
			-- adapter = "gemini",
			-- slash_commands = {
			-- 	["file"] = {
			-- 	  -- Location to the slash command in CodeCompanion
			-- 	  callback = "strategies.chat.slash_commands.file",
			-- 	  description = "Select a file using Telescope",
			-- 	  opts = {
			-- 		provider = "telescope", -- Can be "default", "telescope", "fzf_lua", "mini_pick" or "snacks"
			-- 		contains_code = true,
			-- 	  },
			-- }
			opts = {
				---Decorate the user message before it's sent to the LLM
				---@param message string
				---@param adapter CodeCompanion.Adapter
				---@param context table
				---@return string
				prompt_decorator = function(message, adapter, context)
					return string.format([[<prompt>%s</prompt>]], message)
				end,
				completion_provider = "cmp", -- blink|cmp|coc|default
			}
		},
		inline = {
			adapter = {
				name = "gemini",
				model = "gemini-2.5-pro",
			},
			-- adapter = "gemini",
			keymaps = {
				accept_change = {
					modes = { n = "ga" },
					description = "Accept the suggested change",
				},
				reject_change = {
					modes = { n = "gr" },
					description = "Reject the suggested change",
				},
			},
		},
		cmd = {
			adapter = {
				name = "gemini",
				model = "gemini-2.5-pro",
			},
			-- adapter = "gemini",
		}
	},
	display = {
		action_palette = {
			width = 95,
			height = 10,
			prompt = "Prompt ",         -- Prompt used for interactive LLM calls
			provider = "default",       -- Can be "default", "telescope", "fzf_lua", "mini_pick" or "snacks". If not specified, the plugin will autodetect installed providers.
			opts = {
				show_default_actions = true, -- Show the default actions in the action palette?
				show_default_prompt_library = true, -- Show the default prompt library in the action palette?
			},
		},
		diff = {
			enabled = true,
			close_chat_at = 240, -- Close an open chat buffer if the total columns of your display are less than...
			layout = "vertical", -- vertical|horizontal split for default provider
			opts = { "internal", "filler", "closeoff", "algorithm:patience", "followwrap", "linematch:120" },
			provider = "default", -- default|mini_diff
		},
	},
	-- adapters = {
	-- 	gemini = function()
	-- 		return require("codecompanion.adapters").extend("gemini", {
	-- 			env = {
	-- 				api_key = "MY_OTHER_ANTHROPIC_KEY",
	-- 			},
	-- 		})
	-- 	end,
	-- },
})
