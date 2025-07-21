return {
  -- Markdown preview
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    config = function()
      vim.g.mkdp_filetypes = { "markdown" }
      vim.g.mkdp_theme = "dark"
      vim.g.mkdp_auto_close = 0
    end,
  },
  
  -- Markdown enhanced
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = "markdown",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      heading = {
        sign = false,
        icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
      },
      code = {
        sign = false,
        width = "block",
        right_pad = 1,
      },
      dash = {
        icon = "─",
        width = "full",
      },
      bullet = {
        icons = { "●", "○", "◆", "◇" },
      },
      checkbox = {
        checked = { icon = "✓ " },
        unchecked = { icon = "✗ " },
      },
    },
  },
  
  -- Table mode
  {
    "dhruvasagar/vim-table-mode",
    ft = "markdown",
    config = function()
      vim.g.table_mode_corner = "|"
    end,
  },
}