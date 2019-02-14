#!/bin/sh

dir=$(cd $(dirname $0) && pwd)

cd ${dir}

for dotfile in .??* ; do

  case "${dotfile}" in
    ".git" | ".DS_Store" ) continue;;
  esac

  echo ln -fns ${dir}/${dotfile} ${HOME}/${dotfile}
  ln -fns ${dir}/${dotfile} ${HOME}/${dotfile}

done

