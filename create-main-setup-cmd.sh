#!/usr/bin/env bash

WORK_DIR=$HOME/script-machines

ENV_DETERMINE_DIR=/usr/local/src

ENV_DETERMINE_FILE_NAME=systemd_nspawn.env

DEPLOY_DIR=/var/lib/machines

PREFIX=vir-

SUFFIX=-template

SYSTEM_NETWORK_DIR=/etc/systemd/network

RESOLVE_CONF_FILE_PATH=/etc/systemd/resolved.conf

CONTAINER_HOST0_NETWORK_NAME=80-container-host0.network

HOST0_NETWORK_NAME=host0.network

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

KEYWORDS=($CONTAINER_HOST0_NETWORK_NAME $HOST0_NETWORK_NAME)

ACTION_LIST=(stop enable start status)

MY_ROUTER_IP=192.168.1.1

GOOGLE_DNS_IP=8.8.8.8

SEGMENT_THIRD_OCTET_IP=192.168.1
SEGMENT_FORTH_OCTET_START_IP=209

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

#コンテナゲストファイル群の削除
eval echo {$START_HOST_NO..$END_HOST_NO} | xargs -n1 | xargs -I@ echo rm -rf $DEPLOY_DIR/$REPLICA_NAME-@

#コンテナゲストファイルの配備
eval echo {$START_HOST_NO..$END_HOST_NO} | xargs -n1 | xargs -I@ echo cp -a $DEPLOY_DIR/$SEED_NAME $DEPLOY_DIR/$REPLICA_NAME-@

#コンテナゲストプロセスの開始
eval echo {$START_HOST_NO..$END_HOST_NO} | xargs -n1 | while read n;do printf "cd $DEPLOY_DIR && machinectl start $REPLICA_NAME-%s\n" $(printf $SUBGRP_DIGIT $n);done

#コンテナゲストのrootユーザーのパスワード設定
eval echo {$START_HOST_NO..$END_HOST_NO} | xargs -n1 | while read n;do printf "cd $DEPLOY_DIR && machinectl shell root@$REPLICA_NAME-%s /bin/bash -c \x27echo \x22root:root_pwd\x22|chpasswd\x27;\n" $(printf $SUBGRP_DIGIT $[n]);done

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

#おまじない
eval echo {$START_HOST_NO..$END_HOST_NO} | xargs -n1 | xargs -I{} echo "cd $DEPLOY_DIR && machinectl shell root@$REPLICA_NAME-{} /usr/bin/ln -sf /dev/null $SYSTEM_NETWORK_DIR/$CONTAINER_HOST0_NETWORK_NAME"

#DNSの設定
eval echo {$START_HOST_NO..$END_HOST_NO} | xargs -n1 | while read n;do printf "cd $DEPLOY_DIR && machinectl shell root@$REPLICA_NAME-%s /usr/bin/sed -i \x27/^#DNS=$/s/#DNS=/DNS=$MY_ROUTER_IP/\x27 $RESOLVE_CONF_FILE_PATH\n" $(printf $SUBGRP_DIGIT $[n]);done

CNT=$(eval echo {$START_HOST_NO..$END_HOST_NO} | xargs -n1 | wc -l)

#コンテナゲストのネットワーク設定ファイルの作成
#テンプレートファイルからの生成
if [ ! -f $HOST0_NETWORK_NAME ];then

  usage

fi

seq $CNT | xargs -I@ echo echo $SEGMENT_THIRD_OCTET_IP.$\[$SEGMENT_FORTH_OCTET_START_IP+@\] $MY_ROUTER_IP |bash|\
  while read server_ip my_router_ip;do
    sed "s/SERVER_IP/$server_ip/;s/MY_ROUTER_IP/$my_router_ip/;" $HOST0_NETWORK_NAME >$HOST0_NETWORK_NAME-$server_ip;
  done

#配備コマンドの作成
for keyword in ${KEYWORDS[@]} ;do

  eval echo {$START_HOST_NO..$END_HOST_NO} | xargs -n1|nl|\

    while read n h;do

      if [ $keyword == "$CONTAINER_HOST0_NETWORK_NAME" ];then

        echo "cp $WORK_DIR/$keyword $DEPLOY_DIR/$REPLICA_NAME-$(printf  $SUBGRP_DIGIT $[n])$SYSTEM_NETWORK_DIR/$keyword"

      else

        echo "cp $WORK_DIR/$keyword-$SEGMENT_THIRD_OCTET_IP.$[$SEGMENT_FORTH_OCTET_START_IP+$n] $DEPLOY_DIR/$REPLICA_NAME-$(printf  $SUBGRP_DIGIT $[n])$SYSTEM_NETWORK_DIR/$keyword"

      fi


    done

done

#コンテナホストとコンテナゲスト間の疎通ファイルの作成
#テンプレートファイルからの生成
#コピーしてから向き先変える
eval echo {$START_HOST_NO..$END_HOST_NO} | xargs -n1|nl|\
  while read n h;do

    echo "cd $DEPLOY_DIR && machinectl shell root@$REPLICA_NAME-$(printf $SUBGRP_DIGIT $[n]) /usr/bin/ln -sf /dev/null /etc/systemd/network/80-container-host0.network"

  done

#環境特定ファイルの作成
eval echo {$START_HOST_NO..$END_HOST_NO} | xargs -n1|nl|\
  while read n h;do

    echo "cp $WORK_DIR/$ENV_DETERMINE_FILE_NAME $DEPLOY_DIR/$REPLICA_NAME-$(printf  $SUBGRP_DIGIT $[n])$ENV_DETERMINE_DIR/$ENV_DETERMINE_FILE_NAME"

  done

#コンテナゲストのネットワークないしリゾルバサービスの停止、有効化、開始、状態確認コマンドの作成
for action in ${ACTION_LIST[@]} ;do

  eval echo {$START_HOST_NO..$END_HOST_NO} | xargs -n1|nl|\
    while read n h;do

      if [ $action == "status" ];then

        echo "cd $DEPLOY_DIR && machinectl shell root@$REPLICA_NAME-$(printf $SUBGRP_DIGIT $[n]) /bin/systemctl --no-pager $action systemd-networkd"
        echo "cd $DEPLOY_DIR && machinectl shell root@$REPLICA_NAME-$(printf $SUBGRP_DIGIT $[n]) /bin/systemctl --no-pager $action systemd-resolved"

      else

        echo "cd $DEPLOY_DIR && machinectl shell root@$REPLICA_NAME-$(printf $SUBGRP_DIGIT $[n]) /bin/systemctl $action systemd-networkd"
        echo "cd $DEPLOY_DIR && machinectl shell root@$REPLICA_NAME-$(printf $SUBGRP_DIGIT $[n]) /bin/systemctl $action systemd-resolved"

      fi
    done

done

#コンテナホストのsystemd-nspawnサービスの停止、有効化、開始、状態確認コマンドの作成
eval echo {$START_HOST_NO..$END_HOST_NO} | xargs -n1 | xargs -I{} echo systemctl stop systemd-nspawn@$REPLICA_NAME-{}.service
eval echo {$START_HOST_NO..$END_HOST_NO} | xargs -n1 | xargs -I{} echo systemctl enable systemd-nspawn@$REPLICA_NAME-{}.service
eval echo {$START_HOST_NO..$END_HOST_NO} | xargs -n1 | xargs -I{} echo systemctl start systemd-nspawn@$REPLICA_NAME-{}.service
eval echo {$START_HOST_NO..$END_HOST_NO} | xargs -n1 | xargs -I{} echo systemctl status --no-pager systemd-nspawn@$REPLICA_NAME-{}.service
