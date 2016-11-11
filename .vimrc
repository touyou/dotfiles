"------------------------------------------------------------------------------
" .vimrc edited by touyou
" 趣旨：
"   + Windows/Ubuntu、および将来的にはMacでも共通して使えるようにする
"   + プログラミングに関して快適であるようにする
"   + プラグインは最低限かつ簡易な管理方法を徹底
"   + 検索はあまり使わないのでとりあえず適当な感じに
"   + 補完は今のところ邪魔でしかないのでとりあえずコメントアウト中
" vimに関しては素人なのでなにかあれば指摘お願いします。
"------------------------------------------------------------------------------
set nocompatible
scriptencoding utf-8
set fileformats=unix,mac,dos
"scriptencodingと、このファイルのエンコーディングが一致するよう注意！
"scriptencodingは、vimの内部エンコーディングと同じものを推奨します。
"改行コードは set fileformat=unix に設定するとunixでも使えます。

"----------------------------------------
" ユーザーランタイムパス設定
"----------------------------------------
"Windows, unixでのruntimepathの違いを吸収するためのもの。
"$MY_VIMRUNTIMEはユーザーランタイムディレクトリを示す。
":echo $MY_VIMRUNTIMEで実際のパスを確認できます。
if isdirectory($HOME . '/.vim')
  let $MY_VIMRUNTIME = $HOME.'/.vim'
elseif isdirectory($HOME . '\vimfiles')
  let $MY_VIMRUNTIME = $HOME.'\vimfiles'
elseif isdirectory($VIM . '\vimfiles')
  let $MY_VIMRUNTIME = $VIM.'\vimfiles'
endif
"ランタイムパスを通す必要のあるプラグインを使用する場合
"$MY_VIMRUNTIMEを使用すると Windows/Linuxで切り分ける必要が無くなります。
"例) vimfiles/qfixapp (Linuxでは~/.vim/qfixapp)にランタイムパスを通す場合
"set runtimepath+=$MY_VIMRUNTIME/qfixapp

"----------------------------------------
" 内部エンコーディング指定
"----------------------------------------
"内部エンコーディングのUTF-8化と文字コードの自動認識設定をencode.vimで行う。
"オールインワンパッケージの場合 vimrcで設定されているので何もしない。
"エンコーディング指定や文字コードの自動認識設定が適切に設定されている場合、
"次行の encode.vim読込部分はコメントアウトして下さい。「encode.vimについて」
source $MY_VIMRUNTIME/plugin/encode.vim

"scriptencodingと異なる内部エンコーディングに変更する場合、
"変更後にもscriptencodingを指定しておくと問題が起きにくくなります。
scriptencoding utf-8

"------------------------------------------------------------------------------
" 以下、http://lambdalisue.hatenablog.com/entry/2013/06/23/07134の一部を改変したもの
"------------------------------------------------------------------------------

" release autogroup in MyAutoCmd
augroup MyAutoCmd
  autocmd!
augroup END

"-------------------
"dein
"-------------------
let g:python3_host_prog = expand('~/.pyenv/shims/python3')

let s:dein_dir = expand('$MY_VIMRUNTIME/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if &runtimepath !~# '/dein.vim'
    if !isdirectory(s:dein_repo_dir)
        execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
    endif
    execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)
    let g:rc_dir = expand('$MY_VIMRUNTIME/rc')
    let s:toml = g:rc_dir . '/dein.toml'
    let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

    call dein#load_toml(s:toml, {'lazy': 0})
    call dein#load_toml(s:lazy_toml, {'lazy': 1})

    call dein#end()
    call dein#save_state()
endif

if dein#check_install()
    call dein#install()
endif

let s:noplugin = 0
" ファイルタイププラグインおよびインデントを有効化
" これはNeoBundleによる処理が終了したあとに呼ばなければならない
filetype plugin indent on

"------------------------------------------------
" 検索関係
"------------------------------------------------
set ignorecase          " 大文字小文字を区別しない
set smartcase           " 検索文字に大文字がある場合は大文字小文字を区別
set incsearch           " インクリメンタルサーチ（≒逐次検索）
set hlsearch            " 検索マッチテキストをハイライト (2013-07-03 14:30 修正）

set wrapscan            " 検索時にファイルの最後まで行ったら最初に戻る

" バックスラッシュやクエスチョンを状況に合わせ自動的にエスケープ
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'

