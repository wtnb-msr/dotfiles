"-------------------------------------------------------------"
" Mapping
"-------------------------------------------------------------"
" command          | Normal | Insert | Command line | Visual
" -----------------|--------|--------|--------------|---------"
" map  / noremap   |    @   |    -   |      -       |    @
" nmap / nnoremap  |    @   |    -   |      -       |    -
" imap / inoremap  |    -   |    @   |      -       |    -
" cmap / cnoremap  |    -   |    -   |      @       |    -
" vmap / vnoremap  |    -   |    -   |      -       |    @
" map! / noremap!  |    -   |    @   |      @       |    -
"-------------------------------------------------------------"

" カーソルを表示行で移動する。物理行移動は<C-n>,<C-p>
nnoremap j gj
nnoremap k gk
nnoremap <Down> gj
nnoremap <Up>   gk

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

