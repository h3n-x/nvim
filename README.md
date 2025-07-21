# Configuración de Neovim con GitHub Copilot

Esta es una configuración completa de Neovim basada en LazyVim optimizada para **Arch Linux + Hyprland** con integración completa de GitHub Copilot, incluyendo **agentes de IA** y **ghost text** avanzado.

## Características principales

- **LazyVim**: Configuración base moderna y eficiente
- **Optimizado para Arch Linux + Hyprland**: Integración nativa con el sistema
- **GitHub Copilot**: Autocompletado con IA integrado con **ghost text**
- **Copilot Chat**: Interfaz de chat para interactuar con **agentes de IA**
- **Agentes especializados**: Código, arquitectura, seguridad, debugging
- **Soporte completo para múltiples lenguajes**: Python, JavaScript, TypeScript, Lua, etc.
- **Tema personalizado**: Catppuccin con colores personalizados
- **Herramientas de sistema**: Integración con pacman, AUR, y herramientas de Arch
- **Gestión de ventanas Hyprland**: Controles nativos desde Neovim

## GitHub Copilot

### Configuración inicial

1. Instala las dependencias:
   ```bash
   # Asegúrate de tener Node.js instalado
   node --version
   ```

2. Inicia Neovim y ejecuta:
   ```vim
   :Copilot setup
   ```

3. Sigue las instrucciones para autenticarte con GitHub

## 🤖 Ghost Text (Autocompletado Inline)

El **ghost text** son las sugerencias que aparecen en gris mientras escribes código:

### Cómo funciona:
1. **Escribe código** - Las sugerencias aparecen automáticamente en texto gris
2. **Acepta con Tab** - O usa `Ctrl+J` para aceptar
3. **Navega sugerencias** - `Ctrl+L/K` para ver diferentes opciones
4. **Acepta parcialmente** - `Alt+W` para palabra, `Alt+E` para línea

### Teclas para Ghost Text:
- **Ctrl+J**: ✅ Aceptar sugerencia completa
- **Ctrl+L**: ➡️ Siguiente sugerencia
- **Ctrl+K**: ⬅️ Sugerencia anterior
- **Ctrl+H**: ❌ Descartar sugerencia
- **Alt+W**: 📝 Aceptar solo la palabra
- **Alt+E**: 📄 Aceptar solo la línea

## 🤖 Agentes de IA (CopilotChat)

Los **agentes** son asistentes especializados que pueden realizar tareas complejas:

### Cómo usar los agentes:

#### 1. **Chat básico**:
```vim
:CopilotChat
```
Luego escribe tu pregunta o instrucción.

#### 2. **Seleccionar agente específico**:
```vim
:CopilotChatAgents
```
Elige entre diferentes agentes especializados.

#### 3. **Usar contexto**:
En el chat, puedes usar:
- `#buffer` - Incluir buffer actual
- `#files` - Incluir archivos del proyecto
- `#git:staged` - Incluir cambios de git
- `@copilot` - Usar agente específico
- `$gpt-4o` - Usar modelo específico

#### 4. **Ejemplos de uso con agentes**:

**Análisis de código**:
```
@copilot Analiza este código y sugiere mejoras
#buffer
```

**Generar tests**:
```
@copilot Genera tests unitarios completos para esta función
#buffer
```

**Refactoring**:
```
@copilot Refactoriza este código aplicando principios SOLID
#buffer
```

**Debugging**:
```
@copilot Ayúdame a encontrar el bug en este código
#buffer
```

### Funcionalidades incluidas

#### Autocompletado básico
- **Ctrl+J**: Aceptar sugerencia de Copilot
- **Ctrl+L**: Siguiente sugerencia
- **Ctrl+K**: Sugerencia anterior  
- **Ctrl+H**: Descartar sugerencia

#### Autocompletado alternativo (Alt + tecla)
- **Alt+L**: Aceptar sugerencia
- **Alt+J**: Siguiente sugerencia
- **Alt+K**: Sugerencia anterior
- **Alt+H**: Descartar sugerencia
- **Alt+W**: Aceptar palabra
- **Alt+E**: Aceptar línea
- **Alt+S**: Activar sugerencia

