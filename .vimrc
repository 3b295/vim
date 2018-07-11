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


" 保存时， 检查代码的语法
Plugin 'scrooloose/syntastic'


""""""""""""""""""""""""""" end


Plugin 'vim-airline/vim-airline'
"""""""""""""""""""""""""""""""
let g:airline#extensions#tabline#enabled = 1 " 标签栏
let g:airline_powerline_fonts = 1
set laststatus=2 " 创建拆分之前也显示状态行
"""""""""""""""""""""""""""""""


Plugin 'skywind3000/asyncrun.vim'
""""""""""""""""""""""""""""""
" Use F9 to toggle quickfix window rapidly
:noremap <F9> :call asyncrun#quickfix_toggle(8)<cr>
" automate opening quickfix window when AsyncRun starts
augroup vimrc
    autocmd User AsyncRunStart call asyncrun#quickfix_toggle(8, 1)
augroup END
"""""""""""""""""""""""""" end


Plugin 'majutsushi/tagbar'
nmap <F8> :TagbarToggle<CR>
" 启动时自动focus
let g:tagbar_autofocus = 1


Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'


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
augroup a_key_to_run_python
	autocmd!
	autocmd BufNewFile,BufRead *.py :nnoremap <leader>i :!ipython -i %<CR> 
	autocmd BufNewFile,BufRead *.py :nnoremap <F5> :AsyncRun -raw /usr/bin/env python %<CR>
	autocmd BufNewFile,BufRead *.py :nnoremap <leader>t :AsyncRun -raw /usr/bin/env python -m doctest -v %<CR>
augroup END


:autocmd BufNewFile,BufRead *.c
			\ :nnoremap <leader>r :!gcc % && ./a.out<CR>

" Ruby 
:autocmd BufNewFile,BufRead *.rb
			\ set tabstop=2 |
			\ set softtabstop=2 |
			\ set shiftwidth=2 |
			\ set expandtab |
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

:autocmd BufNewFile,BufRead *.yml
			\ :set tabstop=4 |
			\ :set expandtab |
			\ :set shiftwidth=4 |
			\ :set shiftwidth=4


" add Header
function! HeaderPython()
    call setline(1, "#!/usr/bin/env python")
    call append(1, "# -*- coding: utf-8 -*-")
    call append(2, "# Pw @ " . strftime('%Y-%m-%d %T', localtime()))
    normal G
    normal o
    normal o
endf

:autocmd BufNewFile *.py call HeaderPython()


:syn on "语法高亮
:set number
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
