return {
  'epwalsh/obsidian.nvim',
  version = '*', -- recommended, use latest release instead of latest commit
  lazy = true,
  event = 'VeryLazy',
  dependencies = {
    -- Required.
    'nvim-lua/plenary.nvim',

    -- see below for full list of optional dependencies 👇
  },
  opts = {
    workspaces = {
      {
        name = 'notes',
        path = '~/Notes',
      },
    },

    -- see below for full list of options 👇
    completion = {
      -- Set to false to disable completion.
      nvim_cmp = false,
      -- Trigger completion at 2 chars.
      min_chars = 2,
    },
    
    ui = {
        enable = false,
    },
    
    daily_notes = {
      -- Optional, if you keep daily notes in a separate directory.
      folder = "Daily",
      -- Optional, if you want to change the date format for the ID of daily notes.
      date_format = "%Y-%m-%d",
      -- Optional, if you want to change the date format of the default alias of daily notes.
      alias_format = "%B %-d, %Y",
      -- Optional, default tags to add to each new daily note created.
      default_tags = { "daily-notes" },
      -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
      template = "Daily.md"
    },
    
    templates = {
      folder = vim.fn.stdpath("config") .. "/obsidian_templates",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M",
      -- A map for custom variables, the key should be the variable and the value a function
      substitutions = {
        title = function()
          if vim.g.obsidian_current_title then
            return vim.g.obsidian_current_title
          end
          return "Untitled"
        end,
      },
    },

    -- Customize how note IDs are generated given a title.
    note_id_func = function(title)
      if title ~= nil then
        -- Return the exact title as the filename
        return title
      else
        -- If no title is given, fallback to a simple timestamp
        return tostring(os.time())
      end
    end,
  },
}
