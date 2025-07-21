return {
  -- Wayland/Hyprland clipboard integration
  {
    "ojroques/nvim-osc52",
    event = "VeryLazy",
    config = function()
      require("osc52").setup({
        max_length = 0,
        silent = false,
        trim = false,
      })
      
      -- Auto-copy to system clipboard in Hyprland
      vim.api.nvim_create_autocmd("TextYankPost", {
        callback = function()
          if vim.v.event.operator == "y" and vim.v.event.regname == "" then
            require("osc52").copy_register("")
          end
        end,
      })
    end,
  },

  -- Better file manager integration
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("oil").setup({
        default_file_explorer = true,
        columns = {
          "icon",
          "permissions",
          "size",
          "mtime",
        },
        buf_options = {
          buflisted = false,
          bufhidden = "hide",
        },
        win_options = {
          wrap = false,
          signcolumn = "no",
          cursorcolumn = false,
          foldcolumn = "0",
          spell = false,
          list = false,
          conceallevel = 3,
          concealcursor = "nvic",
        },
        delete_to_trash = true,
        skip_confirm_for_simple_edits = false,
        prompt_save_on_select_new_entry = true,
        cleanup_delay_ms = 2000,
        lsp_file_methods = {
          timeout_ms = 1000,
          autosave_changes = false,
        },
        constrain_cursor = "editable",
        experimental_watch_for_changes = true,
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
        use_default_keymaps = true,
        view_options = {
          show_hidden = false,
          is_hidden_file = function(name, bufnr)
            return vim.startswith(name, ".")
          end,
          is_always_hidden = function(name, bufnr)
            return false
          end,
          sort = {
            { "type", "asc" },
            { "name", "asc" },
          },
        },
        float = {
          padding = 2,
          max_width = 0,
          max_height = 0,
          border = "rounded",
          win_options = {
            winblend = 0,
          },
          override = function(conf)
            return conf
          end,
        },
        preview = {
          max_width = 0.9,
          min_width = { 40, 0.4 },
          width = nil,
          max_height = 0.9,
          min_height = { 5, 0.1 },
          height = nil,
          border = "rounded",
          win_options = {
            winblend = 0,
          },
          update_on_cursor_moved = true,
        },
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
    end,
    keys = {
      { "-", "<cmd>Oil<cr>", desc = "Open parent directory" },
      { "<leader>-", "<cmd>Oil --float<cr>", desc = "Open parent directory (float)" },
    },
  },

  -- System monitoring
  {
    "nvim-lua/plenary.nvim",
    config = function()
      -- System info functions for Arch Linux
      _G.system_info = {
        get_memory = function()
          local handle = io.popen("free -h | awk 'NR==2{printf \"%.1f/%.1f GB (%.0f%%)\", $3/1024, $2/1024, $3*100/$2}'")
          local result = handle:read("*a")
          handle:close()
          return result
        end,
        
        get_cpu = function()
          local handle = io.popen("top -bn1 | grep 'Cpu(s)' | sed 's/.*, *\\([0-9.]*\\)%* id.*/\\1/' | awk '{print 100 - $1\"%\"}'")
          local result = handle:read("*a")
          handle:close()
          return result:gsub("\n", "")
        end,
        
        get_disk = function()
          local handle = io.popen("df -h / | awk 'NR==2{printf \"%s/%s (%s)\", $3, $2, $5}'")
          local result = handle:read("*a")
          handle:close()
          return result
        end,
        
        get_uptime = function()
          local handle = io.popen("uptime -p")
          local result = handle:read("*a")
          handle:close()
          return result:gsub("\n", "")
        end,
      }
    end,
  },

  -- Package manager integration
  {
    "roobert/search-replace.nvim",
    config = function()
      require("search-replace").setup({
        default_replace_single_buffer_options = "gcI",
        default_replace_multi_buffer_options = "egcI",
      })
    end,
    keys = {
      { "<leader>rs", "<CMD>SearchReplaceSingleBufferSelections<CR>", desc = "SearchReplaceSingleBuffer [s]elections list" },
      { "<leader>ro", "<CMD>SearchReplaceSingleBufferOpen<CR>", desc = "[o]pen" },
      { "<leader>rw", "<CMD>SearchReplaceSingleBufferCWord<CR>", desc = "[w]ord" },
      { "<leader>rW", "<CMD>SearchReplaceSingleBufferCWORD<CR>", desc = "[W]ORD" },
      { "<leader>re", "<CMD>SearchReplaceSingleBufferCExpr<CR>", desc = "[e]xpr" },
      { "<leader>rf", "<CMD>SearchReplaceSingleBufferCFile<CR>", desc = "[f]ile" },
      { "<leader>rb", "<CMD>SearchReplaceMultiBufferSelections<CR>", desc = "SearchReplaceMultiBuffer [s]selections" },
      { "<leader>rB", "<CMD>SearchReplaceMultiBufferOpen<CR>", desc = "SearchReplaceMultiBuffer [o]open" },
    },
  },

  -- Better notifications for Hyprland
  {
    "rcarriga/nvim-notify",
    opts = {
      background_colour = "#000000",
      fps = 30,
      icons = {
        DEBUG = "",
        ERROR = "",
        INFO = "",
        TRACE = "✎",
        WARN = ""
      },
      level = 2,
      minimum_width = 50,
      render = "default",
      stages = "fade_in_slide_out",
      timeout = 5000,
      top_down = true
    },
    config = function(_, opts)
      require("notify").setup(opts)
      vim.notify = require("notify")
      
      -- Integration with Hyprland notifications
      vim.api.nvim_create_user_command("NotifySystem", function(args)
        local message = args.args
        vim.notify(message, vim.log.levels.INFO, { title = "System" })
        -- Also send to Hyprland notification daemon
        vim.fn.system(string.format("notify-send 'Neovim' '%s'", message))
      end, { nargs = 1 })
    end,
  },

  -- Arch Linux specific tools
  {
    "akinsho/toggleterm.nvim",
    opts = function(_, opts)
      -- Add Arch Linux specific terminals
      local Terminal = require("toggleterm.terminal").Terminal
      
      -- Pacman terminal
      local pacman = Terminal:new({
        cmd = "sudo pacman -Syu",
        dir = "git_dir",
        direction = "float",
        float_opts = {
          border = "double",
        },
        on_open = function(term)
          vim.cmd("startinsert!")
        end,
      })
      
      -- AUR helper (yay/paru)
      local aur = Terminal:new({
        cmd = "yay -Syu",
        dir = "git_dir", 
        direction = "float",
        float_opts = {
          border = "double",
        },
        on_open = function(term)
          vim.cmd("startinsert!")
        end,
      })
      
      -- System monitor
      local htop = Terminal:new({
        cmd = "htop",
        direction = "float",
        float_opts = {
          border = "double",
        },
      })
      
      function _pacman_toggle()
        pacman:toggle()
      end
      
      function _aur_toggle()
        aur:toggle()
      end
      
      function _htop_toggle()
        htop:toggle()
      end
      
      -- Add keymaps
      vim.api.nvim_set_keymap("n", "<leader>tp", "<cmd>lua _pacman_toggle()<CR>", { noremap = true, silent = true, desc = "Pacman update" })
      vim.api.nvim_set_keymap("n", "<leader>ta", "<cmd>lua _aur_toggle()<CR>", { noremap = true, silent = true, desc = "AUR update" })
      vim.api.nvim_set_keymap("n", "<leader>th", "<cmd>lua _htop_toggle()<CR>", { noremap = true, silent = true, desc = "System monitor" })
      
      return opts
    end,
  },
}