#### Copilot Chat y Agentes
- **\<leader\>cc**: Abrir chat de Copilot
- **\<leader\>ca**: Seleccionar agente
- **\<leader\>cm**: Seleccionar modelo
- **\<leader\>cp**: Seleccionar prompt
- **\<leader\>cx**: Explicar código seleccionado
- **\<leader\>ct**: Generar tests
- **\<leader\>cr**: Revisar código
- **\<leader\>cR**: Refactorizar código
- **\<leader\>cn**: Mejorar nombres
- **\<leader\>ci**: Chat inline
- **\<leader\>cq**: Chat rápido
- **\<leader\>cf**: Arreglar diagnósticos
- **\<leader\>cl**: Limpiar historial de chat

#### Agentes especializados
- **\<leader\>cag**: Agente de código general
- **\<leader\>car**: Agente arquitecto
- **\<leader\>cas**: Agente de seguridad
- **\<leader\>cai**: Instrucción personalizada a agente
- **\<leader\>cap**: Analizar proyecto completo
- **\<leader\>cad**: Generar documentación

#### Comandos de gestión
- **\<leader\>cpp**: Panel de Copilot
- **\<leader\>cps**: Estado de Copilot
- **\<leader\>cpe**: Habilitar Copilot
- **\<leader\>cpd**: Deshabilitar Copilot
- **\<leader\>cpS**: Configurar Copilot
- **\<leader\>cpa**: Autenticar Copilot
- **\<leader\>cpv**: Versión de Copilot

## 📝 Prompts y Contextos Avanzados

### Prompts predefinidos mejorados

El sistema incluye varios prompts predefinidos para tareas comunes:

- **Explain**: Explicar código seleccionado
- **Review**: Revisar código
- **Fix**: Arreglar problemas en el código
- **Optimize**: Optimizar código
- **Docs**: Generar documentación
- **Tests**: Generar tests
- **Commit**: Generar mensajes de commit
- **FixDiagnostic**: Arreglar problemas de diagnóstico
- **Refactor**: Refactorizar con principios SOLID
- **Architecture**: Análisis arquitectónico
- **Security**: Revisión de seguridad
- **Performance**: Análisis de rendimiento
- **Debug**: Ayuda con debugging
- **Implement**: Implementar funcionalidad

### Contextos disponibles

Puedes incluir diferentes tipos de contexto en tus consultas:

- `#buffer` - Buffer actual
- `#buffers` - Todos los buffers
- `#file:path/to/file` - Archivo específico
- `#files:*.js` - Archivos con patrón
- `#git:staged` - Cambios staged en git
- `#git:unstaged` - Cambios no staged
- `#url:https://example.com` - Contenido de URL
- `#system:ls -la` - Salida de comando

## 🎯 Ejemplos de uso avanzado

### 1. Análisis completo de proyecto:
```vim
:CopilotChat
```
Luego escribe:
```
@copilot Analiza la arquitectura de este proyecto y sugiere mejoras
#files:*.js,*.ts
#git:staged
```

### 2. Generar tests con contexto:
```vim
:CopilotChat
```
```
@copilot Genera tests unitarios completos incluyendo casos edge
#buffer
#files:*test*
```

### 3. Revisión de seguridad:
```vim
:CopilotChat
```
```
@copilot Revisa este código en busca de vulnerabilidades de seguridad
#buffer
#files:*.js
```

### 4. Debugging asistido:
```vim
:CopilotChat
```
```
@copilot Ayúdame a debuggear este error, analiza el stack trace
#buffer
#system:npm test
```

### Integración con nvim-cmp

Copilot está integrado con el sistema de autocompletado nvim-cmp, proporcionando:
- Sugerencias de Copilot en el menú de autocompletado
- Prioridad alta para las sugerencias de IA
- Integración fluida con otras fuentes de autocompletado

### Configuración de archivos

Copilot está configurado para:
- ✅ Habilitado en la mayoría de tipos de archivo
- ❌ Deshabilitado en archivos de commit de git
- ❌ Deshabilitado en archivos .env (por seguridad)
- ✅ Integrado con el workspace actual

### Indicador de estado

El estado de Copilot se muestra en la barra de estado (lualine):
- 🟢: Copilot activo y funcionando
- 🟡: Copilot procesando
- 🔴: Copilot con problemas

## 🏗️ **Nuevas funcionalidades para Arch Linux + Hyprland**

