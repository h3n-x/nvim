return {
  -- Better startup performance
  {
    "lewis6991/impatient.nvim",
    config = function()
      require("impatient")
    end,
  },

  -- Profiling tools
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    config = function()
      vim.g.startuptime_tries = 10
    end,
  },

  -- Memory management
  {
    "nvim-lua/plenary.nvim",
    config = function()
      -- Auto garbage collection for better performance
      vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
        callback = function()
          if vim.fn.reltimestr(vim.fn.reltime()) > "30" then
            collectgarbage("collect")
          end
        end,
      })
    end,
  },

  -- Better buffer management
  {
    "famiu/bufdelete.nvim",
    keys = {
      { "<leader>bd", "<cmd>Bdelete<cr>", desc = "Delete Buffer (keep window)" },
      { "<leader>bD", "<cmd>Bdelete!<cr>", desc = "Delete Buffer (force)" },
    },
  },

  -- Session management with better performance
  {
    "folke/persistence.nvim",
    opts = function(_, opts)
      opts.options = vim.opt.sessionoptions:get()
      -- Add performance optimizations
      opts.pre_save = function()
        -- Close unnecessary buffers before saving session
        vim.cmd("silent! %bdelete")
        vim.cmd("silent! only")
      end
      return opts
    end,
  },

  -- Faster file operations
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        config = function()
          require("telescope").load_extension("fzf")
        end,
      },
      {
        "nvim-telescope/telescope-file-browser.nvim",
        config = function()
          require("telescope").load_extension("file_browser")
        end,
      },
    },
    opts = function(_, opts)
      opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
        file_ignore_patterns = {
          "node_modules",
          ".git/",
          "dist/",
          "build/",
          "__pycache__/",
          "*.pyc",
          "*.o",
          "*.so",
          "*.a",
          ".cache/",
          ".local/share/",
          ".mozilla/",
          ".steam/",
        },
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--hidden",
          "--glob=!.git/",
        },
      })
      
      opts.pickers = vim.tbl_deep_extend("force", opts.pickers or {}, {
        find_files = {
          find_command = { "fd", "--type", "f", "--hidden", "--exclude", ".git" },
        },
        live_grep = {
          additional_args = function()
            return { "--hidden", "--glob=!.git/" }
          end,
        },
      })
      
      return opts
    end,
    keys = {
      { "<leader>fb", "<cmd>Telescope file_browser<cr>", desc = "File Browser" },
      { "<leader>fB", "<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>", desc = "File Browser (current dir)" },
    },
  },
}