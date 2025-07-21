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
      
      -- Configurar teclas personalizadas para GHOST TEXT (autocompletado inline)
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
  
  -- Copilot Chat - Interfaz de chat con IA y AGENTES
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    dependencies = {
      { "github/copilot.vim" },
      { "nvim-lua/plenary.nvim" },
    },
    build = "make tiktoken",
    event = "VeryLazy",
    opts = {
      -- Configuración del modelo y agente por defecto
      model = "gpt-4o", -- Modelo por defecto (puedes cambiarlo)
      agent = "copilot", -- Agente por defecto
      system_prompt = "COPILOT_INSTRUCTIONS", -- Prompt del sistema
      
      -- Configuración de temperatura y comportamiento
      temperature = 0.1,
      headless = false,
      auto_follow_cursor = true,
      auto_insert_mode = false,
      clear_chat_on_new_prompt = false,
      show_help = true,
      highlight_selection = true,
      highlight_headers = true,
      
      -- Configuración de ventana
      window = {
        layout = "vertical",
        width = 0.5,
        height = 0.5,
        relative = "editor",
        border = "rounded",
        title = "🤖 Copilot Chat",
        footer = nil,
        zindex = 1,
      },
      
      -- Configuración de autocompletado en chat
      chat_autocomplete = true,
      
      -- Headers personalizados
      question_header = "## 👤 Usuario ",
      answer_header = "## 🤖 Copilot ",
      error_header = "## ❌ Error ",
      separator = "───",
      
      -- Selección por defecto (visual o buffer completo)
      selection = function(source)
        local select = require("CopilotChat.select")
        return select.visual(source) or select.buffer(source)
      end,
      
      -- Prompts predefinidos MEJORADOS con más opciones
      prompts = {
        -- Prompts básicos
        Explain = {
          prompt = "Explica el código seleccionado de manera detallada, incluyendo su propósito, cómo funciona y cualquier patrón de diseño utilizado.",
          system_prompt = "COPILOT_EXPLAIN",
          mapping = "<leader>cce",
          description = "Explicar código seleccionado",
        },
        Review = {
          prompt = "Revisa el código seleccionado y proporciona sugerencias de mejora, identifica posibles bugs, problemas de rendimiento y mejores prácticas.",
          system_prompt = "COPILOT_REVIEW",
          mapping = "<leader>ccr",
          description = "Revisar código",
        },
        Fix = {
          prompt = "Identifica y corrige los problemas en este código. Explica qué estaba mal y cómo tus cambios solucionan los problemas.",
          mapping = "<leader>ccf",
          description = "Corregir código",
        },
        Optimize = {
          prompt = "Optimiza el código seleccionado para mejorar el rendimiento y la legibilidad. Explica tu estrategia de optimización y los beneficios.",
          mapping = "<leader>cco",
          description = "Optimizar código",
        },
        Docs = {
          prompt = "Agrega comentarios de documentación detallados al código seleccionado siguiendo las mejores prácticas del lenguaje.",
          mapping = "<leader>ccd",
          description = "Documentar código",
        },
        Tests = {
          prompt = "Genera tests unitarios completos para el código seleccionado, incluyendo casos edge y manejo de errores.",
          mapping = "<leader>cct",
          description = "Generar tests",
        },
        Commit = {
          prompt = "Escribe un mensaje de commit siguiendo la convención de Conventional Commits. Mantén el título bajo 50 caracteres.",
          context = "git:staged",
          mapping = "<leader>ccm",
          description = "Mensaje de commit",
        },
        
        -- Prompts de EDICIÓN DIRECTA
        EditFile = {
          prompt = "Edita el archivo actual con los cambios solicitados. Proporciona el código completo actualizado que debo reemplazar en el archivo.",
          mapping = "<leader>cef",
          description = "Editar archivo completo",
          callback = function(response, source)
            -- Función para aplicar cambios directamente
            local lines = vim.split(response, "\n")
            local code_lines = {}
            local in_code_block = false
            
            for _, line in ipairs(lines) do
              if line:match("^```") then
                in_code_block = not in_code_block
              elseif in_code_block then
                table.insert(code_lines, line)
              end
            end
            
            if #code_lines > 0 then
              local bufnr = source and source.bufnr or vim.api.nvim_get_current_buf()
              vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, code_lines)
              vim.notify("✅ Archivo actualizado automáticamente!")
            end
            
            return response
          end,
        },
        
        CreateFile = {
          prompt = "Crea un archivo nuevo con el contenido solicitado. Proporciona el código completo que debe ir en el archivo.",
          mapping = "<leader>ccf",
          description = "Crear archivo nuevo",
          callback = function(response, source)
            local filename = vim.fn.input("Nombre del archivo: ")
            if filename ~= "" then
              local lines = vim.split(response, "\n")
              local code_lines = {}
              local in_code_block = false
              
              for _, line in ipairs(lines) do
                if line:match("^```") then
                  in_code_block = not in_code_block
                elseif in_code_block then
                  table.insert(code_lines, line)
                end
              end
              
              if #code_lines > 0 then
                vim.fn.writefile(code_lines, filename)
                vim.cmd("edit " .. filename)
                vim.notify("✅ Archivo '" .. filename .. "' creado!")
              end
            end
            
            return response
          end,
        },
        
        ReplaceSelection = {
          prompt = "Reemplaza la selección actual con el código mejorado. Proporciona solo el código que debe reemplazar la selección.",
          mapping = "<leader>crs",
          description = "Reemplazar selección",
          callback = function(response, source)
            if source and source.start_row and source.end_row then
              local lines = vim.split(response, "\n")
              local code_lines = {}
              local in_code_block = false
              
              for _, line in ipairs(lines) do
                if line:match("^```") then
                  in_code_block = not in_code_block
                elseif in_code_block then
                  table.insert(code_lines, line)
                end
              end
              
              if #code_lines > 0 then
                vim.api.nvim_buf_set_lines(source.bufnr, source.start_row - 1, source.end_row, false, code_lines)
                vim.notify("✅ Selección reemplazada automáticamente!")
              end
            end
            
            return response
          end,
        },
        
        -- Prompts AVANZADOS para agentes
        Refactor = {
          prompt = "Refactoriza el código seleccionado aplicando principios SOLID y patrones de diseño apropiados. Mantén la funcionalidad original.",
          mapping = "<leader>ccR",
          description = "Refactorizar código",
        },
        Architecture = {
          prompt = "Analiza la arquitectura del código y sugiere mejoras estructurales, patrones de diseño y organización de módulos.",
          mapping = "<leader>cca",
          description = "Análisis de arquitectura",
        },
        Security = {
          prompt = "Revisa el código en busca de vulnerabilidades de seguridad y sugiere correcciones siguiendo las mejores prácticas de seguridad.",
          mapping = "<leader>ccs",
          description = "Revisión de seguridad",
        },
        Performance = {
          prompt = "Analiza el rendimiento del código y sugiere optimizaciones específicas, incluyendo complejidad algorítmica y uso de memoria.",
          mapping = "<leader>ccp",
          description = "Análisis de rendimiento",
        },
        Debug = {
          prompt = "Ayúdame a debuggear este código. Identifica posibles causas de bugs y sugiere estrategias de debugging.",
          mapping = "<leader>ccb",
          description = "Ayuda con debugging",
        },
        Implement = {
          prompt = "Implementa la funcionalidad descrita en los comentarios o especificaciones. Sigue las mejores prácticas del lenguaje.",
          mapping = "<leader>cci",
          description = "Implementar funcionalidad",
        },
        
        -- Prompts para AGENTES ESPECÍFICOS
        CodeAgent = {
          prompt = "Actúa como un agente de código experto. Analiza, mejora y optimiza el código siguiendo las mejores prácticas.",
          system_prompt = "Eres un agente experto en desarrollo de software con conocimiento profundo en múltiples lenguajes y frameworks.",
          mapping = "<leader>cag",
          description = "Agente de código",
        },
        ArchitectAgent = {
          prompt = "Actúa como un arquitecto de software. Diseña soluciones escalables y mantenibles.",
          system_prompt = "Eres un arquitecto de software senior especializado en diseño de sistemas y patrones arquitectónicos.",
          mapping = "<leader>car",
          description = "Agente arquitecto",
        },
        SecurityAgent = {
          prompt = "Actúa como un experto en seguridad. Identifica vulnerabilidades y sugiere soluciones seguras.",
          system_prompt = "Eres un experto en ciberseguridad especializado en seguridad de aplicaciones y código seguro.",
          mapping = "<leader>cas",
          description = "Agente de seguridad",
        },
      },
      
      -- Configuración de contextos mejorada
      contexts = {
        buffer = {
          description = "Contenido del buffer actual",
        },
        buffers = {
          description = "Contenido de todos los buffers",
        },
        file = {
          description = "Contenido de archivo específico",
        },
        files = {
          description = "Archivos del workspace",
        },
        git = {
          description = "Información de git (diff, staged, etc.)",
        },
        url = {
          description = "Contenido desde URL",
        },
        register = {
          description = "Contenido de registro de vim",
        },
        quickfix = {
          description = "Lista de quickfix",
        },
        system = {
          description = "Salida de comando del sistema",
        },
      },
      
      -- Mapeos de teclas personalizados
      mappings = {
        complete = {
          insert = "<Tab>",
        },
        close = {
          normal = "q",
          insert = "<C-c>",
        },
        reset = {
          normal = "<C-l>",
          insert = "<C-l>",
        },
        submit_prompt = {
          normal = "<CR>",
          insert = "<C-s>",
        },
        toggle_sticky = {
          normal = "grr",
        },
        clear_stickies = {
          normal = "grx",
        },
        accept_diff = {
          normal = "<C-y>",
          insert = "<C-y>",
        },
        jump_to_diff = {
          normal = "gj",
        },
        quickfix_answers = {
          normal = "gqa",
        },
        quickfix_diffs = {
          normal = "gqd",
        },
        yank_diff = {
          normal = "gy",
          register = '"',
        },
        show_diff = {
          normal = "gd",
          full_diff = true, -- Mostrar diff completo
        },
        show_info = {
          normal = "gi",
        },
        show_context = {
          normal = "gc",
        },
        show_help = {
          normal = "gh",
        },
        -- Mapeos adicionales para edición directa
        apply_diff = {
          normal = "<C-a>",
          description = "Aplicar diff automáticamente",
        },
      },
    },
    config = function(_, opts)
      local chat = require("CopilotChat")
      
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
          vim.opt_local.conceallevel = 0
          
          -- Mapeos específicos para el buffer de chat
          local opts_buf = { buffer = true }
          vim.keymap.set("n", "q", function()
            chat.close()
          end, opts_buf)
        end,
      })
    end,
    keys = {
      -- Chat básico
      { "<leader>cc", "<cmd>CopilotChat<cr>", desc = "💬 Abrir Copilot Chat" },
      { "<leader>co", "<cmd>CopilotChatOpen<cr>", desc = "📂 Abrir ventana de chat" },
      { "<leader>cq", "<cmd>CopilotChatClose<cr>", desc = "❌ Cerrar chat" },
      { "<leader>ct", "<cmd>CopilotChatToggle<cr>", desc = "🔄 Toggle chat" },
      { "<leader>cr", "<cmd>CopilotChatReset<cr>", desc = "🔄 Reset chat" },
      { "<leader>cs", "<cmd>CopilotChatStop<cr>", desc = "⏹️ Detener respuesta" },
      
      -- Selección de modelos y agentes
      { "<leader>cm", "<cmd>CopilotChatModels<cr>", desc = "🤖 Seleccionar modelo" },
      { "<leader>ca", "<cmd>CopilotChatAgents<cr>", desc = "👥 Seleccionar agente" },
      { "<leader>cp", "<cmd>CopilotChatPrompts<cr>", desc = "📝 Seleccionar prompt" },
      
      -- Historial
      { "<leader>chs", function()
        local name = vim.fn.input("Nombre para guardar: ")
        if name ~= "" then
          require("CopilotChat").save(name)
        end
      end, desc = "💾 Guardar historial" },
      { "<leader>chl", function()
        local name = vim.fn.input("Nombre a cargar: ")
        if name ~= "" then
          require("CopilotChat").load(name)
        end
      end, desc = "📂 Cargar historial" },
      
      -- Chat con selección visual
      { "<leader>cv", ":CopilotChatVisual<cr>", mode = "x", desc = "💬 Chat con selección" },
      { "<leader>cx", ":CopilotChatExplain<cr>", mode = "x", desc = "🔍 Explicar selección" },
      
      -- Chat rápido personalizado
      {
        "<leader>cq",
        function()
          local input = vim.fn.input("Pregunta rápida: ")
          if input ~= "" then
            require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
          end
        end,
        desc = "❓ Pregunta rápida",
      },
      
      -- Contextos específicos
      {
        "<leader>cgd",
        function()
          require("CopilotChat").ask("Explica los cambios en este diff", {
            context = "git:staged"
          })
        end,
        desc = "📊 Explicar git diff",
      },
      {
        "<leader>cgc",
        function()
          require("CopilotChat").ask("Escribe un mensaje de commit para estos cambios", {
            context = "git:staged"
          })
        end,
        desc = "📝 Generar commit message",
      },
      
      -- Agentes especializados
      {
        "<leader>cac",
        function()
          require("CopilotChat").ask("Revisa este código como un experto", {
            agent = "copilot",
            context = "buffer"
          })
        end,
        desc = "👨‍💻 Agente de código",
      },
      
      -- Funciones avanzadas con contexto
      {
        "<leader>cfc",
        function()
          require("CopilotChat").ask("Encuentra y corrige bugs en este código", {
            context = "buffer",
            callback = function(response)
              vim.notify("Análisis completado!")
              return response
            end
          })
        end,
        desc = "🐛 Encontrar y corregir bugs",
      },
    },
  },
  
  -- Copilot Status en lualine
  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    opts = function(_, opts)
      local function copilot_status()
        local status_ok, copilot_api = pcall(require, "copilot.api")
        if not status_ok then
          return ""
        end
        
        local status = copilot_api.status.data
        if status.status == "Normal" then
          return "🟢 "
        elseif status.status == "InProgress" then
          return "🟡 "
        else
          return "🔴 "
        end
      end
      
      table.insert(opts.sections.lualine_x, 1, {
        copilot_status,
        cond = function()
          return package.loaded["copilot"] ~= nil
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
        { "<leader>cc", group = "chat" },
        { "<leader>ca", group = "agentes" },
        { "<leader>ch", group = "historial" },
        { "<leader>cg", group = "git" },
        { "<leader>cf", group = "funciones" },
      },
    },
  },
}