set nocompatible              " 去除VI一致性,必须
filetype off                  " 必须

" 设置包括vundle和初始化相关的runtime path
set rtp+=~/.vim/bundle/Vundle.vim
let path='~/.vim/bundle'
call vundle#begin(path)

" 让vundle管理插件版本,必须
Plugin 'VundleVim/Vundle.vim'

Plugin 'ctrlpvim/ctrlp.vim'
"""""""""""""""""""""""""" 
let g:ctrlp_map = '<leader>p'
let g:ctrlp_cmd = 'CtrlP'
map <leader>f :CtrlPMRU<CR>
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn|rvm)$',
    \ 'file': '\v\.(exe|so|dll|zip|tar|tar.gz|pyc)$',
    \ }
let g:ctrlp_working_path_mode=0
let g:ctrlp_match_window_bottom=1
let g:ctrlp_max_height=15
let g:ctrlp_match_window_reversed=0
let g:ctrlp_mruf_max=500
let g:ctrlp_follow_symlinks=1
""""""""""""""""""""""""""" end 




call vundle#end()            " 必须
filetype plugin indent on    " 必须 加载vim自带和插件相应的语法和文件类型相关脚本B 

"""""""""""""""""""""""""""""""""""""""
"
"my code
"
"""""""""""""""""""""""""""""""""""""""
:set shiftwidth=4
:set expandtab
:set tabstop=4
:set autoindent 

:let mapleader=","

:nnoremap <leader>ev :vsplit $MYVIMRC<cr>
:nnoremap <leader>sv :source $MYVIMRC<cr>
:nnoremap <leader>ri :!ipython %<cr>

syn on "语法高亮
set number
set relativenumber "相对行号
set scrolloff=5 " 显示顶部和底部5行
set mouse=a        "启用鼠标
set incsearch " 查询时进行锁定
set nuw=1 " 去掉行前的空格

highlight Comment ctermfg=blue  "注解颜色
highlight LineNr ctermfg=darkred



