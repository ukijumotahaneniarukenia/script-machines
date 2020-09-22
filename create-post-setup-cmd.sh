#!/usr/bin/env bash

WORK_DIR=$HOME/script-machines

DEPLOY_DIR=/var/lib/machines

PREFIX=vir-

SUFFIX=-template

usage(){
cat <<EOS
Usage:

   IN: $0 1 5 ubuntu-18-04

  OUT:

EOS

exit 0

}

s=$1;shift;
e=$1;shift;
TEMPLATE_OS=$1;shift;

if [ -z $s ];then

  usage

fi

if [ -z $e ];then

  usage

fi

if [[ $s -le 0 ]];then

  usage

fi

if [[ $e -le 0 ]];then

  usage

fi

if [ -z $TEMPLATE_OS ];then

  usage

fi

SEED_NAME=$PREFIX$TEMPLATE_OS$SUFFIX

REPLICA_NAME=$PREFIX$TEMPLATE_OS

SUBGRP_DIGIT="%03d"

START_HOST_NO=$(printf $SUBGRP_DIGIT $s)
END_HOST_NO=$(printf $SUBGRP_DIGIT $e)

#コンテナゲストのリポジトリエントリの変更
eval echo {$START_HOST_NO..$END_HOST_NO} | xargs -n1 | while read n;do printf "cd $DEPLOY_DIR && machinectl shell root@$REPLICA_NAME-%s /usr/bin/sed -i.bak 's@archive.ubuntu.com@ftp.jaist.ac.jp/pub/Linux@g' /etc/apt/sources.list\n" $(printf $SUBGRP_DIGIT $[n]);done

#コンテナゲストのリポジトリの更新
eval echo {$START_HOST_NO..$END_HOST_NO} | xargs -n1 | while read n;do printf "cd $DEPLOY_DIR && machinectl shell root@$REPLICA_NAME-%s /usr/bin/apt update\n" $(printf $SUBGRP_DIGIT $[n]);done

#コンテナゲストへマストコマンドのインストール
eval echo {$START_HOST_NO..$END_HOST_NO} | xargs -n1 | while read n;do printf "cd $DEPLOY_DIR && machinectl shell root@$REPLICA_NAME-%s /usr/bin/apt install -y git curl unzip\n" $(printf $SUBGRP_DIGIT $[n]);done

#コンテナゲストのリポジトリエントリの追加
eval echo {$START_HOST_NO..$END_HOST_NO} | xargs -n1 | while read n;do printf "cd $DEPLOY_DIR && machinectl shell root@$REPLICA_NAME-%s /bin/bash -c \x27echo \x22deb http://ftp.jaist.ac.jp/pub/Linux/ubuntu bionic main\x22 | tee -a /etc/apt/sources.list\x27\n" $(printf $SUBGRP_DIGIT $[n]);done

#コンテナゲストのリポジトリエントリの追加
eval echo {$START_HOST_NO..$END_HOST_NO} | xargs -n1 | while read n;do printf "cd $DEPLOY_DIR && machinectl shell root@$REPLICA_NAME-%s /bin/bash -c \x27echo \x22deb http://jp.archive.ubuntu.com/ubuntu/ bionic main restricted\x22 | tee -a /etc/apt/sources.list\x27\n" $(printf $SUBGRP_DIGIT $[n]);done

#コンテナゲストのリポジトリエントリの追加
eval echo {$START_HOST_NO..$END_HOST_NO} | xargs -n1 | while read n;do printf "cd $DEPLOY_DIR && machinectl shell root@$REPLICA_NAME-%s /bin/bash -c \x27echo \x22deb http://jp.archive.ubuntu.com/ubuntu/ bionic-updates main restricted\x22 | tee -a /etc/apt/sources.list\x27\n" $(printf $SUBGRP_DIGIT $[n]);done

#コンテナゲストのリポジトリエントリの追加
eval echo {$START_HOST_NO..$END_HOST_NO} | xargs -n1 | while read n;do printf "cd $DEPLOY_DIR && machinectl shell root@$REPLICA_NAME-%s /bin/bash -c \x27echo \x22deb http://jp.archive.ubuntu.com/ubuntu/ bionic universe\x22 | tee -a /etc/apt/sources.list\x27\n" $(printf $SUBGRP_DIGIT $[n]);done

