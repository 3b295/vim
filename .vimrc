:set shiftwidth=4
:set expandtab
:set tabstop=4
:set autoindent 

:let mapleader=","

:nnoremap <leader>ev :vsplit $MYVIMRC<cr>
:nnoremap <leader>sv :source $MYVIMRC<cr>


syn on "语法高亮

" python PEP8风格缩进
au BufNewFile,BufRead *.py
\ set tabstop=4
\ set softtabstop=4
\ set shiftwidth=4
\ set textwidth=79
\ set expandtab
\ set autoindent
\ set fileformat=unix

" 标记多余的空格
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /\s\+$/ 
set encoding=utf-8

set hlsearch " 高亮搜索选项

