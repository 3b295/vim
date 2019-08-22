" vim:foldmethod=marker:foldlevel=0
" 👻 happy hacking...  


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
set autoindent          " 自动缩进

augroup spaces_group
    autocmd!
    " yaml 缩进
    autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
augroup END

"}}}
" UI 配置 {{{
set number              " 行号
set cursorline          " 光标在所在行上水平突出显示(或者下划线)
filetype indent on      " 按照 indent 目录下的脚本缩进
set wildmenu            " 命令栏使用<TAB>补全时, 出现一个可视化选项栏
set showmatch           " 突出显示相匹配的 { [ ( < > ) ] } etc.
set scrolloff=5         " 显示顶部和底部5行
set mouse=a             " 启用鼠标
set visualbell          " 关闭响铃🔔


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
" 插入模式 {{{

" backspace 不工作被设计为一种功能, 但大多数 linux 发行版都选择禁用了它。
" indent 可以删除缩进
" eol 可以删除 EOL 标记(`\n` `\r\n`)
" start 可以删除上次修改
set backspace=indent,eol,start

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
    " 清除尾行空格
    autocmd BufWritePre *.php,*.py,*.js,*.txt,*.java,*.md,*.lua
                \:call <SID>StripTrailingWhitespaces()
    " 追加 Flex 文件头部
    autocmd BufNewFile *.l :call append(0, "%option noyywrap")
    " 追加 Bash shebang
    autocmd BufNewFile *.sh :call append(0, "#!/usr/bin/env bash")
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
set modelines=5     " 在文件的前x行和最后x行寻找 modeline, 默认5

" }}}
" ➡️  | run {{{
" k8s yaml file {{{
augroup runk8syamlgroup
    autocmd!
    " 依赖 'andrewstuart/vim-kubernetes' 插件
    " 使用当前文件创建对应资源
    autocmd FileType yaml :nnoremap <leader>r :KubeCreate<CR>
    " 使用当前文件删除对应资源
    autocmd FileType yaml :nnoremap <leader>d :KubeDelete<CR>
augroup END
" }}}
" }}}
" 🔧 | vim-plug {{{
call plug#begin('~/.vim/plugged')

" NERDTree 目录树 {{{
Plug 'scrooloose/nerdtree'

" 开关目录树
map <F2> :NERDTreeToggle<CR>   

augroup nerdtreegroup
    autocmd!
    " 只剩目录树时自动关闭
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
augroup END

" }}}
" vim-go {{{
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" go run
autocmd FileType go nmap <leader>r  <Plug>(go-run)
" go test
autocmd FileType go nmap <leader>t  <Plug>(go-test)
" 基于文件类型自动决定是 run :GoBuild or :GoTestCompile
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>


" }}}
" k8s yaml {{{
" 代码块, 执行 kebuctl 命令 
Plug 'andrewstuart/vim-kubernetes'
" }}}
" AsyncRun {{{
Plug 'skywind3000/asyncrun.vim'

" Quickfix 最佳实践
" 文本被添加时, 自动打开quickfix 窗口
augroup vimrc
    autocmd QuickFixCmdPost * botright copen 16
augroup END
" }}}
" vim-yaml {{{
Plug 'stephpy/vim-yaml'
" }}}
" logstash {{{
Plug 'robbles/logstash.vim'
" }}}
" vim-multiple-cursors {{{
Plug 'terryma/vim-multiple-cursors'
" }}}
" Bison & Flex {{{
Plug 'justinmk/vim-syntax-extra'
" }}}


call plug#end() 
" }}}
" AsyncRun {{{
augroup async_group
    autocmd!
    " resty
    autocmd FileType lua noremap <leader>r :AsyncRun resty -I "${HOME}/PycharmProjects/api/lib/" -I "${HOME}/PycharmProjects/api/pdv/api/comm/" % <CR>
    " nginx 保存时自动 reload
    autocmd FileType nginx noremap <leader>r :AsyncRun openresty -s reload<CR>
augroup END

" }}}

