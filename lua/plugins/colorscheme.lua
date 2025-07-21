-- Catppuccin with pywal colors
return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "mocha",
      background = {
        light = "latte",
        dark = "mocha",
      },
      transparent_background = false,
      show_end_of_buffer = false,
      term_colors = true,
      dim_inactive = {
        enabled = false,
        shade = "dark",
        percentage = 0.15,
      },
      no_italic = false,
      no_bold = false,
      no_underline = false,
      styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
      },
      color_overrides = {
        mocha = {
          base = "#1d1d28",     -- background
          mantle = "#1d1d28",   -- background
          crust = "#1d1d28",    -- background
          
          surface0 = "#ACB8D1", -- color1
          surface1 = "#B7C6DA", -- color2
          surface2 = "#BDCBE0", -- color3
          
          overlay0 = "#CAD2DD", -- color4
          overlay1 = "#D6D9E4", -- color5
          overlay2 = "#E1DEE7", -- color6
          
          text = "#e6e7ea",     -- foreground
          subtext1 = "#e6e7ea", -- foreground
          subtext0 = "#a1a1a3", -- color8
          
          lavender = "#E1DEE7", -- color6
          blue = "#B7C6DA",     -- color2
          sapphire = "#BDCBE0", -- color3
          sky = "#D6D9E4",      -- color5
          teal = "#ACB8D1",     -- color1
          green = "#E1DEE7",    -- color6
          yellow = "#e6e7ea",   -- color7
          peach = "#CAD2DD",    -- color4
          maroon = "#ACB8D1",   -- color1
          red = "#E1DEE7",      -- color6
          mauve = "#D6D9E4",    -- color5
          pink = "#e6e7ea",     -- color7
          flamingo = "#a1a1a3", -- color8
          rosewater = "#e6e7ea", -- color7
        },
      },
      default_integrations = true,
      integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        notify = true,
        mini = {
          enabled = true,
          indentscope_color = "",
        },
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
          },
          underlines = {
            errors = { "underline" },
            hints = { "underline" },
            warnings = { "underline" },
            information = { "underline" },
          },
        },
        telescope = {
          enabled = true,
        },
        fzf = true,
        flash = true,
        alpha = true,
        dashboard = true,
        which_key = true,
        indent_blankline = {
          enabled = true,
          scope_color = "",
          colored_indent_levels = false,
        },
        markdown = true,
        mason = true,
        lsp_saga = true,
        dap = true,
        dap_ui = true,
        barbecue = {
          dim_dirname = true,
          bold_basename = true,
          dim_context = false,
          alt_background = false,
        },
      },
    },
  },
  
  -- Configure LazyVim to use catppuccin
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}