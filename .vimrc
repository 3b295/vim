" 配置 快捷键 {{{
let mapleader=","

nnoremap <leader>ev :vsplit $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
nnoremap <leader>ez :vsplit ~/.zshrc<CR>


" }}}
" Colors {{{
colorscheme badwolf     " 颜色主题 https://github.com/sjl/badwolf/
syntax enable           " enable syntax processing


" }}}
" Spaces & Tabs {{{
set tabstop=4           " 每个 TAB 的可视空间
set expandtab           " tabs 是空格
set softtabstop=4       " 插入 <TAB> 的空格数以及删除的空格数
set shiftwidth=4        " 左右缩进的空格数


" }}}
" UI 配置 {{{
set number              " 行号
set cursorline          " 光标在所在行上水平突出显示(或者下划线)
filetype indent on      " 按照 indent 目录下的脚本缩进
set wildmenu            " 命令栏使用<TAB>补全时, 出现一个可视化选项栏
set showmatch           " 突出显示相匹配的 { [ ( < > ) ] } etc.
set scrolloff=5         " 显示顶部和底部5行
set mouse=a             " 启用鼠标


" }}}
" search {{{
set incsearch           " 输入查找内容的同时, vim 就开始对输入内容进行匹配
set hlsearch            " 对所有搜索高亮
" 关闭搜索高亮
nnoremap <leader><space> :nohlsearch<CR>    

" }}}
" 折行(fold) {{{
set foldenable          " 开启折行
set foldmethod=indent   " 基于缩进的折行
set foldlevelstart=10   " 打开新的缓冲区时, 默认显示的折叠级别
" 打开/关闭折叠
nnoremap <space> za


" }}}
" 移动 {{{
" 高亮并且选中最近插入
nnoremap gV `[v`]       
" }}}
" 备份(backups) {{{
set writebackup         " 保证写入时存在一份原始备份文件(myfile.txt~)
set backup              " 备份的文件保留, 在下一次写入时覆盖
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp     " 控制备份文件(myfile.txt~)的位置, 包含编辑之前的版本
set backupskip=/tmp/*,/private/tmp/*                    " 不对这些目录备份
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp     " 控制交换文件(.myfile.txt.swp)的位置, 包含未保存的更改 
set undodir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp       " 控制撤销文件(.myfile.un~)的位置, 包含以往编辑文件的撤销树


" }}}
" AutoGroups {{{

augroup configgroup
    autocmd!
    autocmd BufWritePre *.php,*.py,*.js,*.txt,*.java,*.md 
                \:call <SID>StripTrailingWhitespaces()
augroup END


" }}}
" 通用函数{{{

" 删除尾行空格
function! <SID>StripTrailingWhitespaces()
    let _s=@/
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    let @/=_s
    call cursor(l, c)
endfunction
" }}}
" 启动配置 {{{
set modelines=1     " 在文件的前1行和最后1行寻找 modeline, 默认5

" }}}
" vim-plug {{{
call plug#begin('~/.vim/plugged')
" deoplete.nvim {{{
" asynchronous completion framework for vim8/neovim 
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1

" 补全源 {{{
" https://github.com/Shougo/deoplete.nvim/wiki/Completion-Sources 官方推荐各个语言
 
" python 推荐补全方案 jedi
" 依赖 pip 安装 jedi neovim pynvim
Plug 'zchee/deoplete-jedi'
" 虚拟环境
let g:python3_host_prog = "/Users/xwystz/.pyenv/shims/python"
" }}}
" }}}

call plug#end() 
" }}}
" vim:foldmethod=marker:foldlevel=0