### **Integración con el sistema:**
- **Clipboard Wayland**: Soporte nativo para portapapeles en Wayland
- **Notificaciones del sistema**: Integración con el daemon de notificaciones de Hyprland
- **Gestión de ventanas**: Controles para ventanas flotantes y pantalla completa
- **Información del sistema**: Monitor de memoria, CPU, disco y uptime

### **Herramientas de Arch Linux:**
- **Pacman**: `<leader>tp` - Actualizar sistema con pacman
- **AUR**: `<leader>ta` - Actualizar paquetes AUR (yay/paru)
- **Monitor del sistema**: `<leader>th` - Abrir htop
- **Información del sistema**: `<leader>si` - Mostrar estadísticas

### **Gestión de archivos mejorada:**
- **Oil.nvim**: Explorador de archivos más rápido (`<leader>e`)
- **Telescope optimizado**: Búsqueda con fd y ripgrep
- **Mejor rendimiento**: Optimizaciones específicas para Arch

### **Desarrollo avanzado:**
- **Debugging completo**: DAP con UI visual
- **Testing framework**: Neotest para múltiples lenguajes
- **Git avanzado**: Diffview para comparaciones visuales
- **Documentación**: Neogen para generar docs automáticamente

### **Lenguajes adicionales:**
- **Rust**: Rustaceanvim + Crates.nvim
- **Go**: Go.nvim con debugging
- **Mejor soporte**: Para todos los lenguajes populares

### **UI mejorada:**
- **Scrolling suave**: Neoscroll para mejor navegación
- **Folding avanzado**: UFO para mejor manejo de código
- **Color picker**: CCC para trabajar con colores
- **Quickfix mejorado**: BQF para mejor experiencia

### **Rendimiento optimizado:**
- **Startup más rápido**: Impatient.nvim
- **Gestión de memoria**: Garbage collection automático
- **Profiling**: Herramientas para medir rendimiento
- **Configuraciones específicas**: Para hardware de Arch Linux

## 🎯 **Comandos específicos para Arch Linux:**

```bash
# Información del sistema
<leader>si

# Gestión de paquetes
<leader>tp  # Actualizar con pacman
<leader>ta  # Actualizar AUR

# Hyprland
<leader>wf  # Toggle ventana flotante
<leader>wF  # Toggle pantalla completa

# Sistema
<leader>sc  # Enviar notificación del sistema
```

## 📦 **Dependencias recomendadas para Arch Linux:**

```bash
# Herramientas básicas
sudo pacman -S ripgrep fd bat git curl

# Desarrollo
sudo pacman -S nodejs npm python python-pip go rust

# AUR helper (elige uno)
yay -S yay-bin  # o paru-bin

# Herramientas opcionales
sudo pacman -S htop neofetch tree
```

## Instalación

1. Clona esta configuración en tu directorio de Neovim:
   ```bash
   git clone <este-repo> ~/.config/nvim
   ```

2. Inicia Neovim y deja que Lazy instale los plugins:
   ```bash
   nvim
   ```

3. Configura Copilot:
   ```vim
   :Copilot setup
   ```

## 🚀 Flujo de trabajo recomendado

### Para desarrollo diario:
1. **Usa ghost text** mientras escribes código
2. **Selecciona código** y usa `<leader>cx` para explicaciones
3. **Abre chat** con `<leader>cc` para preguntas complejas
4. **Usa contexto** con `#buffer` o `#files` para análisis completo

### Para revisiones de código:
1. **Selecciona función/clase** y usa `<leader>ccr` para revisión
2. **Usa agente de seguridad** con `<leader>cas` para análisis de seguridad
3. **Genera tests** con `<leader>cct`

### Para debugging:
1. **Selecciona código problemático** y usa `<leader>ccb`
2. **Incluye contexto** con `#system:error_log`
3. **Usa agente especializado** para análisis profundo

## Requisitos

- Neovim >= 0.9.0
- Arch Linux (recomendado)
- Hyprland (para integración completa)
- Node.js >= 16.0.0
- Git
- Cuenta de GitHub con acceso a Copilot
- Ripgrep (para búsquedas)
- Un terminal con soporte para colores verdaderos
- curl >= 8.0.0 (recomendado)
- fd (para búsqueda de archivos más rápida)

