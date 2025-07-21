return {
  -- Rust support
  {
    "mrcjkb/rustaceanvim",
    version = "^4",
    ft = { "rust" },
    config = function()
      vim.g.rustaceanvim = {
        inlay_hints = {
          highlight = "NonText",
        },
        tools = {
          hover_actions = {
            auto_focus = true,
          },
        },
        server = {
          on_attach = function(client, bufnr)
            -- Custom keymaps for Rust
            vim.keymap.set("n", "<leader>rr", function()
              vim.cmd.RustLsp("runnables")
            end, { desc = "Rust Runnables", buffer = bufnr })
            
            vim.keymap.set("n", "<leader>rt", function()
              vim.cmd.RustLsp("testables")
            end, { desc = "Rust Testables", buffer = bufnr })
            
            vim.keymap.set("n", "<leader>rd", function()
              vim.cmd.RustLsp("debuggables")
            end, { desc = "Rust Debuggables", buffer = bufnr })
            
            vim.keymap.set("n", "<leader>re", function()
              vim.cmd.RustLsp("expandMacro")
            end, { desc = "Expand Macro", buffer = bufnr })
            
            vim.keymap.set("n", "<leader>rc", function()
              vim.cmd.RustLsp("openCargo")
            end, { desc = "Open Cargo.toml", buffer = bufnr })
            
            vim.keymap.set("n", "<leader>rp", function()
              vim.cmd.RustLsp("parentModule")
            end, { desc = "Parent Module", buffer = bufnr })
            
            vim.keymap.set("n", "<leader>rj", function()
              vim.cmd.RustLsp("joinLines")
            end, { desc = "Join Lines", buffer = bufnr })
            
            vim.keymap.set("n", "<leader>rh", function()
              vim.cmd.RustLsp({ "hover", "actions" })
            end, { desc = "Hover Actions", buffer = bufnr })
            
            vim.keymap.set("n", "<leader>rg", function()
              vim.cmd.RustLsp("codeAction")
            end, { desc = "Code Action", buffer = bufnr })
          end,
          default_settings = {
            ["rust-analyzer"] = {
              cargo = {
                allFeatures = true,
                loadOutDirsFromCheck = true,
                runBuildScripts = true,
              },
              checkOnSave = {
                allFeatures = true,
                command = "clippy",
                extraArgs = { "--no-deps" },
              },
              procMacro = {
                enable = true,
                ignored = {
                  ["async-trait"] = { "async_trait" },
                  ["napi-derive"] = { "napi" },
                  ["async-recursion"] = { "async_recursion" },
                },
              },
            },
          },
        },
      }
    end,
  },

  -- Crates.nvim for Cargo.toml
  {
    "saecki/crates.nvim",
    ft = { "rust", "toml" },
    config = function()
      require("crates").setup({
        src = {
          cmp = {
            enabled = true,
          },
        },
        null_ls = {
          enabled = true,
          name = "crates.nvim",
        },
        popup = {
          autofocus = true,
          hide_on_select = true,
          copy_register = '"',
          style = "minimal",
          border = "rounded",
          show_version_date = false,
          show_dependency_version = true,
          max_height = 30,
          min_width = 20,
          padding = 1,
        },
        completion = {
          cmp = {
            enabled = true,
          },
          crates = {
            enabled = true,
            max_results = 8,
            min_chars = 3,
          },
        },
        lsp = {
          enabled = true,
          on_attach = function(client, bufnr)
            -- Crates-specific keymaps
            vim.keymap.set("n", "<leader>ct", require("crates").toggle, { desc = "Toggle Crates", buffer = bufnr })
            vim.keymap.set("n", "<leader>cr", require("crates").reload, { desc = "Reload Crates", buffer = bufnr })
            vim.keymap.set("n", "<leader>cv", require("crates").show_versions_popup, { desc = "Show Versions", buffer = bufnr })
            vim.keymap.set("n", "<leader>cf", require("crates").show_features_popup, { desc = "Show Features", buffer = bufnr })
            vim.keymap.set("n", "<leader>cd", require("crates").show_dependencies_popup, { desc = "Show Dependencies", buffer = bufnr })
            vim.keymap.set("n", "<leader>cu", require("crates").update_crate, { desc = "Update Crate", buffer = bufnr })
            vim.keymap.set("v", "<leader>cu", require("crates").update_crates, { desc = "Update Crates", buffer = bufnr })
            vim.keymap.set("n", "<leader>ca", require("crates").update_all_crates, { desc = "Update All Crates", buffer = bufnr })
            vim.keymap.set("n", "<leader>cU", require("crates").upgrade_crate, { desc = "Upgrade Crate", buffer = bufnr })
            vim.keymap.set("v", "<leader>cU", require("crates").upgrade_crates, { desc = "Upgrade Crates", buffer = bufnr })
            vim.keymap.set("n", "<leader>cA", require("crates").upgrade_all_crates, { desc = "Upgrade All Crates", buffer = bufnr })
            vim.keymap.set("n", "<leader>ce", require("crates").expand_plain_crate_to_inline_table, { desc = "Expand Crate", buffer = bufnr })
            vim.keymap.set("n", "<leader>cE", require("crates").extract_crate_into_table, { desc = "Extract Crate", buffer = bufnr })
            vim.keymap.set("n", "<leader>cH", require("crates").open_homepage, { desc = "Open Homepage", buffer = bufnr })
            vim.keymap.set("n", "<leader>cR", require("crates").open_repository, { desc = "Open Repository", buffer = bufnr })
            vim.keymap.set("n", "<leader>cD", require("crates").open_documentation, { desc = "Open Documentation", buffer = bufnr })
            vim.keymap.set("n", "<leader>cC", require("crates").open_crates_io, { desc = "Open Crates.io", buffer = bufnr })
          end,
          actions = true,
          completion = true,
          hover = true,
        },
      })
    end,
  },
}