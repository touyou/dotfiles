let [plugins, ftplugin] = dein#load_cache_raw(['/Users/touyou/.vimrc', '/Users/touyou/.vim/rc/dein.toml', '/Users/touyou/.vim/rc/dein_lazy.toml'], 1)
if empty(plugins) | throw 'Cache loading error' | endif
let g:dein#_plugins = plugins
let g:dein#_ftplugin = ftplugin
let g:dein#_base_path = '/Users/touyou/.vim/dein'
let g:dein#_runtime_path = '/Users/touyou/.vim/dein/.dein'
let &runtimepath = '/Users/touyou/.vim/dein/repos/github.com/Shougo/dein.vim/,/Users/touyou/.vim,/Users/touyou/.vim/dein/.dein,/usr/local/share/vim/vimfiles,/usr/local/share/vim/vim80,/usr/local/share/vim/vimfiles/after,/Users/touyou/.vim/after,/Users/touyou/.vim/dein/.dein/after'
silent! command -complete=customlist,dein#autoload#_dummy_complete -bang -bar -range -nargs=* Gist call dein#autoload#_on_cmd('Gist', 'gist-vim', <q-args>,  expand('<bang>'), expand('<line1>'), expand('<line2>'))
silent! command -complete=customlist,dein#autoload#_dummy_complete -bang -bar -range -nargs=* Gitv call dein#autoload#_on_cmd('Gitv', 'gitv', <q-args>,  expand('<bang>'), expand('<line1>'), expand('<line2>'))
silent! nnoremap <unique><silent> nxo :call dein#autoload#_on_map('nxo', 'vim-quickrun','n')<CR>
silent! xnoremap <unique><silent> nxo :call dein#autoload#_on_map('nxo', 'vim-quickrun','x')<CR>
silent! onoremap <unique><silent> nxo :call dein#autoload#_on_map('nxo', 'vim-quickrun','o')<CR>
silent! nnoremap <unique><silent> <Plug>(quickrun) :call dein#autoload#_on_map('<lt>Plug>(quickrun)', 'vim-quickrun','n')<CR>
silent! xnoremap <unique><silent> <Plug>(quickrun) :call dein#autoload#_on_map('<lt>Plug>(quickrun)', 'vim-quickrun','x')<CR>
silent! onoremap <unique><silent> <Plug>(quickrun) :call dein#autoload#_on_map('<lt>Plug>(quickrun)', 'vim-quickrun','o')<CR>
silent! command -complete=customlist,dein#autoload#_dummy_complete -bang -bar -range -nargs=* GundoToggle call dein#autoload#_on_cmd('GundoToggle', 'gundo.vim', <q-args>,  expand('<bang>'), expand('<line1>'), expand('<line2>'))
