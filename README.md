# vim
 Synchronize vim config


~~~
git clone git@github.com:3b295/vim.git
ln -s vim/.vimrc .vimrc
~~~  

## 安装 vim-plug 插件
~~~
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
~~~

## 安装 badwolf 颜色主题
```
curl -fLo ~/.vim/colors/badwolf.vim --create-dirs http://bitbucket.org/sjl/badwolf/raw/tip/colors/badwolf.vim
```

## 安装插件
~~~
:PlugInstall
~~~
