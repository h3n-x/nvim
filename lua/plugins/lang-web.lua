return {
  -- CSS/SCSS/HTML
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        cssls = {
          settings = {
            css = {
              validate = true,
              lint = {
                unknownAtRules = "ignore",
              },
            },
            scss = {
              validate = true,
              lint = {
                unknownAtRules = "ignore",
              },
            },
          },
        },
        html = {
          filetypes = { "html", "templ" },
        },
        emmet_ls = {
          filetypes = { "html", "css", "scss", "sass" },
        },
      },
    },
  },
  
  -- Formatting
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        css = { "prettier" },
        scss = { "prettier" },
        html = { "prettier" },
      },
    },
  },
  
  -- Color highlighting
  {
    "NvChad/nvim-colorizer.lua",
    ft = { "css", "scss", "html", "javascript", "typescript" },
    opts = {
      user_default_options = {
        RGB = true,
        RRGGBB = true,
        names = false,
        RRGGBBAA = true,
        AARRGGBB = true,
        rgb_fn = true,
        hsl_fn = true,
        css = true,
        css_fn = true,
        mode = "background",
        tailwind = false,
        sass = { enable = true, parsers = { "css" } },
        virtualtext = "■",
      },
    },
  },
}