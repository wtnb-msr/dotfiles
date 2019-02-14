"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/Users/a13613/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('/Users/a13613/.cache/dein')
  call dein#begin('/Users/a13613/.cache/dein')

  " Let dein manage dein
  " Required:
  call dein#add('/Users/a13613/.cache/dein/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here like this:
  "call dein#add('Shougo/neosnippet.vim')
  "call dein#add('Shougo/neosnippet-snippets')

  " Required:
  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable
