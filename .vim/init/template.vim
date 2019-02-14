augroup template
  autocmd!
  autocmd BufNewFile *.py :0r ${HOME}/.vim/template/py.txt
  autocmd BufNewFile *.sh :0r ${HOME}/.vim/template/sh.txt
augroup END
