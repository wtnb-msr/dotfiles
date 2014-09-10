" vi 非互換
set nocompatible

" vim を使ってくれてありがとう
set notitle

" 起動時に有効化されていた検出方法を無効化する
filetype off
filetype plugin indent off

" 画面表示の設定
set number         " 行番号を表示する
set cursorline     " カーソル行の背景色を変える
"set cursorcolumn   " カーソル位置のカラムの背景色を変える
set laststatus=2   " ステータス行を常に表示
set cmdheight=2    " メッセージ表示欄を2行確保
set showmatch      " 対応する括弧を強調表示
set helpheight=999 " ヘルプを画面いっぱいに開く
"set list           " 不可視文字を表示
"set listchars=tab:▸\ ,eol:↲,extends:❯,precedes:❮ " 不可視文字の表示記号指定

" アンドゥの継続(v7.3以降)
if version >= 703
  set undodir=~/.vimundo " 履歴保存ディレクトリ
  set undofile
endif

" カーソル移動関連の設定
set backspace=indent,eol,start " Backspaceキーの影響範囲に制限を設けない
set whichwrap=b,s,h,l,<,>,[,]  " 行頭行末の左右移動で行をまたぐ
set scrolloff=8                " 上下8行の視界を確保
set sidescrolloff=16           " 左右スクロール時の視界を確保
set sidescroll=1               " 左右スクロールは一文字づつ行う

" カーソルを表示行で移動する。物理行移動は<C-n>,<C-p>
nnoremap j gj
nnoremap k gk
nnoremap <Down> gj
nnoremap <Up>   gk

" ファイル処理関連の設定
set confirm    " 保存されていないファイルがあるときは終了前に保存確認
set hidden     " 保存されていないファイルがあるときでも別のファイルを開くことが出来る
set autoread   " 外部でファイルに変更がされた場合は読みなおす
set nobackup   " ファイル保存時にバックアップファイルを作らない
set noswapfile " ファイル編集中にスワップファイルを作らない

" 検索/置換の設定
set hlsearch   " 検索文字列をハイライトする
set incsearch  " インクリメンタルサーチを行う
set ignorecase " 大文字と小文字を区別しない
set smartcase  " 大文字と小文字が混在した言葉で検索を行った場合に限り、大文字と小文字を区別する
set wrapscan   " 最後尾まで検索を終えたら次の検索で先頭に移る
set gdefault   " 置換の時 g オプションをデフォルトで有効にする
nnoremap<ESC><ESC>:nohlsearch<CR> " ハイライトを消す

" タブ/インデントの設定
set expandtab     " タブ入力を複数の空白入力に置き換える
set tabstop=2     " 画面上でタブ文字が占める幅
set shiftwidth=2  " 自動インデントでずれる幅
set softtabstop=2 " 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set autoindent    " 改行時に前の行のインデントを継続する
set smartindent   " 改行時に入力された行の末尾に合わせて次の行のインデントを増減する

" タブ幅の設定
au BufNewFile,BufRead *.html set tabstop=2 shiftwidth=2 softtabstop=2
au BufNewFile,BufRead *.css set tabstop=2 shiftwidth=2 softtabstop=2
au BufNewFile,BufRead *.scss set tabstop=2 shiftwidth=2 softtabstop=2
au BufNewFile,BufRead *.js set tabstop=2 shiftwidth=2 softtabstop=2
au BufNewFile,BufRead *.rb set tabstop=2 shiftwidth=2 softtabstop=2
au BufNewFile,BufRead *.py set tabstop=1 shiftwidth=1 softtabstop=1

" マウスの入力を受け付ける
if has('mouse')
  set mouse=a
endif

" ビジュアルモードでクリップボードを共有
set clipboard+=autoselect
" ヤンクでクリップボードを共有
set clipboard+=unnamed         

" コマンドラインモードでTABキーによるファイル名補完を有効にする
set wildmenu wildmode=list:longest,full

" コマンドラインの履歴を10000件保存する
set history=10000

