:# 🚀 uffnvim

 
Una configuración moderna y modular de Neovim optimizada para desarrollo en **Go**, **Rust**, **JavaScript/TypeScript** y más.

## ✨ Características

- 🔥 **Lazy loading** de plugins para inicio ultra rápido
- 🦀 Soporte completo para **Rust** con rustaceanvim
- 🐹 Desarrollo en **Go** con gopls y herramientas avanzadas
- 😊 **Emoji picker** integrado con Telescope
- 🔍 **Búsqueda fuzzy** potente con Telescope + ripgrep
- 🎨 **Syntax highlighting** avanzado con Treesitter
- 💡 **LSP** configurado para múltiples lenguajes
- 📦 **Mason** para gestión automática de LSPs y herramientas
- 🏗️ **Configuración modular** y fácil de extender

## 📋 Requisitos Previos

### Esenciales
- **Neovim** >= 0.9.0
- **Git**
- **Node.js** >= 16.0
- **npm** o **yarn**

### Herramientas de línea de comandos
- **ripgrep** (para búsquedas rápidas)
- **fd** (para búsqueda de archivos)

### Compiladores/Runtime (opcionales según lenguaje)
- **Go** >= 1.20 (para desarrollo Go)
- **Rust** + **Cargo** (para desarrollo Rust)
- **Python** >= 3.8 (para algunos LSPs)

## 🛠️ Instalación

### 1. **Requisitos previos**

#### Windows
- Scoop (Gestor de paquetes para windows)
```powershell

Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
```
- Paquetes necesarios
```powershell
scoop bucket add main
scoop bucket add versions
scoop bucket add nerd-fonts
scoop install yarn lua-language-server neovim nodejs-lts python cmake make gcc rustup go JetBrainsMono-NF
```

#### macOS
- Paquetes necesarios
```bash
brew install neovim yarn lua-language-server node@22 python cmake make gcc rustup go
brew tap homebrew/cask-fonts
brew install font-jetbrains-mono-nerd-font
```

#### Linux (Ubuntu/Debian) - Para otras versiones por favor consulte los gestores de instalación
- Esenciales

```bash
sudo apt update && sudo apt upgrade -y
sudo apt install -y build-essencial cmake make gcc git curl unzip
```