#コンテナゲストのリポジトリエントリの追加
eval echo {$START_HOST_NO..$END_HOST_NO} | xargs -n1 | while read n;do printf "cd $DEPLOY_DIR && machinectl shell root@$REPLICA_NAME-%s /bin/bash -c \x27echo \x22deb http://jp.archive.ubuntu.com/ubuntu/ bionic-updates universe\x22 | tee -a /etc/apt/sources.list\x27\n" $(printf $SUBGRP_DIGIT $[n]);done

#コンテナゲストのリポジトリエントリの追加
eval echo {$START_HOST_NO..$END_HOST_NO} | xargs -n1 | while read n;do printf "cd $DEPLOY_DIR && machinectl shell root@$REPLICA_NAME-%s /bin/bash -c \x27echo \x22deb http://jp.archive.ubuntu.com/ubuntu/ bionic multiverse\x22 | tee -a /etc/apt/sources.list\x27\n" $(printf $SUBGRP_DIGIT $[n]);done

#コンテナゲストのリポジトリエントリの追加
eval echo {$START_HOST_NO..$END_HOST_NO} | xargs -n1 | while read n;do printf "cd $DEPLOY_DIR && machinectl shell root@$REPLICA_NAME-%s /bin/bash -c \x27echo \x22deb http://jp.archive.ubuntu.com/ubuntu/ bionic-updates multiverse\x22 | tee -a /etc/apt/sources.list\x27\n" $(printf $SUBGRP_DIGIT $[n]);done

#コンテナゲストのリポジトリエントリの追加
eval echo {$START_HOST_NO..$END_HOST_NO} | xargs -n1 | while read n;do printf "cd $DEPLOY_DIR && machinectl shell root@$REPLICA_NAME-%s /bin/bash -c \x27echo \x22deb http://jp.archive.ubuntu.com/ubuntu/ bionic-backports main restricted universe multiverse\x22 | tee -a /etc/apt/sources.list\x27\n" $(printf $SUBGRP_DIGIT $[n]);done

#コンテナゲストのリポジトリエントリの追加
eval echo {$START_HOST_NO..$END_HOST_NO} | xargs -n1 | while read n;do printf "cd $DEPLOY_DIR && machinectl shell root@$REPLICA_NAME-%s /bin/bash -c \x27echo \x22deb http://security.ubuntu.com/ubuntu bionic-security main restricted\x22 | tee -a /etc/apt/sources.list\x27\n" $(printf $SUBGRP_DIGIT $[n]);done

#コンテナゲストのリポジトリエントリの追加
eval echo {$START_HOST_NO..$END_HOST_NO} | xargs -n1 | while read n;do printf "cd $DEPLOY_DIR && machinectl shell root@$REPLICA_NAME-%s /bin/bash -c \x27echo \x22deb http://security.ubuntu.com/ubuntu bionic-security universe\x22 | tee -a /etc/apt/sources.list\x27\n" $(printf $SUBGRP_DIGIT $[n]);done

#コンテナゲストのリポジトリエントリの追加
eval echo {$START_HOST_NO..$END_HOST_NO} | xargs -n1 | while read n;do printf "cd $DEPLOY_DIR && machinectl shell root@$REPLICA_NAME-%s /bin/bash -c \x27echo \x22deb http://security.ubuntu.com/ubuntu bionic-security multiverse\x22 | tee -a /etc/apt/sources.list\x27\n" $(printf $SUBGRP_DIGIT $[n]);done

#コンテナゲストのリポジトリの更新
eval echo {$START_HOST_NO..$END_HOST_NO} | xargs -n1 | while read n;do printf "cd $DEPLOY_DIR && machinectl shell root@$REPLICA_NAME-%s /usr/bin/apt update\n" $(printf $SUBGRP_DIGIT $[n]);done

#コンテナゲストへスクリプトレポのダウンロード
eval echo {$START_HOST_NO..$END_HOST_NO} | xargs -n1 | while read n;do printf "cd $DEPLOY_DIR && machinectl shell root@$REPLICA_NAME-%s /bin/bash -c \x27cd /usr/local/src && git clone https://github.com/ukijumotahaneniarukenia/script-repo.git\x27\n" $(printf $SUBGRP_DIGIT $[n]);done

