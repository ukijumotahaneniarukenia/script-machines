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

#コンテナホストのsystemd-nspawnサービスの状態確認
eval echo {$START_HOST_NO..$END_HOST_NO} | xargs -n1 | xargs -I{} echo systemctl status --no-pager systemd-nspawn@$REPLICA_NAME-{}.service

#コンテナホストのsystemd-nspawnサービスの停止
eval echo {$START_HOST_NO..$END_HOST_NO} | xargs -n1 | xargs -I{} echo systemctl stop systemd-nspawn@$REPLICA_NAME-{}.service

#コンテナホストのsystemd-nspawnサービスの状態確認
eval echo {$START_HOST_NO..$END_HOST_NO} | xargs -n1 | xargs -I{} echo systemctl status --no-pager systemd-nspawn@$REPLICA_NAME-{}.service

#コンテナゲストプロセスの停止
eval echo {$START_HOST_NO..$END_HOST_NO} | xargs -n1 | xargs -I@ echo "cd $DEPLOY_DIR && machinectl terminate $REPLICA_NAME-@"

#ロックファイルの削除
eval echo {$START_HOST_NO..$END_HOST_NO} | xargs -n1 | xargs -I@ echo "echo $DEPLOY_DIR/.#$REPLICA_NAME-@ | xargs rm -rf"

#コンテナゲストプロセスの開始
eval echo {$START_HOST_NO..$END_HOST_NO} | xargs -n1 | xargs -I@ echo "cd $DEPLOY_DIR && machinectl terminate $REPLICA_NAME-@"

#コンテナゲストプロセスの状態確認
echo 'machinectl list -a'

#コンテナゲストの一般ユーザーグループの作成
eval echo {$START_HOST_NO..$END_HOST_NO} | xargs -n1 | while read n;do printf "cd $DEPLOY_DIR && machinectl shell root@$REPLICA_NAME-%s /usr/sbin/groupadd -g 1000 aine\n" $(printf $SUBGRP_DIGIT $[n]);done

#コンテナゲストの一般ユーザーの作成
eval echo {$START_HOST_NO..$END_HOST_NO} | xargs -n1 | while read n;do printf "cd $DEPLOY_DIR && machinectl shell root@$REPLICA_NAME-%s /usr/sbin/useradd -m -g aine -u 1000 aine\n" $(printf $SUBGRP_DIGIT $[n]);done

#コンテナゲストの一般ユーザーのログインシェルの変更
eval echo {$START_HOST_NO..$END_HOST_NO} | xargs -n1 | while read n;do printf "cd $DEPLOY_DIR && machinectl shell root@$REPLICA_NAME-%s /usr/bin/chsh -s /bin/bash aine\n" $(printf $SUBGRP_DIGIT $[n]);done

#コンテナゲストの一般ユーザーのパスワードの設定
eval echo {$START_HOST_NO..$END_HOST_NO} | xargs -n1 | while read n;do printf "cd $DEPLOY_DIR && machinectl shell root@$REPLICA_NAME-%s /bin/bash -c \x27echo \x22aine:aine_pwd\x22|chpasswd\x27\n" $(printf $SUBGRP_DIGIT $[n]);done

#コンテナゲストの一般ユーザーのsudo設定
eval echo {$START_HOST_NO..$END_HOST_NO} | xargs -n1 | while read n;do printf "cd $DEPLOY_DIR && machinectl shell root@$REPLICA_NAME-%s /bin/bash -c \x27echo \x22aine ALL=(ALL) NOPASSWD:ALL\x22 >> /etc/sudoers \x27\n" $(printf $SUBGRP_DIGIT $[n]);done

#コンテナゲストプロセスの停止
eval echo {$START_HOST_NO..$END_HOST_NO} | xargs -n1 | xargs -I@ echo "cd $DEPLOY_DIR && machinectl terminate $REPLICA_NAME-@"

#コンテナゲストプロセスの状態確認
echo 'machinectl list -a'




