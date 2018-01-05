if has('vim_starting')
	set encoding=utf-8
	scriptencoding utf-8
	" 利用可能な場合は true color を有効化する
	if !has('gui_running')
				\ && exists('&termguicolors')
				\ && $COLORTERM ==# 'truecolor'
		" tmux 等でも強制的に termguicolors を有効化するための設定 (Neovim では不要)
		" https://medium.com/@dubistkomisch/how-to-actually-get-italics-and-true-colour-to-work-in-iterm-tmux-vim-9ebe55ebc2be
		if !has('nvim')
			let &t_8f = "\e[38;2;%lu;%lu;%lum"
			let &t_8b = "\e[48;2;%lu;%lu;%lum"
		endif
		set termguicolors       " use truecolor in term
	endif
endif

"------------------
"ここに追記していく
"-------------------

" syntax highlight
" filetype indent and syntax
syntax on
filetype indent plugin on

" for security
set secure

" load vimrc for easy
if has('nvim')
	nnoremap <silent> <F1> :<C-u>e ~/.config/nvim/init.vim<CR>
else
	nnoremap <silent> <F1> :<C-u>e ~/.vimrc<CR>
endif

" source vimrc for easy
if !exists('*s:source_script')
	" ~/.vimrc をソースすると関数実行中に関数の上書きを行うことになりエラーとなるため
	" 'function!' による強制上書きではなく if によるガードを行っている
	function s:source_script(path) abort
		let path = expand(a:path)
		if !filereadable(path)
			return
		endif
		execute 'source' fnameescape(path)
		echomsg printf(
					\ '"%s" has sourced (%s)',
					\ simplify(fnamemodify(path, ':~:.')),
					\ strftime('%c'),
					\)
	endfunction
endif
nnoremap <silent> <F10> :<C-u>call <SID>source_script('%')<CR>

" システムのクリップボードを利用する
" OS 種により利用するべき値が違うため分岐させている
" - unnamed     : 'selection' in X11; clipboard in Mac OS X and Windows
" - unnamedplus : 'clipboard' in X11, Mac OS X, and Windows (but yank)
if has('win32') || has('win64') || has('mac')
  set clipboard=unnamed
else
  set clipboard=unnamed,unnamedplus
endif

noremap <Leader>      <Nop>
noremap <LocalLeader> <Nop>
let g:mapleader = "\<Space>"
let g:maplocalleader = '\'


