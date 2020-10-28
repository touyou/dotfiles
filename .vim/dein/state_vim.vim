if g:dein#_cache_version !=# 100 || g:dein#_init_runtimepath !=# '/Users/touyou/.vim/dein/repos/github.com/Shougo/dein.vim/,/Users/touyou/.vim,/usr/share/vim/vimfiles,/usr/share/vim/vim81,/usr/share/vim/vimfiles/after,/Users/touyou/.vim/after' | throw 'Cache loading error' | endif
let [plugins, ftplugin] = dein#load_cache_raw(['/Users/touyou/.vimrc', '/Users/touyou/.vim/rc/dein.toml', '/Users/touyou/.vim/rc/dein_lazy.toml'])
if empty(plugins) | throw 'Cache loading error' | endif
let g:dein#_plugins = plugins
let g:dein#_ftplugin = ftplugin
let g:dein#_base_path = '/Users/touyou/.vim/dein'
let g:dein#_runtime_path = '/Users/touyou/.vim/dein/.cache/.vimrc/.dein'
let g:dein#_cache_path = '/Users/touyou/.vim/dein/.cache/.vimrc'
let &runtimepath = '/Users/touyou/.vim/dein/repos/github.com/Shougo/dein.vim/,/Users/touyou/.vim,/usr/share/vim/vimfiles,/Users/touyou/.vim/dein/repos/github.com/Shougo/dein.vim,/Users/touyou/.vim/dein/.cache/.vimrc/.dein,/usr/share/vim/vim81,/Users/touyou/.vim/dein/.cache/.vimrc/.dein/after,/usr/share/vim/vimfiles/after,/Users/touyou/.vim/after'
