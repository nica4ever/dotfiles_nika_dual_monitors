"Basic defaults
    set nocompatible
    syntax on
    filetype plugin indent on

" Display
    set number
    set ruler
    set showcmd
    set wildmenu

" Search
    set incsearch
    set hlsearch

" Indentation
    set autoindent
    set tabstop=4
    set shiftwidth=4
    set expandtab

" Auto completion
    set wildmenu
    set wildmode=list:longest
    set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

" Behavior
    set backspace=indent,eol,start
    set encoding=utf-8

" Netrw
    set hidden

" Plug
    call plug#begin()

" List your plugins here
    Plug 'ghifarit53/tokyonight-vim'
    call plug#end()

" Transparency and theme
    if !has('gui_running') && &term =~ '^\%(screen\|tmux\)'
      
      let &t_8f = "[38;2;%lu;%lu;%lum"
      let &t_8b = "[48;2;%lu;%lu;%lum"
    
    endif
    set termguicolors
    hi! Normal ctermbg=NONE guibg=NONE
    hi! Normal ctermbg=NONE guibg=NONE
    let g:tokyonight_style = 'night' " available: night, storm
    let g:tokyonight_enable_italic = 1
    let g:tokyonight_transparent_background = 1
    colorscheme tokyonight

" Highlight comments
    highlight Comment guifg=#ADADB1

" Change collor of some elements
    highlight SpecialKey guifg=#ADADB1
    highlight EndOfBuffer guifg=#ADADB1
    highlight LineNr guifg=#ADADB1
    highlight Visual guifg=#444b6a guibg=#acb0d0
    highlight Folded guifg=#ADADB1 guibg=NONE

" Netrw colors
    highlight netrwDir guifg=#7aa2f7
    highlight netrwExe guifg=#9ece6a
    highlight netrwSymLink guifg=#0db9d7
    highlight netrwClassify guifg=#7aa2f7
    highlight netrwPlain guifg=#a9b1d6
    highlight netrwComment guifg=#ADADB1

" Cursor line for netrw selection
    set cursorline
    highlight CursorLine guibg=NONE gui=underline ctermbg=NONE cterm=underline
    highlight CursorLineNr guibg=NONE gui=underline ctermbg=NONE cterm=underline guifg=#7aa2f7

" PLUGINS ---------------------------------------------------------------- {{{

" Plugin code goes here.

" }}}



" MAPPINGS --------------------------------------------------------------- {{{

" Mappings code goes here.

" }}}


" VIMSCRIPT -------------------------------------------------------------- {{{

" This will enable code folding.
" Use the marker method of folding.
    augroup filetype_vim
        autocmd!
        autocmd FileType vim setlocal foldmethod=marker
    augroup END

" More Vimscripts code goes here.

" }}}


" ST    ATUS LINE ------------------------------------------------------------ {{{

" Status bar code goes here.

" }}}
