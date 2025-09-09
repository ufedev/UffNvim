# NVIM IDE Configuración

Documentación en curso.

## Requisitos
- Instalar  JetBrains nerd font [link](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.zip)
- msys64 [Seguir Pasos](https://www.msys2.org/)
- Python [Descarga](https://www.python.org/downloads/)
- Nodejs [Descarga](https://nodejs.org/es/download)
- lua-language-server
  - Windows
    ```ps
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
    Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
    ```
    ```ps
    scoop install lua-language-server
    ```
  - MacOs
  ```zsh
  brew install lua-language-server
  ```
  - Linux (ubuntu)
  ```bash
  sudo apt install lua-language-server

  ```

- Para que funcionen todos los pluggins de tailwindcss hay que tener instalado
    ```sh
        npm  i -g @tailwindcss/language-server
    ```


## Esta configuración toma como <leader> = SPACE



# 📝 Neovim Cheatsheet

## 🔹 Movimiento básico
- `/palabra` → buscar palabra  
- `n` / `N` → siguiente / anterior resultado  
- `:numero` → ir a línea  

## 🔹 Explorador (NvimTree)
- `<leader>e` → abrir/cerrar explorador  
- `a` → nuevo archivo/carpeta  
- `r` → renombrar (cambia extensión también)  
- `d` → borrar archivo  
- `y` → copiar ruta  
- `H` → mostrar/ocultar archivos ocultos  

## 🔹 Buffers / Tabs
- `:bd` → cerrar buffer actual  
- `:tabnew` → nueva tab  
- `gt` / `gT` → siguiente / anterior tab  
- `<leader>c` → cerrar buffer (custom)  

## 🔹 LSP (Lenguajes)
- `gd` → ir a definición  
- `gr` → referencias (quickfix abajo)  
- `<leader>m`-> cerrar referencias
- `K` → hover (ver docstring)  
- `<leader>rn` → renombrar símbolo  
- `<leader>ca` → code action (refactor, fix, etc)  
- `<leader>q` → cerrar quickfix  

## 🔹 Autocompletado (nvim-cmp)
- `<C-n>` → siguiente sugerencia  
- `<C-p>` → sugerencia anterior  
- `<CR>` → aceptar  
- `<C-Space>` → forzar completado  

## 🔹 Folding (plegado de código con Treesitter)
- `zc` → cerrar fold bajo cursor  
- `zo` → abrir fold  
- `za` → toggle  
- `zM` → cerrar todos  
- `zR` → abrir todos  

## 🔹 Markdown
- `<leader>mp` → preview en navegador  
- `<leader>mg` → preview en terminal (Glow)  
- `<leader>tm` → activar Table Mode  
- `<leader>tc` → generar TOC  
- `<leader>tC` → borrar TOC  

## 🔹 Terminal integrada
- <leader>tt -> toggle terminal integrada
- `<C-\><C-n>` → salir de terminal a normal mode  
- `:bd!` → cerrar terminal actual  


## Por defecto viene icons y hay que instalarlos. Compatible con Window / Mac / Linux
**Require NVIM 0.11+**
