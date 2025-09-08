# NVIM IDE Configuración


## Requisitos
- Instalar  JetBrains nerd font [link](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.zip)
- msys64 [Seguir Pasos](https://www.msys2.org/)
- Python [Descarga](https://www.python.org/downloads/)
- Nodejs [Descarga](https://nodejs.org/es/download)
- lua-language-server
  - Windows
    ´´´ps
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
    Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
    ´´´
    ´´´
    scoop install lua-language-server
    ´´´
  - MacOs
  ´´´
  brew install lua-language-server
  ´´´
  - Linux (ubuntu)
  ´´´
  sudo apt install lua-language-server

  ´´´


## Esta configuración toma como <leader- = SPACE


## Comandos básicos

- Toggle terminal  <leader>tt
- Abrir/Cerrar explorador <leader>e
- Moverse al explorador <leader>o
- Moverse entre pestañas <shift>h (izquierda) <shift>l (Derecha)
- Buscar definición gr
- Cerrar el buscador de definiciones <leader>m
- Crear archivo a
- Editar nombre archivo e
- Renombrar archivo (incluye extensión) r
- Eliminar archivo d
- Cerrar pestaña <leader>c
- :qa Cerrar IDE
- :q cerrar file
- :w guardar file
- :Ex  explorador de NVIM



## Por defecto viene icons y hay que instalarlos. Compatible con Window / Mac / Linux
**Require NVIM 0.11+**
