#!/bin/sh

APP_DIR=$(cd $(dirname $0) && pwd)
LINK_DIR=$(cd ${HOME} && pwd)

if [ "${LINK_DIR}" = "" ]; then
  echo "link directory is not found" 1>&2
  exit 1
fi

echo $LINK_DIR

for dotfile in $(cat dotfiles); do

  LINK_FROM=${LINK_DIR}/${dotfile}
  LINK_TO=${APP_DIR}/${dotfile}

  if [ ! -e ${LINK_TO} ]; then
    echo "${dotfile} is not found."
    continue
  fi

  if [ ! -e ${LINK_FROM} ]; then
    ln -s ${LINK_TO} ${LINK_FROM}
    echo "${dotfile} is linked."
    continue
  fi

  diff=$(diff ${LINK_FROM} ${LINK_TO})
  if [ "${diff}" = "" ]; then
    ln -fs ${LINK_TO} ${LINK_FROM}
    echo "${dotfile} is linked."
  else
    ln -is ${LINK_TO} ${LINK_FROM}
  fi
done

