set nocompatible              " 去除VI一致性,必须
filetype off                  " 必须

" 设置包括vundle和初始化相关的runtime path
set rtp+=~/.vim/bundle/vundle
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

" 保存时， 检查代码的语法
Plugin 'scrooloose/syntastic'

" 补全插件
" Plugin 'Valloric/YouCompleteMe'
 
Plugin 'vim-airline/vim-airline'
"""""""""""""""""""""""""""""""
let g:airline#extensions#tabline#enabled = 1 " 标签栏
let g:airline_powerline_fonts = 1
set laststatus=2 " 创建拆分之前也显示状态行
"""""""""""""""""""""""""""""""





call vundle#end()            " 必须
filetype plugin indent on    " 必须 加载vim自带和插件相应的语法和文件类型相关脚本B 

"""""""""""""""""""""""""""""""""""""""
"
"my code
"
"""""""""""""""""""""""""""""""""""""""


:let mapleader=","

:nnoremap <leader>ev :vsplit $MYVIMRC<CR>
:nnoremap <leader>sv :source $MYVIMRC<CR>


" python PEP8 
:autocmd BufNewFile,BufRead *.py
			\ set tabstop=4 |
			\ set softtabstop=4 |
			\ set shiftwidth=4 |
			\ set textwidth=79 |
			\ set expandtab |
			\ set autoindent |
			\ set fileformat=unix |

" 一键运行
:autocmd BufNewFile,BufRead *.py
			\ :nnoremap <leader>i :!ipython -i %<CR>|
            \ :nnoremap <leader>r :!python %<CR>|
			\ :nnoremap <leader>t :!python -m doctest -v %<CR>



:autocmd BufNewFile,BufRead *.c
			\ :nnoremap <leader>r :!gcc % && ./a.out<CR>

" Ruby 
:autocmd BufNewFile,BufRead *.rb
			\ set tabstop=2 |
			\ set softtabstop=2 |
			\ set shiftwidth=2 |
			\ set autoindent |
			\ set ai! | 

:autocmd BufNewFile,BufRead *.scm
			\ :nnoremap <leader>r :!racket %<CR>


:autocmd BufNewFile,BufRead *.rb
			\ :nnoremap <leader>r :!ruby %<CR>

:autocmd BufNewFile,BufRead *.sh
			\ set tabstop=2 |
			\ set softtabstop=2 |
			\ set shiftwidth=2 |
			\ set autoindent |


:syn on "语法高亮
:set number
:set relativenumber 	" 相对行号
:set scrolloff=5 	" 显示顶部和底部5行
:set mouse=a        	" 启用鼠标
" :set incsearch hlsearch " hlsearch让Vim高亮文件中所有匹配项
			" incsearch则令Vim在你正打着搜索内容时就高亮下一个匹配项
:set nuw=1 		" 去掉行前的空格

:highlight Comment ctermfg=blue  " 注解颜色
:highlight LineNr ctermfg=darkred

" 在插入模式下<BS>有几种工作方式，默认是设置成vi兼容，这样就会出现无法删除此次插入前文字的情况。
:set backspace=indent,eol,start

" 缓存区快捷键
:nnoremap [b :bp<CR>
:nnoremap ]b :bn<CR>

:nnoremap <leader><Space><Space> :%s/\s\+$//<CR>


" Make a simple "search" text object.
" 使用 /something 查找
" 使用 cs 替换第一个，然后按 <Esc> 键
" 使用 n.n.n.n.n. 查找以及替换余下匹配项。 n nest   . replace
vnoremap <silent> s //e<C-r>=&selection=='exclusive'?'+1':''<CR><CR>
    \:<C-u>call histdel('search',-1)<Bar>let @/=histget('search',-1)<CR>gv
omap s :normal vs<CR>


" 按 <Enter> 跳到行文件末尾。
" 按 <Backspace> 回到文件开始。 
nnoremap <CR> G
nnoremap <BS> gg
