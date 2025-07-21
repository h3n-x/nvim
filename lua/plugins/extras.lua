return {
  -- Better vim.ui
  {
    "stevearc/dressing.nvim",
    lazy = true,
    init = function()
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.select(...)
      end
      vim.ui.input = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.input(...)
      end
    end,
    opts = {},
  },
  
  -- Trouble
  {
    "folke/trouble.nvim",
    opts = {
      use_diagnostic_signs = true,
      auto_open = false,
      auto_close = false,
      auto_preview = true,
      auto_fold = false,
      signs = {
        error = "",
        warning = "",
        hint = "",
        information = "",
        other = "﫠",
      },
    },
  },
  
  -- Todo comments
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      keywords = {
        FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
        TODO = { icon = " ", color = "info" },
        HACK = { icon = " ", color = "warning" },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
        PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
        TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
      },
      colors = {
        error = { "#AC02EC" },
        warning = { "#de78f5" },
        info = { "#3706CC" },
        hint = { "#8D02D5" },
        default = { "#7007CF" },
        test = { "#5A04A7" },
      },
    },
  },
  
  -- Persistence
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = { options = vim.opt.sessionoptions:get() },
    keys = {
      { "<leader>qs", function() require("persistence").load() end, desc = "Restore Session" },
      { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      { "<leader>qd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
    },
  },
  
  -- Zen mode
  {
    "folke/zen-mode.nvim",
    opts = {
      window = {
        backdrop = 0.95,
        width = 120,
        height = 1,
        options = {
          signcolumn = "no",
          number = false,
          relativenumber = false,
          cursorline = false,
          cursorcolumn = false,
          foldcolumn = "0",
          list = false,
        },
      },
    },
    keys = {
      { "<leader>zz", function() require("zen-mode").toggle() end, desc = "Toggle Zen Mode" },
    },
  },
}