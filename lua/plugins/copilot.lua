return {
  -- GitHub Copilot - Plugin principal
  {
    "github/copilot.vim",
    event = "InsertEnter",
    config = function()
      -- Configuración básica de Copilot
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_assume_mapped = true
      vim.g.copilot_tab_fallback = ""
      
      -- Configurar teclas personalizadas
      vim.keymap.set("i", "<C-J>", 'copilot#Accept("\\<CR>")', {
        expr = true,
        replace_keycodes = false,
        desc = "Accept Copilot suggestion"
      })
      
      vim.keymap.set("i", "<C-H>", "<Plug>(copilot-dismiss)", { desc = "Dismiss Copilot suggestion" })
      vim.keymap.set("i", "<C-L>", "<Plug>(copilot-next)", { desc = "Next Copilot suggestion" })
      vim.keymap.set("i", "<C-K>", "<Plug>(copilot-previous)", { desc = "Previous Copilot suggestion" })
      
      -- Configurar filetypes donde Copilot está habilitado/deshabilitado
      vim.g.copilot_filetypes = {
        ["*"] = true,
        ["gitcommit"] = false,
        ["gitrebase"] = false,
        ["hgcommit"] = false,
        ["svn"] = false,
        ["cvs"] = false,
        [".env"] = false,
      }
      
      -- Configuración de workspace
      vim.g.copilot_workspace_folders = { vim.fn.getcwd() }
    end,
  },
  
  -- Copilot Chat - Interfaz de chat con IA
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { "github/copilot.vim" },
      { "nvim-lua/plenary.nvim" },
    },
    build = "make tiktoken",
    event = "VeryLazy",
    opts = {
      debug = false,
      model = "gpt-4",
      temperature = 0.1,
      question_header = "## User ",
      answer_header = "## Copilot ",
      error_header = "## Error ",
      separator = " ",
      show_folds = true,
      show_help = true,
      auto_follow_cursor = true,
      auto_insert_mode = false,
      clear_chat_on_new_prompt = false,
      context = nil,
      history_path = vim.fn.stdpath("data") .. "/copilotchat_history",
      callback = nil,
      
      -- Configuración de ventana
      window = {
        layout = "vertical",
        width = 0.5,
        height = 0.5,
        row = nil,
        col = nil,
        relative = "editor",
        border = "single",
        title = "Copilot Chat",
        footer = nil,
        zindex = 1,
      },
      
      -- Mapeos de teclas
      mappings = {
        complete = {
          detail = "Use @<Tab> or /<Tab> for options.",
          insert = "<Tab>",
        },
        close = {
          normal = "q",
          insert = "<C-c>",
        },
        reset = {
          normal = "<C-r>",
          insert = "<C-r>",
        },
        submit_prompt = {
          normal = "<CR>",
          insert = "<C-s>",
        },
        accept_diff = {
          normal = "<C-y>",
          insert = "<C-y>",
        },
        yank_diff = {
          normal = "gy",
          register = '"',
        },
        show_diff = {
          normal = "gd",
        },
        show_system_prompt = {
          normal = "gp",
        },
        show_user_selection = {
          normal = "gs",
        },
      },
      
      -- Prompts predefinidos para diferentes tareas
      prompts = {
        Explain = {
          prompt = "/COPILOT_EXPLAIN Write an explanation for the active selection as paragraphs of text.",
        },
        Review = {
          prompt = "/COPILOT_REVIEW Review the selected code.",
          callback = function(response, source)
            -- Lógica personalizada para revisión de código
          end,
        },
        Fix = {
          prompt = "/COPILOT_GENERATE There is a problem in this code. Rewrite the code to show it with the bug fixed.",
        },
        Optimize = {
          prompt = "/COPILOT_GENERATE Optimize the selected code to improve performance and readability.",
        },
        Docs = {
          prompt = "/COPILOT_GENERATE Please add documentation comment for the selection.",
        },
        Tests = {
          prompt = "/COPILOT_GENERATE Please generate tests for my code.",
        },
        FixDiagnostic = {
          prompt = "Please assist with the following diagnostic issue in file:",
          selection = function(source)
            return require("CopilotChat.select").diagnostics(source)
          end,
        },
        Commit = {
          prompt = "Write commit message for the change with commitizen convention. Make sure the title has maximum 50 characters and message is wrapped at 72 characters. Wrap the whole message in code block with language gitcommit.",
          selection = function(source)
            return require("CopilotChat.select").gitdiff(source)
          end,
        },
        CommitStaged = {
          prompt = "Write commit message for the change with commitizen convention. Make sure the title has maximum 50 characters and message is wrapped at 72 characters. Wrap the whole message in code block with language gitcommit.",
          selection = function(source)
            return require("CopilotChat.select").gitdiff(source, true)
          end,
        },
      },
    },
    config = function(_, opts)
      local chat = require("CopilotChat")
      local select = require("CopilotChat.select")
      
      -- Configurar el plugin
      chat.setup(opts)
      
      -- Configurar integración con telescope si está disponible
      pcall(function()
        require("CopilotChat.integrations.telescope").setup()
      end)
      
      -- Autocomandos para mejorar la experiencia
      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "copilot-*",
        callback = function()
          vim.opt_local.relativenumber = true
          vim.opt_local.number = true
          
          -- Mapeos específicos para el buffer de chat
          local opts_buf = { buffer = true }
          vim.keymap.set("n", "q", function()
            chat.close()
          end, opts_buf)
        end,
      })
    end,
    keys = {
      -- Chat commands
      { "<leader>cc", "<cmd>CopilotChat<cr>", desc = "CopilotChat - Open in vertical split" },
      { "<leader>cx", "<cmd>CopilotChatExplain<cr>", desc = "CopilotChat - Explain code" },
      { "<leader>ct", "<cmd>CopilotChatTests<cr>", desc = "CopilotChat - Generate tests" },
      { "<leader>cr", "<cmd>CopilotChatReview<cr>", desc = "CopilotChat - Review code" },
      { "<leader>cR", "<cmd>CopilotChatRefactor<cr>", desc = "CopilotChat - Refactor code" },
      { "<leader>cn", "<cmd>CopilotChatBetterNamings<cr>", desc = "CopilotChat - Better Naming" },
      
      -- Chat with selection
      { "<leader>cv", ":CopilotChatVisual", mode = "x", desc = "CopilotChat - Open in vertical split" },
      { "<leader>cx", ":CopilotChatExplain<cr>", mode = "x", desc = "CopilotChat - Explain code" },
      
      -- Inline chat
      { "<leader>ci", "<cmd>CopilotChatInline<cr>", desc = "CopilotChat - Inline chat" },
      
      -- Custom input for CopilotChat
      {
        "<leader>cq",
        function()
          local input = vim.fn.input("Quick Chat: ")
          if input ~= "" then
            vim.cmd("CopilotChat " .. input)
          end
        end,
        desc = "CopilotChat - Quick chat",
      },
      
      -- Fix the issue with diagnostic
      {
        "<leader>cf",
        "<cmd>CopilotChatFixDiagnostic<cr>",
        desc = "CopilotChat - Fix Diagnostic",
      },
      
      -- Clear buffer and chat history
      { "<leader>cl", "<cmd>CopilotChatReset<cr>", desc = "CopilotChat - Clear buffer and chat history" },
      
      -- Toggle Copilot Chat Vsplit
      { "<leader>cv", "<cmd>CopilotChatToggle<cr>", desc = "CopilotChat - Toggle" },
      
      -- Copilot Chat Models
      { "<leader>c?", "<cmd>CopilotChatModels<cr>", desc = "CopilotChat - Select Models" },
    },
  },
  
  -- Copilot Status en lualine
  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    opts = function(_, opts)
      local function copilot_status()
        local status = require("copilot.api").status.data
        if status.status == "Normal" then
          return " "
        elseif status.status == "InProgress" then
          return " "
        else
          return " "
        end
      end
      
      table.insert(opts.sections.lualine_x, 1, {
        copilot_status,
        cond = function()
          return package.loaded["copilot"] and require("copilot.client").is_disabled() == false
        end,
        color = function()
          local status = require("copilot.api").status.data
          if status.status == "Normal" then
            return { fg = "#50fa7b" }
          elseif status.status == "InProgress" then
            return { fg = "#ffb86c" }
          else
            return { fg = "#ff5555" }
          end
        end,
      })
    end,
  },
  
  -- Integración con which-key para mostrar los mapeos
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      spec = {
        { "<leader>c", group = "copilot", mode = { "n", "v" } },
      },
    },
  },
}