#コンテナゲストへdevコマンド群のインストール
eval echo {$START_HOST_NO..$END_HOST_NO} | xargs -n1 | while read n;do printf "cd $DEPLOY_DIR && machinectl shell root@$REPLICA_NAME-%s /bin/bash -c \x27cd /usr/local/src/script-repo && bash $TEMPLATE_OS-install-dev-pkg.sh\x27\n" $(printf $SUBGRP_DIGIT $[n]);done

#コンテナゲストへvimビルドコマンド群のインストール
eval echo {$START_HOST_NO..$END_HOST_NO} | xargs -n1 | while read n;do printf "cd $DEPLOY_DIR && machinectl shell root@$REPLICA_NAME-%s /usr/bin/apt install -y autoconf automake gcc git make\n" $(printf $SUBGRP_DIGIT $[n]);done

#コンテナゲストへvimソースのダウンロード
eval echo {$START_HOST_NO..$END_HOST_NO} | xargs -n1 | while read n;do printf "cd $DEPLOY_DIR && machinectl shell root@$REPLICA_NAME-%s /bin/bash -c \x27cd /usr/local/src && rm -rf vim && git clone https://github.com/vim/vim.git\x27\n" $(printf $SUBGRP_DIGIT $[n]);done

#コンテナゲストのvimソースの設定
eval echo {$START_HOST_NO..$END_HOST_NO} | xargs -n1 | while read n;do printf "cd $DEPLOY_DIR && machinectl shell root@$REPLICA_NAME-%s /bin/bash -c \x27cd /usr/local/src/vim && ./configure --with-features=huge --enable-multibyte  --enable-gpm   --enable-cscope   --enable-fontset   --enable-fail-if-missing   --prefix=/usr/local\x27\n" $(printf $SUBGRP_DIGIT $[n]);done

#コンテナゲストのvimソースのmake
eval echo {$START_HOST_NO..$END_HOST_NO} | xargs -n1 | while read n;do printf "cd $DEPLOY_DIR && machinectl shell root@$REPLICA_NAME-%s /bin/bash -c \x27cd /usr/local/src/vim && make -j12\x27\n" $(printf $SUBGRP_DIGIT $[n]);done

#コンテナゲストのvimコマンドのインストール
eval echo {$START_HOST_NO..$END_HOST_NO} | xargs -n1 | while read n;do printf "cd $DEPLOY_DIR && machinectl shell root@$REPLICA_NAME-%s /bin/bash -c \x27cd /usr/local/src/vim && make -j12 install\x27\n" $(printf $SUBGRP_DIGIT $[n]);done

#コンテナゲストへviコマンドのインストール
eval echo {$START_HOST_NO..$END_HOST_NO} | xargs -n1 | while read n;do printf "cd $DEPLOY_DIR && machinectl shell root@$REPLICA_NAME-%s \$(/usr/bin/which ln) -fsr /usr/local/bin/vim /usr/bin/vi\n" $(printf $SUBGRP_DIGIT $[n]);done

#コンテナゲストのvimコマンドのインストール確認
eval echo {$START_HOST_NO..$END_HOST_NO} | xargs -n1 | while read n;do printf "cd $DEPLOY_DIR && machinectl shell root@$REPLICA_NAME-%s /usr/bin/which vim\n" $(printf $SUBGRP_DIGIT $[n]);done

#コンテナゲストのviコマンドのインストール確認
eval echo {$START_HOST_NO..$END_HOST_NO} | xargs -n1 | while read n;do printf "cd $DEPLOY_DIR && machinectl shell root@$REPLICA_NAME-%s /usr/bin/which vi\n" $(printf $SUBGRP_DIGIT $[n]);done

#コンテナゲストのrootユーザーのユーザー個別vim環境設定
eval echo {$START_HOST_NO..$END_HOST_NO} | xargs -n1 | while read n;do printf "cd $DEPLOY_DIR && machinectl shell root@$REPLICA_NAME-%s /bin/bash -c \x27cd /usr/local/src/script-repo && bash $TEMPLATE_OS-install-vim-user.sh\x27\n" $(printf $SUBGRP_DIGIT $[n]);done

#コンテナゲストのrootユーザーのユーザー個別vim_plug環境設定
eval echo {$START_HOST_NO..$END_HOST_NO} | xargs -n1 | while read n;do printf "cd $DEPLOY_DIR && machinectl shell root@$REPLICA_NAME-%s /bin/bash -c \x27cd /usr/local/src/script-repo && bash $TEMPLATE_OS-install-vim_plug.sh\x27\n" $(printf $SUBGRP_DIGIT $[n]);done

