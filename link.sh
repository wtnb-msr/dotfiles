#!/bin/sh

APP_DIR=$(cd $(dirname $0) && pwd)
LINK_DIR=$(cd ${HOME} && pwd)
LIST=$(cat list | grep -v "#")

if [ "${LINK_DIR}" = "" ]; then
  echo "link directory is not found" 1>&2
  exit 1
fi

for dotfile in ${LIST}; do

  LINK_FROM=${LINK_DIR}/${dotfile}
  LINK_TO=${APP_DIR}/home/${dotfile}

  # 不正なファイル
  if [ ! -e ${LINK_TO} ]; then
    echo "${dotfile} is not found."
    continue
  fi

  # ディレクトリの作成
  mkdir -p $(dirname ${LINK_FROM})

  # リンクがない or 差分がないがない場合、リンクで上書き
  if [ ! -e ${LINK_FROM} ] || [ "$(diff ${LINK_FROM} ${LINK_TO})" = "" ]; then
    ln -fs ${LINK_TO} ${LINK_FROM}
    echo "${dotfile} is linked."
    continue

  # 差分があれば確認してリンク
  else
    ln -is ${LINK_TO} ${LINK_FROM}
  fi

done

