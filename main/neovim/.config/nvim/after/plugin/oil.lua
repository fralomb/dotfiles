local status_ok, oil = pcall(require, "oil")
if not status_ok then
  return
end

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

oil.setup({
  -- Oil will take over directory buffers (e.g. `vim .` or `:e src/`)
  -- Set to false if you still want to use netrw.
  experimental_watch_for_changes = true,
  default_file_explorer = true,
  -- Id is automatically added at the beginning, and name at the end
  -- See :help oil-columns
  columns = {
    "icon",
    "permissions",
    "size",
    "mtime",
  },
  -- Buffer-local options to use for oil buffers
  buf_options = {
    buflisted = false,
    bufhidden = "hide",
  },
  -- Window-local options to use for oil buffers
  win_options = {
    wrap = false,
    signcolumn = "yes:1",
    cursorcolumn = false,
    foldcolumn = "0",
    spell = false,
    list = false,
    conceallevel = 3,
    concealcursor = "nvic",
  },
  -- Send deleted files to the trash instead of permanently deleting them (:help oil-trash)
  delete_to_trash = false,
  -- Skip the confirmation popup for simple operations (:help oil.skip_confirm_for_simple_edits)
  skip_confirm_for_simple_edits = false,
  -- Selecting a new/moved/renamed file or directory will prompt you to save changes first
  -- (:help prompt_save_on_select_new_entry)
  prompt_save_on_select_new_entry = true,
  -- Oil will automatically delete hidden buffers after this delay
  -- You can set the delay to false to disable cleanup entirely
  -- Note that the cleanup process only starts when none of the oil buffers are currently displayed
  cleanup_delay_ms = 2000,
  -- Set to true to autosave buffers that are updated with LSP willRenameFiles
  -- Set to "unmodified" to only save unmodified buffers
  lsp_file_methods = {
    -- Time to wait for LSP file operations to complete before skipping
    timeout_ms = 1000,
    -- Set to true to autosave buffers that are updated with LSP willRenameFiles
    -- Set to "unmodified" to only save unmodified buffers
    autosave_changes = false,
  },
  -- Constrain the cursor to the editable parts of the oil buffer
  -- Set to `false` to disable, or "name" to keep it on the file names
  constrain_cursor = "editable",
  -- Keymaps in oil buffer. Can be any value that `vim.keymap.set` accepts OR a table of keymap
  -- options with a `callback` (e.g. { callback = function() ... end, desc = "", mode = "n" })
  -- Additionally, if it is a string that matches "actions.<name>",
  -- it will use the mapping at require("oil.actions").<name>
  -- Set to `false` to remove a keymap
  -- See :help oil-actions for a list of all available actions
  keymaps = {
    ["g?"] = "actions.show_help",
    ["<CR>"] = "actions.select",
    ["<C-s>"] = "actions.select_vsplit",
    ["<C-h>"] = "actions.select_split",
    ["<C-t>"] = "actions.select_tab",
    ["<C-p>"] = "actions.preview",
    ["<C-c>"] = "actions.close",
    ["<C-l>"] = "actions.refresh",
    ["-"] = "actions.parent",
    ["_"] = "actions.open_cwd",
    ["`"] = "actions.cd",
    ["~"] = "actions.tcd",
    ["gs"] = "actions.change_sort",
    ["gx"] = "actions.open_external",
    ["g."] = "actions.toggle_hidden",
    ["g\\"] = "actions.toggle_trash",
  },
  -- Set to false to disable all of the above keymaps
  use_default_keymaps = true,
  view_options = {
    -- Show files and directories that start with "."
    show_hidden = true,
    -- This function defines what is considered a "hidden" file
    is_hidden_file = function(name, bufnr)
      return vim.startswith(name, ".")
    end,
    -- This function defines what will never be shown, even when `show_hidden` is set
    is_always_hidden = function(name, bufnr)
      return false
    end,
    sort = {
      -- sort order can be "asc" or "desc"
      -- see :help oil-columns to see which columns are sortable
      { "type", "asc" },
      { "name", "asc" },
    },
  },
  -- Configuration for the floating window in oil.open_float
  float = {
    -- Padding around the floating window
    padding = 2,
    max_width = 0,
    max_height = 0,
    border = "rounded",
    win_options = {
      winblend = 0,
    },
    -- This is the config that will be passed to nvim_open_win.
    -- Change values here to customize the layout
    override = function(conf)
      return conf
    end,
  },
  -- Configuration for the actions floating preview window
  preview = {
    -- Width dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
    -- min_width and max_width can be a single value or a list of mixed integer/float types.
    -- max_width = {100, 0.8} means "the lesser of 100 columns or 80% of total"
    max_width = 0.9,
    -- min_width = {40, 0.4} means "the greater of 40 columns or 40% of total"
    min_width = { 40, 0.4 },
    -- optionally define an integer/float for the exact width of the preview window
    width = nil,
    -- Height dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
    -- min_height and max_height can be a single value or a list of mixed integer/float types.
    -- max_height = {80, 0.9} means "the lesser of 80 columns or 90% of total"
    max_height = 0.9,
    -- min_height = {5, 0.1} means "the greater of 5 columns or 10% of total"
    min_height = { 5, 0.1 },
    -- optionally define an integer/float for the exact height of the preview window
    height = nil,
    border = "rounded",
    win_options = {
      winblend = 0,
    },
    -- Whether the preview window is automatically updated when the cursor is moved
    update_on_cursor_moved = true,
  },
  -- Configuration for the floating progress window
  progress = {
    max_width = 0.9,
    min_width = { 40, 0.4 },
    width = nil,
    max_height = { 10, 0.9 },
    min_height = { 5, 0.1 },
    height = nil,
    border = "rounded",
    minimized_border = "none",
    win_options = {
      winblend = 0,
    },
  },
})