#コンテナゲストのrootユーザーのユーザー個別dotfile環境設定
eval echo {$START_HOST_NO..$END_HOST_NO} | xargs -n1 | while read n;do printf "cd $DEPLOY_DIR && machinectl shell root@$REPLICA_NAME-%s /bin/bash -c \x27cd /usr/local/src/script-repo && bash ubuntu-00-00-config-dotfile-system.sh\x27\n" $(printf $SUBGRP_DIGIT $[n]);done

#コンテナゲストのロケール設定
eval echo {$START_HOST_NO..$END_HOST_NO} | xargs -n1 | while read n;do printf "cd $DEPLOY_DIR && machinectl shell root@$REPLICA_NAME-%s /bin/bash -c \x27cd /usr/local/src/script-repo && bash $TEMPLATE_OS-config-locale.sh\x27\n" $(printf $SUBGRP_DIGIT $[n]);done

#コンテナゲストのrootユーザーのユーザー個別環境変数設定
eval echo {$START_HOST_NO..$END_HOST_NO} | xargs -n1 | while read n;do printf "cd $DEPLOY_DIR && machinectl shell root@$REPLICA_NAME-%s /bin/bash -c \x27cd /usr/local/src/script-repo && bash ubuntu-00-00-config-env-system.sh\x27\n" $(printf $SUBGRP_DIGIT $[n]);done

#コンテナゲストのrootユーザーのユーザー個別フォント設定
eval echo {$START_HOST_NO..$END_HOST_NO} | xargs -n1 | while read n;do printf "cd $DEPLOY_DIR && machinectl shell root@$REPLICA_NAME-%s /bin/bash -c \x27cd /usr/local/src/script-repo && bash $TEMPLATE_OS-config-font-RictyDiminished.sh\x27\n" $(printf $SUBGRP_DIGIT $[n]);done


#コンテナゲストの一般ユーザーのユーザー個別vim環境設定
eval echo {$START_HOST_NO..$END_HOST_NO} | xargs -n1 | while read n;do printf "cd $DEPLOY_DIR && machinectl shell aine@$REPLICA_NAME-%s /bin/bash -c \x27cd /usr/local/src/script-repo && bash $TEMPLATE_OS-install-vim-user.sh\x27\n" $(printf $SUBGRP_DIGIT $[n]);done

#コンテナゲストの一般ユーザーのユーザー個別vim_plug環境設定
eval echo {$START_HOST_NO..$END_HOST_NO} | xargs -n1 | while read n;do printf "cd $DEPLOY_DIR && machinectl shell aine@$REPLICA_NAME-%s /bin/bash -c \x27cd /usr/local/src/script-repo && bash $TEMPLATE_OS-install-vim_plug.sh\x27\n" $(printf $SUBGRP_DIGIT $[n]);done

#コンテナゲストの一般ユーザーのユーザー個別dotfile環境設定
eval echo {$START_HOST_NO..$END_HOST_NO} | xargs -n1 | while read n;do printf "cd $DEPLOY_DIR && machinectl shell aine@$REPLICA_NAME-%s /bin/bash -c \x27cd /usr/local/src/script-repo && bash ubuntu-00-00-config-dotfile-system.sh\x27\n" $(printf $SUBGRP_DIGIT $[n]);done

#コンテナゲストの一般ユーザーのユーザー個別環境変数設定
eval echo {$START_HOST_NO..$END_HOST_NO} | xargs -n1 | while read n;do printf "cd $DEPLOY_DIR && machinectl shell aine@$REPLICA_NAME-%s /bin/bash -c \x27cd /usr/local/src/script-repo && bash ubuntu-00-00-config-env-system.sh\x27\n" $(printf $SUBGRP_DIGIT $[n]);done

#コンテナゲストの一般ユーザーのユーザー個別フォント設定
eval echo {$START_HOST_NO..$END_HOST_NO} | xargs -n1 | while read n;do printf "cd $DEPLOY_DIR && machinectl shell aine@$REPLICA_NAME-%s /bin/bash -c \x27cd /usr/local/src/script-repo && bash $TEMPLATE_OS-config-font-RictyDiminished.sh\x27\n" $(printf $SUBGRP_DIGIT $[n]);done
