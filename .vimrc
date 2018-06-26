"initial setting--------------------------
if &compatible
    set nocompatible
endif
scriptencoding utf-8
set fileformats=unix,mac,dos

"runtime path-----------------------------
if isdirectory($HOME . '/.vim')
    let $MY_VIMRUNTIME = $HOME.'/.vim'
elseif isdirectory($HOME . '\vimfiles')
    let $MY_VIMRUNTIME = $HOME.'\vimfiles'
elseif isdirectory($VIM.'\vimfiles')
    let $MY_VIMRUNTIME = $VIM.'\vimfiles'
endif

"internal encoding------------------------
"source $MY_VIMRUNTIME/plugin/encode.vim
"scriptencoding utf-8

"release autogroup in MyAutoCmd-----------
augroup MyAutoCmd
    autocmd! *
augroup END

"dein Scripts-----------------------------
let s:dein_dir = expand('$MY_VIMRUNTIME/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if &runtimepath !~# '/dein.vim'
    if !isdirectory(s:dein_repo_dir)
        execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
    endif
    execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" Required:
if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)
    let g:rc_dir = expand('$MY_VIMRUNTIME/rc')
    let s:toml = g:rc_dir . '/dein.toml'
    let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

    call dein#load_toml(s:toml, {'lazy': 0})
    call dein#load_toml(s:lazy_toml, {'lazy': 1})

    " Required:
    call dein#end()
    call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
    call dein#install()
endif

" for security
set secure

"system options----------------------------
" uppercase and lowercase option
set ignorecase
set smartcase
" incremental search
set incsearch
" highlight matched word
set hlsearch
" wrap scan search word
set wrapscan

" rounded indent by '<' or '>'
set shiftround
" uppercase and lowercase option
set infercase
" buffer option
set hidden
set switchbuf=useopen
" highlight brace
set showmatch
set matchtime=3
set matchpairs& matchpairs+=<:>
" tab length
set ts=4 sw=4 sts=4
augroup fileTypeIndent
    autocmd!
    autocmd BufNewFile,BufRead *.rb setlocal ts=2 sw=2 sts=2
    autocmd BufNewFile,BufRead *.ml setlocal ts=2 sw=2 sts=2
    autocmd BufNewFile,BufRead *.mli setlocal ts=2 sw=2 sts=2
    autocmd BufNewFile,BufRead *.mly setlocal ts=2 sw=2 sts=2
    autocmd BufNewFile,BufRead *.mll setlocal ts=2 sw=2 sts=2
    autocmd BufNewFile,BufRead *.html setlocal ts=2 sw=2 sts=2
    autocmd BufNewFile,BufRead *.js setlocal ts=2 sw=2 sts=2
    autocmd BufNewFile,BufRead *.css setlocal ts=2 sw=2 sts=2
augroup END
" indent
set autoindent
set smartindent
set cindent
set cinoptions+=:0
" tab to space
set expandtab
" indent when press tab
set smarttab
" enable to remove anything by backspace
set backspace=indent,eol,start
" enable free cursor in visual block mode
set virtualedit=block  

" link clipboard
if has('unnamedplus')
    set clipboard& clipboard+=unnamedplus, unnamed
else
    set clipboard& clipboard+=unnamed
endif
" enable mouse
if has('mouse')
    set mouse=a
endif
" disable backup
set nobackup
set nowritebackup
" swap file to .vim/tmp
set swapfile
set directory=$MY_VIMRUNTIME/tmp

" show invisible character
set list
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%,eol:↲
" show line number
set number
" highlight cursor line
set cursorline
" wrap long text
set wrap
set textwidth=0
set colorcolumn=80
" enable to use slash by directory path in windows
set shellslash
" show title
set title
" show ruler
set ruler
" set command line height
set cmdheight=2
set laststatus=2
" show command in status line
set showcmd
" show mode
set showmode
" disable screen bell
set t_vb=
set novisualbell

" disable oct
set nrformats-=octal
" milliseconds to wait key
set timeoutlen=3500
" history limit
set history=50
" not insert space when join lines in Japanese
set formatoptions+=mM
" enable to move cursor in head or tail
set whichwrap=b,s,h,l,[,],<,>
" for multibyte
set ambiwidth=double
" support commandline autocomplete
set wildmode=list,full
set wildmenu
" anywhere sid
function! s:SID_PREFIX()
    return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction
" set tabline
function! s:my_tabline()
    let s = ''
    for i in range(1, tabpagenr('$'))
        let bufnrs = tabpagebuflist(i)
        let bufnr = bufnrs[tabpagewinnr(i) - 1] " first window, first appears
        let no = i " display 0-origin tabpagenr.
        let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
        let title = fnamemodify(bufname(bufnr), ':t')
        let title = '[' . title . ']'
        let s .= '%'.i.'T'
        let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
        let s .= no . ':' . title
        let s .= mod
        let s .= '%#TabLineFill# '
    endfor
    let s .= '%#TabLineFill#%T%=%#TabLine#'
    return s