## Estructura de archivos

```
~/.config/nvim/
├── init.lua                 # Punto de entrada
├── lua/
│   ├── config/             # Configuración base
│   │   ├── autocmds.lua    # Autocomandos
│   │   ├── keymaps.lua     # Mapeos de teclas
│   │   ├── lazy.lua        # Configuración de Lazy
│   │   └── options.lua     # Opciones de Neovim
│   └── plugins/            # Plugins
│       ├── coding.lua      # Plugins de codificación
│       ├── colorscheme.lua # Tema de colores
│       ├── copilot.lua     # GitHub Copilot (COMPLETO)
│       ├── system-integration.lua # Integración con Arch/Hyprland
│       ├── performance.lua # Optimizaciones de rendimiento
│       ├── development.lua # Herramientas de desarrollo
│       ├── ui-enhancements.lua # Mejoras de UI
│       ├── lang-rust.lua   # Soporte para Rust
│       ├── lang-go.lua     # Soporte para Go
│       ├── editor.lua      # Plugins del editor
│       ├── extras.lua      # Plugins adicionales
│       ├── lang-*.lua      # Soporte para lenguajes
│       ├── lsp.lua         # Configuración LSP
│       ├── terminal.lua    # Terminal integrado
│       ├── treesitter.lua  # Syntax highlighting
│       └── ui.lua          # Interfaz de usuario
└── README.md               # Este archivo
```

## 🚀 **Optimizaciones específicas para Arch Linux:**

- **Clipboard Wayland**: Funciona perfectamente con Hyprland
- **Notificaciones nativas**: Integración con notify-send
- **Gestión de memoria**: Optimizada para sistemas Arch
- **Paths del sistema**: Configurados para estructura de Arch
- **Herramientas del sistema**: Integración con pacman y AUR

## Personalización

Puedes personalizar la configuración editando los archivos en `lua/config/` y `lua/plugins/`. 

Para modificar la configuración de Copilot y agentes, edita `lua/plugins/copilot.lua`.

Para ajustar la integración con Hyprland, edita `lua/plugins/system-integration.lua`.

## Solución de problemas

### Copilot no funciona
1. Verifica que tengas una suscripción activa de GitHub Copilot
2. Ejecuta `:Copilot status` para ver el estado
3. Si es necesario, ejecuta `:Copilot setup` nuevamente

### Problemas con Wayland/Hyprland
1. Verifica que tengas las variables de entorno correctas
2. Asegúrate de que `wl-clipboard` esté instalado
3. Comprueba que Hyprland esté ejecutándose correctamente

### Rendimiento lento
1. Ejecuta `:StartupTime` para ver qué plugins tardan más
2. Considera deshabilitar plugins que no uses
3. Verifica que tengas suficiente RAM disponible

### Problemas de autenticación
1. Ejecuta `:Copilot auth` para reautenticarte
2. Verifica que tu token de GitHub tenga los permisos necesarios

### Ghost text no aparece
1. Verifica que Copilot esté habilitado: `:Copilot enable`
2. Comprueba que el tipo de archivo esté soportado
3. Verifica que `vim.g.copilot_no_tab_map = true` esté configurado
4. Reinicia Neovim si es necesario

### Chat no responde
1. Verifica tu conexión a internet
2. Ejecuta `:CopilotChatModels` para verificar modelos disponibles
3. Prueba con un modelo diferente usando `$model_name` en el chat

### Agentes no funcionan
1. Ejecuta `:CopilotChatAgents` para ver agentes disponibles
2. Usa `@agent_name` en el chat para especificar el agente
3. Verifica que tengas acceso a los modelos avanzados

## Contribuir

Si encuentras problemas o tienes sugerencias de mejora, por favor abre un issue o envía un pull request.

## 🎉 **¡Tu Neovim ahora está completamente optimizado!**

Esta configuración te proporciona:
- ✅ **Integración completa** con Arch Linux + Hyprland
- ✅ **GitHub Copilot avanzado** con agentes de IA
- ✅ **Herramientas de desarrollo** profesionales
- ✅ **Rendimiento optimizado** para tu sistema
- ✅ **UI moderna** y funcional
- ✅ **Soporte completo** para múltiples lenguajes

¡Disfruta de tu experiencia de desarrollo mejorada! 🚀