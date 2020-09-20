#!/usr/bin/env bash

WORKDIR=/var/lib/machines

PREFIX=vir-

SUFFIX=-template

DEPLOY_DIR=/etc/systemd/network

RESOLVE_CONF_FILE_PATH=/etc/systemd/resolved.conf

CONTAINER_HOST0_NETWORK_NAME=80-container-host0.network

HOST0_NETWORK_NAME=host0.network

ENTYR_FILE_NAME=systemd_nspawn-container-guest-listup-entry-cmd.sh

OUTPUT_FILE_NAME=systemd_nspawn-container-guest-listup-setup-cmd.sh

usage(){
cat <<EOS
Usage:

   IN: $0 1 5 ubuntu-18-04 > $WORKDIR/$OUTPUT_FILE_NAME

  OUT:

EOS

exit 0

}

s=$1;shift;
e=$1;shift;
TEMPLATE_OS=$1;shift;

#if [[ $UID  -ne 0 ]];then
#
#  usage
#
#fi

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

#ロックファイルの削除
eval echo {$START_HOST_NO..$END_HOST_NO} | xargs -n1 | xargs -I@ echo "echo $WORKDIR/.#$REPLICA_NAME-@ | xargs rm -rf"

#仮想コンテナプロセスの停止
eval echo {$START_HOST_NO..$END_HOST_NO} | xargs -n1 | xargs -I@ echo "cd $WORKDIR && machinectl terminate $REPLICA_NAME-@"

#仮想コンテナファイル群の削除
eval echo {$START_HOST_NO..$END_HOST_NO} | xargs -n1 | xargs -I@ echo rm -rf $WORKDIR/$REPLICA_NAME-@

#仮想コンテナファイルの配備
eval echo {$START_HOST_NO..$END_HOST_NO} | xargs -n1 | xargs -I@ echo cp -a $WORKDIR/$SEED_NAME $WORKDIR/$REPLICA_NAME-@

#仮想コンテナプロセスの開始
eval echo {$START_HOST_NO..$END_HOST_NO} | xargs -n1 | while read n;do printf "cd $WORKDIR && machinectl start $REPLICA_NAME-%s\n" $(printf $SUBGRP_DIGIT $n);done

#仮想コンテナのrootユーザーのパスワード設定
eval echo {$START_HOST_NO..$END_HOST_NO} | xargs -n1 | while read n;do printf "cd $WORKDIR && machinectl shell root@$REPLICA_NAME-%s /bin/bash -c \x27echo \x22root:root_pwd\x22|chpasswd\x27;\n" $(printf $SUBGRP_DIGIT $[n]);done

#おまじない
eval echo {$START_HOST_NO..$END_HOST_NO} | xargs -n1 | xargs -I{} echo "cd $WORKDIR && machinectl shell root@$REPLICA_NAME-{} /usr/bin/ln -sf /dev/null $DEPLOY_DIR/$CONTAINER_HOST0_NETWORK_NAME"

#DNSの設定
eval echo {$START_HOST_NO..$END_HOST_NO} | xargs -n1 | while read n;do printf "cd $WORKDIR && machinectl shell root@$REPLICA_NAME-%s /usr/bin/sed -i \x27/^#DNS=$/s/#DNS=/DNS=$MY_ROUTER_IP/\x27 $RESOLVE_CONF_FILE_PATH\n" $(printf $SUBGRP_DIGIT $[n]);done

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

      echo "cp $WORKDIR/$keyword-$SEGMENT_THIRD_OCTET_IP.$[$SEGMENT_FORTH_OCTET_START_IP+$n] $WORKDIR/$REPLICA_NAME-$(printf  $SUBGRP_DIGIT $[n])$DEPLOY_DIR/$keyword"

    done

done

#コンテナホストとコンテナゲスト間の疎通ファイルの作成
#テンプレートファイルからの生成
#コピーしてから向き先変える
eval echo {$START_HOST_NO..$END_HOST_NO} | xargs -n1|nl|\
  while read n h;do

    echo "cd $WORKDIR && machinectl shell root@$REPLICA_NAME-$(printf $SUBGRP_DIGIT $[n]) /usr/bin/ln -sf /dev/null /etc/systemd/network/80-container-host0.network"

  done

#コンテナゲストのネットワークないしリゾルバサービスの停止、有効化、開始、状態確認コマンドの作成
for action in ${ACTION_LIST[@]} ;do

  eval echo {$START_HOST_NO..$END_HOST_NO} | xargs -n1|nl|\
    while read n h;do

      if [ $action == "status" ];then

        echo "cd $WORKDIR && machinectl shell root@$REPLICA_NAME-$(printf $SUBGRP_DIGIT $[n]) /bin/systemctl --no-pager $action systemd-networkd"
        echo "cd $WORKDIR && machinectl shell root@$REPLICA_NAME-$(printf $SUBGRP_DIGIT $[n]) /bin/systemctl --no-pager $action systemd-resolved"

      else

        echo "cd $WORKDIR && machinectl shell root@$REPLICA_NAME-$(printf $SUBGRP_DIGIT $[n]) /bin/systemctl $action systemd-networkd"
        echo "cd $WORKDIR && machinectl shell root@$REPLICA_NAME-$(printf $SUBGRP_DIGIT $[n]) /bin/systemctl $action systemd-resolved"

      fi
    done

done

#コンテナホストのsystemd-nspawnサービスの停止、有効化、開始、状態確認コマンドの作成
eval echo {$START_HOST_NO..$END_HOST_NO} | xargs -n1 | xargs -I{} echo systemctl stop systemd-nspawn@$REPLICA_NAME-{}.service
eval echo {$START_HOST_NO..$END_HOST_NO} | xargs -n1 | xargs -I{} echo systemctl enable systemd-nspawn@$REPLICA_NAME-{}.service
eval echo {$START_HOST_NO..$END_HOST_NO} | xargs -n1 | xargs -I{} echo systemctl start systemd-nspawn@$REPLICA_NAME-{}.service
eval echo {$START_HOST_NO..$END_HOST_NO} | xargs -n1 | xargs -I{} echo systemctl status --no-pager systemd-nspawn@$REPLICA_NAME-{}.service
