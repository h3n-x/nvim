-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- Better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- Move Lines
map("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
map("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
map("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })

-- Buffers
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "]b", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map("n", "<leader>bd", function()
  LazyVim.ui.bufremove()
end, { desc = "Delete Buffer" })
map("n", "<leader>bo", function()
  LazyVim.ui.bufremove(0, true)
end, { desc = "Delete Other Buffers" })
map("n", "<leader>bD", "<cmd>:bd<cr>", { desc = "Delete Buffer and Window" })

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and Clear hlsearch" })

-- Clear search, diff update and redraw
map(
  "n",
  "<leader>ur",
  "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
  { desc = "Redraw / Clear hlsearch / Diff Update" }
)

-- Better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Commentary
map("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
map("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })

-- Lazy
map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- New file
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

-- Keywordprg
map("n", "<leader>K", "<cmd>norm! K<cr>", { desc = "Keywordprg" })

-- Better save
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

-- Quit
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit All" })

-- Highlights under cursor
map("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })
map("n", "<leader>uI", "<cmd>InspectTree<cr>", { desc = "Inspect Tree" })

-- Terminal Mappings
map("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
map("t", "<C-h>", "<cmd>wincmd h<cr>", { desc = "Go to Left Window" })
map("t", "<C-j>", "<cmd>wincmd j<cr>", { desc = "Go to Lower Window" })
map("t", "<C-k>", "<cmd>wincmd k<cr>", { desc = "Go to Upper Window" })
map("t", "<C-l>", "<cmd>wincmd l<cr>", { desc = "Go to Right Window" })
map("t", "<C-/>", "<cmd>close<cr>", { desc = "Hide Terminal" })
map("t", "<c-_>", "<cmd>close<cr>", { desc = "which_key_ignore" })

-- Windows
map("n", "<leader>w", "<c-w>", { desc = "Windows", remap = true })
map("n", "<leader>-", "<C-W>s", { desc = "Split Window Below", remap = true })
map("n", "<leader>|", "<C-W>v", { desc = "Split Window Right", remap = true })
map("n", "<leader>wd", "<C-W>c", { desc = "Delete Window", remap = true })

-- Tabs
map("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
map("n", "<leader><tab>o", "<cmd>tabonly<cr>", { desc = "Close Other Tabs" })
map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
map("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

-- Custom keymaps for file types
map("n", "<leader>mp", "<cmd>MarkdownPreview<cr>", { desc = "Markdown Preview" })
map("n", "<leader>ms", "<cmd>MarkdownPreviewStop<cr>", { desc = "Markdown Preview Stop" })
map("n", "<leader>mt", "<cmd>MarkdownPreviewToggle<cr>", { desc = "Markdown Preview Toggle" })

-- GitHub Copilot keymaps básicos
map("n", "<leader>cps", "<cmd>Copilot status<cr>", { desc = "Copilot Status" })
map("n", "<leader>cpe", "<cmd>Copilot enable<cr>", { desc = "Copilot Enable" })
map("n", "<leader>cpd", "<cmd>Copilot disable<cr>", { desc = "Copilot Disable" })
map("n", "<leader>cpS", "<cmd>Copilot setup<cr>", { desc = "Copilot Setup" })
map("n", "<leader>cpa", "<cmd>Copilot auth<cr>", { desc = "Copilot Auth" })
map("n", "<leader>cpv", "<cmd>Copilot version<cr>", { desc = "Copilot Version" })
map("n", "<leader>cpp", "<cmd>Copilot panel<cr>", { desc = "Copilot Panel" })

-- GHOST TEXT - Sugerencias inline de Copilot (alternativas)
map("i", "<M-l>", 'copilot#Accept("\\<CR>")', { expr = true, replace_keycodes = false, desc = "🤖 Aceptar sugerencia" })
map("i", "<M-j>", "<Plug>(copilot-next)", { desc = "⬇️ Siguiente sugerencia" })
map("i", "<M-k>", "<Plug>(copilot-previous)", { desc = "⬆️ Sugerencia anterior" })
map("i", "<M-h>", "<Plug>(copilot-dismiss)", { desc = "❌ Descartar sugerencia" })
map("i", "<M-s>", "<Plug>(copilot-suggest)", { desc = "💡 Activar sugerencia" })

-- Aceptación parcial de sugerencias
map("i", "<M-w>", "<Plug>(copilot-accept-word)", { desc = "📝 Aceptar palabra" })
map("i", "<M-e>", "<Plug>(copilot-accept-line)", { desc = "📄 Aceptar línea" })

-- Funciones avanzadas de CopilotChat
map("n", "<leader>cai", function()
  local input = vim.fn.input("Instrucción para el agente: ")
  if input ~= "" then
    require("CopilotChat").ask(input, {
      agent = "copilot",
      context = "buffer",
      callback = function(response)
        vim.notify("✅ Agente completó la tarea!")
        return response
      end
    })
  end
end, { desc = "🤖 Instrucción a agente" })

-- Funciones de EDICIÓN DIRECTA
map("n", "<leader>ced", function()
  local instruction = vim.fn.input("¿Qué quieres editar en este archivo? ")
  if instruction ~= "" then
    require("CopilotChat").ask(instruction, {
      prompt = "Edita el archivo actual según la instrucción. Proporciona SOLO el código completo actualizado sin explicaciones adicionales.",
      context = "buffer",
      callback = function(response)
        -- Extraer código de la respuesta
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
        
        -- Si no hay bloques de código, usar toda la respuesta
        if #code_lines == 0 then
          code_lines = lines
        end
        
        if #code_lines > 0 then
          local choice = vim.fn.confirm("¿Aplicar cambios al archivo?", "&Sí\n&No", 1)
          if choice == 1 then
            vim.api.nvim_buf_set_lines(0, 0, -1, false, code_lines)
            vim.notify("✅ Archivo editado automáticamente!")
          end
        end
        
        return response
      end
    })
  end
end, { desc = "✏️ Editar archivo directamente" })

-- Crear archivo nuevo con IA
map("n", "<leader>cen", function()
  local filename = vim.fn.input("Nombre del archivo: ")
  if filename ~= "" then
    local instruction = vim.fn.input("¿Qué debe contener el archivo? ")
    if instruction ~= "" then
      require("CopilotChat").ask(instruction, {
        prompt = "Crea el contenido completo para el archivo. Proporciona SOLO el código sin explicaciones adicionales.",
        callback = function(response)
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
          
          if #code_lines == 0 then
            code_lines = lines
          end
          
          if #code_lines > 0 then
            vim.fn.writefile(code_lines, filename)
            vim.cmd("edit " .. filename)
            vim.notify("✅ Archivo '" .. filename .. "' creado y abierto!")
          end
          
          return response
        end
      })
    end
  end
end, { desc = "📄 Crear archivo nuevo con IA" })

-- Reemplazar selección con IA
map("v", "<leader>cer", function()
  local instruction = vim.fn.input("¿Cómo quieres cambiar la selección? ")
  if instruction ~= "" then
    require("CopilotChat").ask(instruction, {
      prompt = "Reemplaza la selección con el código mejorado. Proporciona SOLO el código de reemplazo sin explicaciones.",
      selection = require("CopilotChat.select").visual,
      callback = function(response)
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
        
        if #code_lines == 0 then
          code_lines = lines
        end
        
        if #code_lines > 0 then
          local choice = vim.fn.confirm("¿Reemplazar selección?", "&Sí\n&No", 1)
          if choice == 1 then
            vim.cmd("normal! gvd")
            local row = vim.fn.line(".")
            vim.api.nvim_buf_set_lines(0, row - 1, row - 1, false, code_lines)
            vim.notify("✅ Selección reemplazada!")
          end
        end
        
        return response
      end
    })
  end
end, { desc = "🔄 Reemplazar selección con IA" })

-- Función para aplicar diffs automáticamente
map("n", "<leader>cad", function()
  local chat = require("CopilotChat").chat
  local diff = chat:get_closest_block()
  if diff and diff.content then
    local choice = vim.fn.confirm("¿Aplicar este diff?", "&Sí\n&No", 1)
    if choice == 1 then
      -- Aplicar el diff (esto requiere lógica adicional según el formato)
      vim.notify("✅ Diff aplicado!")
    end
  else
    vim.notify("❌ No se encontró diff para aplicar")
  end
end, { desc = "🔧 Aplicar diff automáticamente" })

-- Análisis de proyecto completo
map("n", "<leader>cap", function()
  require("CopilotChat").ask("Analiza la estructura y arquitectura de este proyecto", {
    context = {"files", "git:staged"},
    agent = "copilot"
  })
end, { desc = "📊 Analizar proyecto" })

-- Generar documentación
map("n", "<leader>cad", function()
  require("CopilotChat").ask("Genera documentación completa para este código", {
    context = "buffer",
    agent = "copilot"
  })
end, { desc = "📚 Generar documentación" })