"------------------------------------------------
" 編集関係
"------------------------------------------------
set shiftround          " '<'や'>'でインデントする際に'shiftwidth'の倍数に丸める
set infercase           " 補完時に大文字小文字を区別しない
set virtualedit=all     " カーソルを文字が存在しない部分でも動けるようにする
set hidden              " バッファを閉じる代わりに隠す（Undo履歴を残すため）
set switchbuf=useopen   " 新しく開く代わりにすでに開いてあるバッファを開く
set showmatch           " 対応する括弧などをハイライト表示する
set matchtime=3         " 対応括弧のハイライト表示を3秒にする

set ts=4 sw=4 sts=4     " タブを設定
set autoindent          " 自動的にインデントする
set smartindent         " 賢いインデント
set cindent             " さらに賢いインデント
set cinoptions+=:0      " Ｃインデントの設定
set expandtab           " TABを押した時に空白で代用
set smarttab            " 行頭でTABを押した時、自動インデントする

" 対応括弧に'<'と'>'のペアを追加
set matchpairs& matchpairs+=<:>

" バックスペースでなんでも消せるようにする
set backspace=indent,eol,start

" クリップボードをデフォルトのレジスタとして指定。後にYankRingを使うので
" 'unnamedplus'が存在しているかどうかで設定を分ける必要がある
if has('unnamedplus')
    " set clipboard& clipboard+=unnamedplus " 2013-07-03 14:30 unnamed 追加
    set clipboard& clipboard+=unnamedplus,unnamed
else
    " set clipboard& clipboard+=unnamed,autoselect 2013-06-24 10:00 autoselect 削除
    set clipboard& clipboard+=unnamed
endif

" Swapファイル？Backupファイル？前時代的すぎ
" なので全て無効化する
set nowritebackup
set nobackup
set noswapfile

"------------------------------------------------
" 表示関係
"------------------------------------------------
set list                " 不可視文字の可視化
set number              " 行番号の表示
set cursorline          " カーソルラインをハイライト
set wrap                " 長いテキストの折り返し
set textwidth=0         " 自動的に改行が入るのを無効化
set colorcolumn=80      " その代わり80文字目にラインを入れる

set shortmess+=I        " 起動時のメッセージを表示しない
set shellslash          " Windowsでディレクトリパスの区切り文字表示に / を使えるようにする
set title               " タイトルを表示
set ruler               " ルーラーを表示
set cmdheight=2         " コマンドラインの高さ
set laststatus=2
set showcmd             " コマンドをステータスラインに表示
set showmode            " モードを表示
syntax on               " ハイライトシンタックスをonに

" 前時代的スクリーンベルを無効化
set t_vb=
set novisualbell

" デフォルト不可視文字は美しくないのでUnicodeで綺麗に
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%,eol:↲

" colorschem
colorscheme railscasts
let g:lightline = {}
let g:lightline.colorscheme = 'railscasts'

" devicon
let g:NERDTreeDirArrows = 1
let NERDTreeWinSize=22
" let NERDTreeShowHidden = 1
"vim-nerdtree-syntax-highlight
let s:rspec_red = 'FE405F'
let s:git_orange = 'F54D27'
let g:NERDTreeExactMatchHighlightColor = {} " this line is needed to avoid error
let g:NERDTreeExactMatchHighlightColor['.gitignore'] = s:git_orange " sets the color for .gitignore files
let g:NERDTreePatternMatchHighlightColor = {} " this line is needed to avoid error
let g:NERDTreePatternMatchHighlightColor['.*_spec\.rb$'] = s:rspec_red " sets the color for files ending with _spec.rb

" vim-devicons
let g:webdevicons_conceal_nerdtree_brackets = 1
let g:WebDevIconsNerdTreeAfterGlyphPadding = ' '