- Nodejs [Documentación oficial](https://nodejs.org/es/download)

```bash

# Descarga e instala n y Node.js:
curl -fsSL https://raw.githubusercontent.com/mklement0/n-install/stable/bin/n-install | bash -s 22

# Node.js ya se instala durante n-install, pero también puedes instalarlo manualmente:
#   n install 22

# Verify the Node.js version:
node -v # Should print "v22.19.0".

# Verifica versión de npm:
npm -v # Debería mostrar "10.9.3".

```

- Yarn 
```bash
npm i --global yarn
```

- Golang (Si se requiere)
```bash


```

## Instalación ripgrep fd
#### Windows
```powershell
# Con Scoop
scoop install ripgrep fd

# Con winget
winget install BurntSushi.ripgrep.MSVC
winget install sharkdp.fd
```

#### macOS
```bash
# Con Homebrew
brew install ripgrep fd
```

#### Linux(Ubuntu/Debian)
```bash
# Ubuntu/Debian
sudo apt install ripgrep fd-find -y

```

### 4. **Instalar lenguajes (opcional)**

#### Go
```bash
# Descargar desde: https://golang.org/dl/
# O con package manager:

# Windows (Chocolatey)
choco install golang

# macOS (Homebrew)
brew install go

# Linux (Ubuntu/Debian)
sudo apt install golang-go
```

#### Rust
```bash
# Instalar rustup (recomendado)
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Windows: https://rustup.rs/
```

### 5. **Instalar uffnvim**

#### Hacer backup de configuración existente
```bash
# Linux/macOS
mv ~/.config/nvim ~/.config/nvim.backup

# Windows
move %LOCALAPPDATA%\nvim %LOCALAPPDATA%\nvim.backup
```

#### Clonar uffnvim
```bash
# Linux/macOS
git clone https://github.com/tuusuario/uffnvim.git ~/.config/nvim

# Windows
git clone https://github.com/tuusuario/uffnvim.git %LOCALAPPDATA%\nvim
```

#### Primera ejecución
```bash
nvim
```

**¡Listo!** uffnvim instalará automáticamente todos los plugins y LSPs necesarios.

> **📝 Nota:** Mason (incluido en uffnvim) instalará automáticamente la mayoría de LSPs incluyendo:
> - `lua-language-server`
> - `gopls` (Go LSP)
> - `rust-analyzer` (Rust LSP)
> - `pyright` (Python LSP)
> - `clangd` (C++ LSP)
> - Y muchos más...
>
> No necesitas instalar estos LSPs manualmente, Mason se encarga de todo.

## 📁 Estructura del Proyecto

```
~/.config/nvim/
├── init.lua                 # Punto de entrada principal
├── lua/
│   ├── config/             # Configuraciones básicas
│   │   └── init.lua
│   ├── utils/              # Utilidades y helpers
│   │   └── helpers.lua
│   └── plugins/            # Plugins modulares
│       ├── init.lua        # Cargador principal de plugins
│       ├── rust.lua        # Plugins de Rust
│       ├── go.lua          # Plugins de Go
│       ├── emojis.lua      # Emoji picker
│       ├── telescope.lua   # Configuración de Telescope
│       └── lsp.lua         # Configuración de LSP
```

## ⚡ Primeros Pasos

### Comandos Esenciales

```vim
" Abrir file explorer
:Oil

" Buscar archivos
:Telescope find_files

" Buscar en contenido
:Telescope live_grep

" Picker de emojis
:Telescope emoji

" Gestionar plugins
:Lazy

" Gestionar LSPs y herramientas
:Mason

" Información del sistema
:checkhealth
```

### Atajos de Teclado Principales

| Atajo | Descripción |
|-------|-------------|
| `<leader>ff` | Buscar archivos |
| `<leader>fg` | Buscar en contenido |
| `<leader>em` | Emoji picker |
| `gd` | Ir a definición |
| `gr` | Referencias |
| `K` | Hover documentation |
| `<leader>ca` | Code actions |

## 🔧 Personalización

### Agregar nuevos plugins

Crea un nuevo archivo en `lua/plugins/`, por ejemplo `lua/plugins/miplugin.lua`:

```lua
return {
    {
        'autor/plugin-name',
        config = function()
            -- Tu configuración aquí
        end
    }
}
```

El archivo se cargará automáticamente gracias a la función `merge_plugins()`.

### Configurar nuevos LSPs

```vim
" Abrir Mason
:Mason

" Buscar e instalar tu LSP
" Ejemplo: 'i' para instalar python-lsp-server
```

### Modificar keymaps

Edita `lua/config/keymaps.lua` (o crea el archivo):

```lua
local map = vim.keymap.set

-- Tus atajos personalizados
map('n', '<leader>t', ':terminal<CR>', { desc = 'Abrir terminal' })
```

## 🐛 Troubleshooting

### Plugin no se carga
```vim
:Lazy reload nombre-plugin
:Lazy sync
```

### LSP no funciona
```vim
:LspInfo
:LspRestart
:Mason
```

### Telescope sin resultados
```vim
:checkhealth telescope
```

Verifica que `ripgrep` y `fd` estén instalados.

### Performance lenta
```vim
:Lazy profile
```

## 📝 Soporte

### Recursos útiles
- [Documentación de Neovim](https://neovim.io/doc/)
- [Lazy.nvim](https://github.com/folke/lazy.nvim)
- [Mason.nvim](https://github.com/williamboman/mason.nvim)
- [Telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)

### Reportar problemas
Si encuentras algún bug o tienes sugerencias, abre un issue en el repositorio.

---

**¡Disfruta programando con uffnvim! 🚀**