" 文字補完
"inoremap { {}<LEFT>
"inoremap [ []<LEFT>
"inoremap ( ()<LEFT>
"inoremap " ""<LEFT>
"inoremap ' ''<LEFT>
vnoremap { "zdi^V{<C-R>z}<ESC>
vnoremap [ "zdi^V[<C-R>z]<ESC>
vnoremap ( "zdi^V(<C-R>z)<ESC>
vnoremap " "zdi^V"<C-R>z^V"<ESC>
vnoremap ' "zdi'<C-R>z'<ESC>

" 保存時に行末の空白を除去する
autocmd BufWritePre * :%s/\s\+$//ge
" 保存時にtabをスペースに変換する
autocmd BufWritePre * :%s/\t/  /ge

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
  call neobundle#rc(expand('~/.vim/bundle/'))
endif

" originalrepos on github
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc'
""NeoBundle 'VimClojure'
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/unite.vim'

" 補完
NeoBundle 'Shougo/neocomplete'
  let g:neocomplete#enable_at_startup = 1
    
NeoBundle 'Shougo/neosnippet'
NeoBundle "Shougo/neosnippet-snippets"
  " Plugin key-mappings.
  imap <C-k>     <Plug>(neosnippet_expand_or_jump)
  smap <C-k>     <Plug>(neosnippet_expand_or_jump)
  xmap <C-k>     <Plug>(neosnippet_expand_target)

  " SuperTab like snippets behavior.
  imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
              \ "\<Plug>(neosnippet_expand_or_jump)"
              \: pumvisible() ? "\<C-n>" : "\<TAB>"
  smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
              \ "\<Plug>(neosnippet_expand_or_jump)"
              \: "\<TAB>"

  " For snippet_complete marker.
  if has('conceal')
      set conceallevel=2 concealcursor=i
  endif

" ツリー型エクスプローラ
NeoBundle 'scrooloose/nerdtree'
  "autocmd vimenter * NERDTree
  nmap <silent> <C-e>      :NERDTreeToggle<CR>
  vmap <silent> <C-e> <Esc>:NERDTreeToggle<CR>
  omap <silent> <C-e>      :NERDTreeToggle<CR>
  imap <silent> <C-e> <Esc>:NERDTreeToggle<CR>
  cmap <silent> <C-e> <C-u>:NERDTreeToggle<CR>

" バッファタブ管理
"NeoBundle 'fholgado/minibufexpl.vim'
"  noremap <C-H> <C-W>h
"  noremap <C-J> <C-W>j
  "noremap <C-K> <C-W>k
  "noremap <C-L> <C-W>l

" シンタックスチェック
"NeoBundle 'scrooloose/syntastic'

" emmet 
NeoBundle 'mattn/emmet-vim'
  let g:user_emmet_settings = {
  \   'lang' : 'ja'
  \ }
  
" quick run 
NeoBundle 'thinca/vim-quickrun'

""NeoBundle 'jpalardy/vim-slime'
""NeoBundle 'https://bitbucket.org/kovisoft/slimv'

NeoBundle 'haya14busa/vim-migemo'

" f の検索移動を拡張. 'f' + char + 'f'
NeoBundle 'rhysd/clever-f.vim'

" Easymotion
NeoBundle 'Lokaltog/vim-easymotion'
  map <Leader> <Plug>(easymotion-prefix)

" required for neobundle
filetype plugin indent on

if has("autocmd")
  " ファイルタイプ別インデント、プラグインを有効にする
  filetype plugin indent on
  " カーソル位置を記憶する
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif
endif

" Installation check.
NeoBundleCheck

"-------------------------------------------------------------------------------"
" Mapping
"-------------------------------------------------------------------------------"
" コマンド       ノーマルモード 挿入モード コマンドラインモード ビジュアルモード
" map /noremap           @            -              -                  @
" nmap / nnoremap        @            -              -                  -
" imap / inoremap        -            @              -                  -
" cmap / cnoremap        -            -              @                  -
" vmap / vnoremap        -            -              -                  @
" map! / noremap!        -            @              @                  -
"-------------------------------------------------------------------------------"
