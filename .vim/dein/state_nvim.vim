if g:dein#_cache_version !=# 100 || g:dein#_init_runtimepath !=# '/Users/touyou/.vim/dein/repos/github.com/Shougo/dein.vim/,/Users/touyou/.config/nvim,/etc/xdg/nvim,/Users/touyou/.local/share/nvim/site,/usr/local/share/nvim/site,/usr/share/nvim/site,/usr/local/Cellar/neovim/0.4.3/share/nvim/runtime,/usr/share/nvim/site/after,/usr/local/share/nvim/site/after,/Users/touyou/.local/share/nvim/site/after,/etc/xdg/nvim/after,/Users/touyou/.config/nvim/after' | throw 'Cache loading error' | endif
let [plugins, ftplugin] = dein#load_cache_raw(['/Users/touyou/.config/nvim/init.vim', '/Users/touyou/.vim/rc/dein.toml', '/Users/touyou/.vim/rc/dein_lazy.toml'])
if empty(plugins) | throw 'Cache loading error' | endif
let g:dein#_plugins = plugins
let g:dein#_ftplugin = ftplugin
let g:dein#_base_path = '/Users/touyou/.vim/dein'
let g:dein#_runtime_path = '/Users/touyou/.vim/dein/.cache/init.vim/.dein'
let g:dein#_cache_path = '/Users/touyou/.vim/dein/.cache/init.vim'
let &runtimepath = '/Users/touyou/.vim/dein/repos/github.com/Shougo/dein.vim/,/Users/touyou/.config/nvim,/etc/xdg/nvim,/Users/touyou/.local/share/nvim/site,/usr/local/share/nvim/site,/usr/share/nvim/site,/Users/touyou/.vim/dein/repos/github.com/Shougo/dein.vim,/Users/touyou/.vim/dein/repos/github.com/Shougo/denite.nvim,/Users/touyou/.vim/dein/repos/github.com/Shougo/neomru.vim,/Users/touyou/.vim/dein/.cache/init.vim/.dein,/usr/local/Cellar/neovim/0.4.3/share/nvim/runtime,/Users/touyou/.vim/dein/.cache/init.vim/.dein/after,/usr/share/nvim/site/after,/usr/local/share/nvim/site/after,/Users/touyou/.local/share/nvim/site/after,/etc/xdg/nvim/after,/Users/touyou/.config/nvim/after'
filetype off
