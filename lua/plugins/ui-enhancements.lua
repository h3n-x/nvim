return {
  -- Better UI components
  {
    "stevearc/dressing.nvim",
    opts = {
      input = {
        enabled = true,
        default_prompt = "Input:",
        title_pos = "left",
        insert_only = true,
        start_in_insert = true,
        border = "rounded",
        relative = "cursor",
        prefer_width = 40,
        width = nil,
        max_width = { 140, 0.9 },
        min_width = { 20, 0.2 },
        buf_options = {},
        win_options = {
          winblend = 10,
          wrap = false,
          list = true,
          listchars = "precedes:…,extends:…",
          sidescrolloff = 0,
        },
        mappings = {
          n = {
            ["<Esc>"] = "Close",
            ["<CR>"] = "Confirm",
          },
          i = {
            ["<C-c>"] = "Close",
            ["<CR>"] = "Confirm",
            ["<Up>"] = "HistoryPrev",
            ["<Down>"] = "HistoryNext",
          },
        },
        override = function(conf)
          conf.col = -1
          conf.row = 0
          return conf
        end,
        get_config = nil,
      },
      select = {
        enabled = true,
        backend = { "telescope", "fzf_lua", "fzf", "builtin", "nui" },
        trim_prompt = true,
        telescope = require("telescope.themes").get_dropdown({
          winblend = 10,
          width = 0.5,
          previewer = false,
        }),
        fzf = {
          window = {
            width = 0.5,
            height = 0.4,
          },
        },
        fzf_lua = {
          winopts = {
            height = 0.5,
            width = 0.5,
          },
        },
        nui = {
          position = "50%",
          size = nil,
          relative = "editor",
          border = {
            style = "rounded",
          },
          buf_options = {
            swapfile = false,
            filetype = "DressingSelect",
          },
          win_options = {
            winblend = 10,
          },
          max_width = 80,
          max_height = 40,
          min_width = 40,
          min_height = 10,
        },
        builtin = {
          show_numbers = true,
          border = "rounded",
          relative = "editor",
          buf_options = {},
          win_options = {
            winblend = 10,
          },
          width = nil,
          max_width = { 140, 0.8 },
          min_width = { 40, 0.2 },
          height = nil,
          max_height = 0.9,
          min_height = { 10, 0.2 },
          mappings = {
            ["<Esc>"] = "Close",
            ["<C-c>"] = "Close",
            ["<CR>"] = "Confirm",
          },
          override = function(conf)
            return conf
          end,
        },
        format_item_override = {},
        get_config = nil,
      },
    },
  },

  -- Better quickfix
  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    config = function()
      require("bqf").setup({
        auto_enable = true,
        auto_resize_height = true,
        preview = {
          win_height = 12,
          win_vheight = 12,
          delay_syntax = 80,
          border_chars = { "┃", "┃", "━", "━", "┏", "┓", "┗", "┛", "█" },
          should_preview_cb = function(bufnr, qwinid)
            local ret = true
            local bufname = vim.api.nvim_buf_get_name(bufnr)
            local fsize = vim.fn.getfsize(bufname)
            if fsize > 100 * 1024 then
              ret = false
            end
            return ret
          end,
        },
        func_map = {
          drop = "o",
          openc = "O",
          split = "<C-s>",
          tabdrop = "<C-t>",
          tabc = "",
          ptogglemode = "z,",
        },
        filter = {
          fzf = {
            action_for = { ["ctrl-s"] = "split", ["ctrl-t"] = "tab drop" },
            extra_opts = { "--bind", "ctrl-o:toggle-all", "--prompt", "> " },
          },
        },
      })
    end,
  },

  -- Smooth scrolling
  {
    "karb94/neoscroll.nvim",
    config = function()
      require("neoscroll").setup({
        mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
        hide_cursor = true,
        stop_eof = true,
        respect_scrolloff = false,
        cursor_scrolls_alone = true,
        easing_function = nil,
        pre_hook = nil,
        post_hook = nil,
        performance_mode = false,
      })
    end,
  },

  -- Better fold
  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    config = function()
      vim.o.foldcolumn = "1"
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      require("ufo").setup({
        provider_selector = function(bufnr, filetype, buftype)
          return { "treesitter", "indent" }
        end,
      })
    end,
    keys = {
      { "zR", function() require("ufo").openAllFolds() end, desc = "Open all folds" },
      { "zM", function() require("ufo").closeAllFolds() end, desc = "Close all folds" },
      { "zr", function() require("ufo").openFoldsExceptKinds() end, desc = "Fold less" },
      { "zm", function() require("ufo").closeFoldsWith() end, desc = "Fold more" },
      { "zp", function() require("ufo").peekFoldedLinesUnderCursor() end, desc = "Peek fold" },
    },
  },

  -- Color picker
  {
    "uga-rosa/ccc.nvim",
    config = function()
      require("ccc").setup({
        highlighter = {
          auto_enable = true,
          lsp = true,
        },
        pickers = {
          require("ccc").picker.hex,
          require("ccc").picker.css_rgb,
          require("ccc").picker.css_hsl,
          require("ccc").picker.css_hwb,
          require("ccc").picker.css_lab,
          require("ccc").picker.css_lch,
          require("ccc").picker.css_oklab,
          require("ccc").picker.css_oklch,
        },
        alpha_show = "auto",
        recognize = {
          input = true,
          output = true,
        },
        inputs = {
          require("ccc").input.rgb,
          require("ccc").input.hsl,
          require("ccc").input.cmyk,
        },
        outputs = {
          require("ccc").output.hex,
          require("ccc").output.hex_short,
          require("ccc").output.css_rgb,
          require("ccc").output.css_hsl,
        },
        convert = {
          { require("ccc").picker.hex, require("ccc").output.css_hsl },
          { require("ccc").picker.css_rgb, require("ccc").output.css_hsl },
          { require("ccc").picker.css_hsl, require("ccc").output.hex },
        },
        mappings = {
          ["q"] = require("ccc").mapping.quit,
          ["<CR>"] = require("ccc").mapping.complete,
        },
      })
    end,
    keys = {
      { "<leader>cp", "<cmd>CccPick<cr>", desc = "Color Picker" },
      { "<leader>ct", "<cmd>CccConvert<cr>", desc = "Convert Color" },
      { "<leader>ch", "<cmd>CccHighlighterToggle<cr>", desc = "Toggle Color Highlighter" },
    },
  },

  -- Better statusline with system info
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      -- Add system monitoring to lualine
      local function get_system_info()
        if _G.system_info then
          local mem = _G.system_info.get_memory()
          local cpu = _G.system_info.get_cpu()
          return string.format("󰍛 %s 󰻠 %s", mem, cpu)
        end
        return ""
      end
      
      local function get_lsp_clients()
        local clients = vim.lsp.get_active_clients({ bufnr = 0 })
        if #clients == 0 then
          return ""
        end
        
        local client_names = {}
        for _, client in ipairs(clients) do
          table.insert(client_names, client.name)
        end
        return "󰒋 " .. table.concat(client_names, ", ")
      end
      
      -- Extend existing sections
      table.insert(opts.sections.lualine_x, 1, {
        get_lsp_clients,
        cond = function()
          return #vim.lsp.get_active_clients({ bufnr = 0 }) > 0
        end,
        color = { fg = "#7aa2f7" },
      })
      
      table.insert(opts.sections.lualine_y, 1, {
        get_system_info,
        cond = function()
          return _G.system_info ~= nil
        end,
        color = { fg = "#9ece6a" },
      })
      
      return opts
    end,
  },

  -- Hyprland specific window management
  {
    "nvim-lua/plenary.nvim",
    config = function()
      -- Hyprland integration functions
      _G.hyprland = {
        get_active_window = function()
          local handle = io.popen("hyprctl activewindow -j")
          local result = handle:read("*a")
          handle:close()
          return vim.fn.json_decode(result)
        end,
        
        focus_window = function(direction)
          vim.fn.system("hyprctl dispatch movefocus " .. direction)
        end,
        
        move_window = function(direction)
          vim.fn.system("hyprctl dispatch movewindow " .. direction)
        end,
        
        resize_window = function(direction, amount)
          vim.fn.system(string.format("hyprctl dispatch resizeactive %s %d", direction, amount))
        end,
        
        toggle_floating = function()
          vim.fn.system("hyprctl dispatch togglefloating")
        end,
        
        toggle_fullscreen = function()
          vim.fn.system("hyprctl dispatch fullscreen")
        end,
      }
      
      -- Auto-commands for Hyprland integration
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          -- Set window title for Hyprland
          vim.opt.title = true
          vim.opt.titlestring = "Neovim - %F"
        end,
      })
    end,
  },
}