endfunction
let &tabline = '%!' . s:SID_PREFIX() . 'my_tabline()'
" show tabline
set showtabline=2

"key mapping-------------------------------
" load vimrc: press F1
if has('nvim')
    nnoremap <silent> <F1> :<C-u>e ~/.config/nvim/init.vim<CR>
else
    nnoremap <silent> <F1> :<C-u>e ~/.vimrc<CR>
endif
" source vimrc: press F10
if !exists('*s:source_script')
    function s:source_script(path) abort
        let path = expand(a:path)
        if !filereadable(path)
            return
        endif
        execute 'source' fnameescape(path)
        echomsg printf('"%s" has sourced (%s)', simplify(fnamemodify(path, ':~:.')), strftime('%c'),)
    endfunction
endif
nnoremap <silent> <F10> :<C-u>call <SID>source_script('%')<CR>
" tab utility
nnoremap [Tag] <Nop>
nmap t [Tag]
" tab jump: press t + number, jump the tab
for n in range(1, 9)
    execute 'nnoremap <silent> [Tag]'.n ':<C-u>tabnext'.n.'<CR>'
endfor
" new tab: press t + o
map <silent> [Tag]o :tablast <bar> tabnew<CR>
" close tab: press t + x
map <silent> [Tag]x :tabclose<CR>
" next tab: press t + n
map <silent> [Tag]n :tabnext<CR>
" previous tab: press t + p
map <silent> [Tag]p :tabprevious<CR>
" split window horizontal: press s + s
nmap ss :split<Return><C-w>w
" split window virtical: press s + v
nmap sv :vsplit<Return><C-w>w
" move window: press space
nmap <Space> <C-w>w
" move left: press s + left arrow or s + h
map s<left> <C-w>w
map sh <C-w>w
" move up: press s + up arrow or s + k
map s<up> <C-w>w
map sk <C-w>w
" move down: press s + down arrow or s + j
map s<down> <C-w>w
map sj <C-w>w
" move right: press s + right arrow or s + l
map s<right> <C-w>l
map sl <C-w>w
" resize window: press Ctrl-w + arrow keys
nmap <C-w><left> <C-w><
nmap <C-w><right> <C-w>>
nmap <C-w><up> <C-w>+
nmap <C-w><down> <C-w>-
" source opened vimscript: press F8
nnoremap <F8> :source %<CR>
" invalidate ZZ
nnoremap ZZ <Nop>
" move cursor in normal mode
nnoremap <Down> gj
nnoremap <Up> gk
nnoremap h <Left>zv
nnoremap j gj
nnoremap k gk
nnoremap l <Right>zv
" cancel search?: press esc twice
nnoremap <Esc><Esc> :<C-u>set nohlsearch!<CR>
" remove arrow key bug in insert mode
imap OA <UP>
imap OB <Down>
imap OC <Right>
imap OD <Left>
imap [3~ <Delete>
" select all: press Ctrl-A
map <C-A> ggVG
" cut selection: press Ctrl-X
map <C-X> "+x
" copy selection: press Ctrl-C
map <C-C> "+y
" paste some: press Ctrl-V
map <C-V> "+gP
" save file: press Ctrl-S
map <C-S> :w
" escape backslash and question
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'

"plugin options------------------------------
" nerd tree
let g:NERDTreeDirArrows=1
let NERDTreeWinSize=22
let s:git_orange='F45D27'
let g:NERDTreeExactMatchHighlightColor={}
let g:NERDTreeExactMatchHighlightColor['.gitignore']=s:git_orange
let g:webdevicons_conceal_nerdtree_brackets=1
let g:WebDevIconsNerdTreeAfterGlyphPadding=' '
let g:NERDTreeDirArrowExpandable='▶'
let g:NERDTreeDirArrowCollapsible='▼'
nmap sf :NERDTreeToggle<CR>

" devicon
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1
let g:WebDevIconsUnicodeDecorateFolderNodesDefaultSymbol = ''
let g:DevIconsDefaultFolderOpenSymbol = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {}
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['html'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['css'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['md'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['txt'] = ''
set guifont=RictyDiscordForPowerline\ Nerd\ Font:h14

" airline
let g:airline_theme='light'
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#whitespace#mixed_indent_algo = 1
let g:airline#extensions#branch#enabled = 0
let g:airline#extensions#readonly#enabled = 0
let g:airline_section_b =
            \ '%{airline#extensions#branch#get_head()}' .
            \ '%{""!=airline#extensions#branch#get_head()?("  " . g:airline_left_alt_sep . " "):""}' .
            \ '%t%( %M%)'
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.maxlinenr = '☰'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = '∄'
let g:airline_symbols.whitespace = 'Ξ'
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_right_sep = '⮂'
let g:airline_right_alt_sep = '⮃'

" jedi
autocmd FileType python setlocal completeopt-=preview