local function oil_git(config)
  local oil = require("oil")
  local oil_git_namespace = vim.api.nvim_create_namespace("oil_git")

  local default_config = {
    signs = {
      unstaged = "✗",
      staged = "✓",
      unmerged = "",
      renamed = "➜",
      untracked = "★",
      deleted = "",
      ignored = "◌",
    },
    hl = {
      unstaged = "DiagnosticSignWarn",
      staged = "DiagnosticSignWarn",
      unmerged = "DiagnosticSignHint",
      renamed = "DiagnosticSignInfo",
      untracked = "DiagnosticSignOk",
      deleted = "DiagnosticSignError",
      ignored = "DiagnosticSignOther",
    },
    ignore_dirs = {
      ".git/",
      "node_modules/"
    }
  }
  local current_config = vim.tbl_extend("force", default_config, config or {})

  local map_status_to_xy = {
    ["M "] = { "staged" },
    [" M"] = { "unstaged" },
    ["C "] = { "staged" },
    [" C"] = { "unstaged" },
    ["CM"] = { "unstaged" },
    [" T"] = { "unstaged" },
    ["T "] = { "staged" },
    ["TM"] = { "staged", "unstaged" },
    ["MM"] = { "staged", "unstaged" },
    ["MD"] = { "staged" },
    ["A "] = { "staged" },
    ["AD"] = { "staged" },
    [" A"] = { "untracked" },
    ["AA"] = { "unmerged", "untracked" },
    ["AU"] = { "unmerged", "untracked" },
    ["AM"] = { "staged", "unstaged" },
    ["??"] = { "untracked" },
    ["R "] = { "renamed" },
    [" R"] = { "renamed" },
    ["RM"] = { "unstaged", "renamed" },
    ["UU"] = { "unmerged" },
    ["UD"] = { "unmerged" },
    ["UA"] = { "unmerged" },
    [" D"] = { "deleted" },
    ["D "] = { "deleted" },
    ["DA"] = { "unstaged" },
    ["RD"] = { "deleted" },
    ["DD"] = { "deleted" },
    ["DU"] = { "deleted", "unmerged" },
    ["!!"] = { "ignored" },
    dirty = { "unstaged" },
  }

  local lookup_config = function(property, field)
    return current_config[property][field]
  end

  local escapeMagicChars = function(str)
    return str:gsub("([%(%)%.%%%+%-%*%?%[%]%^%$])", "%%%1")
  end

  local parse_git_status = function(status)
    local xy_status = status:sub(1, 2)
    local index_file = status:sub(4)
    local index_status = {
      index = index_file,
      status = xy_status,
    }
    index_status["icons"] = lookup_config("signs", map_status_to_xy[index_status.status][1])
    index_status["hl"] = lookup_config("hl", map_status_to_xy[index_status.status][1])

    return index_status
  end

  local skip_dir = function(dir)
    local skip = false
    for _, skip_dir in pairs(current_config["ignore_dirs"]) do
      if skip_dir:match(dir) then
        skip = true
        break
      end
    end
    return skip
  end

  local add_git_mark = function(buffer, git_files, base_dir)
    -- get oil current directory
    local oil_dir = vim.b[buffer].oil_current_dir_changed
    if oil_dir == nil then
      return
    end

    -- loop over oil entries
    for _, git_file in pairs(git_files) do
      -- print("changed: " .. git_file.index)
      for index = 1, vim.api.nvim_buf_line_count(buffer) do
        local oil_entry = oil.get_entry_on_line(buffer, index)
        -- ignores: empty entry, .. parent directory, configured ignore_dirs
        if oil_entry and (oil_entry.type == "file" or oil_entry.type == "directory") and not skip_dir(oil_entry.name) then
          -- look for changes for current entry
          local entry_suffix = ""
          if oil_entry.type == "directory" then
            entry_suffix = "/"
          end
          local oil_entry_fullpath = oil_dir .. oil_entry.name .. entry_suffix
          local oil_dir_relative = oil_entry_fullpath:match("^" .. escapeMagicChars(base_dir) .. "%/(.*)$")
          -- print("match: " .. git_file.index)
          if git_file.index:match("^" .. escapeMagicChars(oil_dir_relative)) then
            -- print("match: " .. git_file.index)
            vim.api.nvim_buf_set_extmark(buffer, oil_git_namespace, index - 1, 0, {
              sign_text = git_file.icons,
              sign_hl_group = git_file.hl,
              priority = 1,
            })
            -- match found, go on
            break
          end
        end
      end

    end

    -- changes already handled, prepare for next change
    vim.b[buffer].oil_change_detected = false
  end

  local oil_filetype_group = vim.api.nvim_create_augroup('oil_filetype_detected', { clear = true })
  vim.api.nvim_create_autocmd('FileType', {
    group = oil_filetype_group,
    pattern = { 'oil' },
    nested = true,
    callback = function(data)
      local buffer = data.buf

      -- avoid to trigger FileType twice on startup
      if vim.b[buffer].oil_git_status_started then
        return
      end
      vim.b[buffer].oil_git_status_started = true

      -- create nested autocmds
      local oil_bufpost_group = vim.api.nvim_create_augroup('oil_bufpost_detected', { clear = true })
      vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "InsertLeave", "TextChanged" }, {
        buffer = buffer,
        group = oil_bufpost_group,

        callback = function(nested_data)
          local file_url = nested_data.file:gsub("^oil", "file")
          local path = vim.uri_to_fname(file_url)
          local job_output = {}

          -- avoid to trigger twice the gitsigns check
          vim.b[buffer].oil_current_dir_changed = oil.get_current_dir()
          if vim.b[buffer].oil_current_dir_changed == nil then
            return
          end

          local on_exit = function(job_id)
            if job_output[job_id]["stderr"] ~= '' then
              vim.notify(
                "on_error :" ..
                job_id .. " - " .. job_output[job_id]["stderr"] .. "\n",
                vim.log.levels.ERROR, {
                  title = "oil_git_status",
                })
            else
              local stdout_lines = vim.split(job_output[job_id]["stdout"], "\n")
              local is_git_dir = false
              local parsed_lines = {}
              local current_git_dir = ""
              for index, line in pairs(stdout_lines) do
                if index == 1 then
                  -- is it a git repository ?
                  local str2boolean = { ["true"] = true, ["false"] = false }
                  is_git_dir = str2boolean[line]
                  if not is_git_dir then
                    vim.notify(
                      "Not a git dir! " .. "\n",
                      vim.log.levels.ERROR, {
                        title = "oil_git_status",
                      })
                    break
                  end
                elseif index == 2 then
                  -- get current git dir
                  if line ~= "" and is_git_dir then
                    current_git_dir = line
                  end
                else
                  -- read git status output
                  if line ~= "" and is_git_dir then
                    local parsed = parse_git_status(line)
                    table.insert(parsed_lines, parsed)
                  end
                end
              end
              if is_git_dir then
                -- add git marks based on git status output
                add_git_mark(buffer, parsed_lines, current_git_dir)
              end
            end
          end

          local on_event = function(std_id, std_data, std_event)
            if std_event == "exit" then
              on_exit(std_id)
            else
              if job_output[std_id] == nil then
                job_output[std_id] = {}
              end
              if job_output[std_id][std_event] == nil then
                job_output[std_id][std_event] = table.concat(std_data, "\n")
              end
            end
          end

          local cmd_1 = "git rev-parse --is-inside-work-tree"
          local cmd_2 = "git rev-parse --show-toplevel"
          local cmd_3 = "git -c status.relativepaths=true status . --short --untracked-files=normal --porcelain=1"
          vim.fn.jobstart(cmd_1 .. "; " .. cmd_2 .. "; " .. cmd_3, {
            stdout_buffered = true,
            stderr_buffered = true,
            cwd = path,
            on_exit = on_event,
            on_stdout = on_event,
            on_stderr = on_event
          })
        end,
      })
    end,
  })
end

oil_git({})