" dir-icons
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1
let g:WebDevIconsUnicodeDecorateFolderNodesDefaultSymbol = ''
let g:DevIconsDefaultFolderOpenSymbol = ''
" file-icons
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {}
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['html'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['css'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['md'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['txt'] = ''
set guifont=RictyDiscordForPowerline\ Nerd\ Font:h13

"------------------------------------------------
" マクロおよびキー設定
"------------------------------------------------
"----------------------------------------
" ノーマルモード(旧版より引き継ぎ）
"----------------------------------------
"ヘルプ検索
nnoremap <F1> K
"現在開いているvimスクリプトファイルを実行
nnoremap <F8> :source %<CR>
"強制全保存終了を無効化
nnoremap ZZ <Nop>
"カーソルをj k では表示行で移動する。物理行移動は<C-n>,<C-p>
"キーボードマクロには物理行移動を推奨
"h l はノーマルモードのみ行末、行頭を超えることが可能に設定(whichwrap)
" zvはカーソル位置の折り畳みを開くコマンド
nnoremap <Down> gj
nnoremap <Up>   gk
nnoremap h <Left>zv
nnoremap j gj
nnoremap k gk
nnoremap l <Right>zv
nnoremap <Esc><Esc> :<C-u>set nohlsearch!<CR>
"----------------------------------------
" 挿入モード
"----------------------------------------
"十字キーバグ解消
imap OA <Up>
imap OB <Down>
imap OC <Right>
imap OD <Left>
imap [3~ <Delete>
"----------------------------------------
" コマンドモード
"----------------------------------------
"Windowsのメモ帳ライクのマッピング
map <C-A> ggVG
map <C-X> "+x
map <C-C> "+y
map <C-V> "+gP
map <C-S> :w
map <C-F> :brows confirm e

"------------------------------------------------
" システム設定(旧版.vimrcより引き継ぎ)
"------------------------------------------------
" マウスを有効化
if has('mouse')
    set mouse=a
endif
" 8進数を無効にする。<C-a>,<C-x>に影響する
set nrformats-=octal
" キーコードやマッピングされたキー列が完了するのを待つ時間(ミリ秒)
set timeoutlen=3500
" ヒストリの保存数
set history=50
" 日本語の行の連結時には空白を入力しない
set formatoptions+=mM
" Visual blockモードでフリーカーソルを有効にする
set virtualedit=block
" カーソルキーで行末／行頭の移動可能に設定
set whichwrap=b,s,h,l,[,],<,>
" □や○の文字があってもカーソル位置がずれないようにする
set ambiwidth=double
" コマンドライン補完するときに強化されたものを使う
set wildmenu

"------------------------------------------------
" その他(旧版.vimrc引き継ぎ)
"------------------------------------------------
"----------------------------------------
" ステータスラインに文字コードやBOM、16進表示等表示
" iconvが使用可能の場合、カーソル上の文字コードをエンコードに応じた表示にするFencB()を使用
"----------------------------------------
if has('iconv')
  set statusline=%<%f\ %m\ %r%h%w%{'['.(&fenc!=''?&fenc:&enc).(&bomb?':BOM':'').']['.&ff.']'}%=[0x%{FencB()}]\ (%v,%l)/%L%8P\
else
  set statusline=%<%f\ %m\ %r%h%w%{'['.(&fenc!=''?&fenc:&enc).(&bomb?':BOM':'').']['.&ff.']'}%=\ (%v,%l)/%L%8P\
endif

function! FencB()
  let c = matchstr(getline('.'), '.', col('.') - 1)
  let c = iconv(c, &enc, &fenc)
  return s:Byte2hex(s:Str2byte(c))
endfunction

function! s:Str2byte(str)
  return map(range(len(a:str)), 'char2nr(a:str[v:val])')
endfunction

function! s:Byte2hex(bytes)
  return join(map(copy(a:bytes), 'printf("%02X", v:val)'), '')
endfunction
"----------------------------------------
" 全角スペースを表示
"----------------------------------------
" コメント以外で全角スペースを指定しているので、scriptencodingと、
" このファイルのエンコードが一致するよう注意！
" 強調表示されない場合、ここでscriptencodingを指定するとうまくいく事があります。
"scriptencoding utf-8

" デフォルトのZenkakuSpaceを定義
function! ZenkakuSpace()
  highlight ZenkakuSpace cterm=underline ctermfg=darkgrey gui=underline guifg=darkgrey
endfunction

if has('syntax')
  augroup ZenkakuSpace
    autocmd!
    " ZenkakuSpaceをカラーファイルで設定するなら次の行は削除
    autocmd ColorScheme       * call ZenkakuSpace()
    " 全角スペースのハイライト指定
    autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
  augroup END
  call ZenkakuSpace()
endif
"----------------------------------------
" Windowsで内部エンコーディングがcp932以外の場合
" makeのメッセージが化けるのを回避
"----------------------------------------
if has('win32') || has('win64') || has('win95') || has('win16')
  au QuickfixCmdPost make call QFixCnv('cp932')
endif

function! QFixCnv(enc)
  if a:enc == &enc
    return
  endif
  let qflist = getqflist()
  for i in qflist
    let i.text = iconv(i.text, a:enc, &enc)
  endfor
  call setqflist(qflist)
endfunction
"----------------------------------------
"grep,tagsのためカレントディレクトリをファイルと同じディレクトリに移動する
"----------------------------------------
if exists('+autochdir')
  "autochdirがある場合カレントディレクトリを移動
  set autochdir
else
  "autochdirが存在しないが、カレントディレクトリを移動したい場合
  au BufEnter * execute ":silent! lcd " . escape(expand("%:p:h"), ' ')
endif
