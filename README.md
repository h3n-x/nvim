# Configuración de Neovim con GitHub Copilot

Esta es una configuración completa de Neovim basada en LazyVim con integración completa de GitHub Copilot.

## Características principales

- **LazyVim**: Configuración base moderna y eficiente
- **GitHub Copilot**: Autocompletado con IA integrado
- **Copilot Chat**: Interfaz de chat para interactuar con IA
- **Soporte completo para múltiples lenguajes**: Python, JavaScript, TypeScript, Lua, etc.
- **Tema personalizado**: Catppuccin con colores personalizados

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

#### Copilot Chat
- **\<leader\>cc**: Abrir chat de Copilot
- **\<leader\>cx**: Explicar código seleccionado
- **\<leader\>ct**: Generar tests
- **\<leader\>cr**: Revisar código
- **\<leader\>cR**: Refactorizar código
- **\<leader\>cn**: Mejorar nombres
- **\<leader\>ci**: Chat inline
- **\<leader\>cq**: Chat rápido
- **\<leader\>cf**: Arreglar diagnósticos
- **\<leader\>cl**: Limpiar historial de chat

#### Comandos de gestión
- **\<leader\>cp**: Panel de Copilot
- **\<leader\>cs**: Estado de Copilot
- **\<leader\>ce**: Habilitar Copilot
- **\<leader\>cd**: Deshabilitar Copilot
- **\<leader\>cS**: Configurar Copilot
- **\<leader\>ca**: Autenticar Copilot
- **\<leader\>cv**: Versión de Copilot

### Prompts predefinidos

El sistema incluye varios prompts predefinidos para tareas comunes:

- **Explain**: Explicar código seleccionado
- **Review**: Revisar código
- **Fix**: Arreglar problemas en el código
- **Optimize**: Optimizar código
- **Docs**: Generar documentación
- **Tests**: Generar tests
- **Commit**: Generar mensajes de commit
- **FixDiagnostic**: Arreglar problemas de diagnóstico

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

El estado de Copilot se muestra en la barra de estado (lualine) con iconos:
- 🟢 ` `: Copilot activo y funcionando
- 🟡 ` `: Copilot procesando
- 🔴 ` `: Copilot con problemas

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

## Requisitos

- Neovim >= 0.9.0
- Node.js >= 16.0.0
- Git
- Cuenta de GitHub con acceso a Copilot
- Ripgrep (para búsquedas)
- Un terminal con soporte para colores verdaderos

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
│       ├── copilot.lua     # GitHub Copilot (NUEVO)
│       ├── editor.lua      # Plugins del editor
│       ├── extras.lua      # Plugins adicionales
│       ├── lang-*.lua      # Soporte para lenguajes
│       ├── lsp.lua         # Configuración LSP
│       ├── terminal.lua    # Terminal integrado
│       ├── treesitter.lua  # Syntax highlighting
│       └── ui.lua          # Interfaz de usuario
└── README.md               # Este archivo
```

## Personalización

Puedes personalizar la configuración editando los archivos en `lua/config/` y `lua/plugins/`. 

Para modificar la configuración de Copilot, edita `lua/plugins/copilot.lua`.

## Solución de problemas

### Copilot no funciona
1. Verifica que tengas una suscripción activa de GitHub Copilot
2. Ejecuta `:Copilot status` para ver el estado
3. Si es necesario, ejecuta `:Copilot setup` nuevamente

### Problemas de autenticación
1. Ejecuta `:Copilot auth` para reautenticarte
2. Verifica que tu token de GitHub tenga los permisos necesarios

### Sugerencias no aparecen
1. Verifica que Copilot esté habilitado: `:Copilot enable`
2. Comprueba que el tipo de archivo esté soportado
3. Reinicia Neovim si es necesario

## Contribuir

Si encuentras problemas o tienes sugerencias de mejora, por favor abre un issue o envía un pull request.