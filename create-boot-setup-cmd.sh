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
eval echo {$START_HOST_NO..$END_HOST_NO} | xargs -n1 | xargs -I@ echo "cd $DEPLOY_DIR && machinectl start $REPLICA_NAME-@"

#コンテナゲストプロセスの状態確認
echo 'machinectl list -all'

#デフォルトパーミッション設定コマンドの作成
eval echo {$START_HOST_NO..$END_HOST_NO} | xargs -n1 | \
	while read n;do
    printf "ag $DEPLOY_DIR/$SEED_NAME change-default-permission.sh -l | xargs perl -pe \x22s;$DEPLOY_DIR/$SEED_NAME;$DEPLOY_DIR/$REPLICA_NAME-%s;g\x22 > $DEPLOY_DIR/change-default-permission-$REPLICA_NAME-%s.sh\n" $(printf $SUBGRP_DIGIT $[n]) $(printf $SUBGRP_DIGIT $[n]);
	done

#デフォルトパーミッション設定コマンドの実行権限の付与
eval echo {$START_HOST_NO..$END_HOST_NO} | xargs -n1 | \
	while read n;do
    printf "cd $DEPLOY_DIR && chmod 755 change-default-permission-$REPLICA_NAME-%s.sh\n" $(printf $SUBGRP_DIGIT $[n]) ;
	done

#デフォルトパーミッション設定コマンドの実行コマンドの作成
eval echo {$START_HOST_NO..$END_HOST_NO} | xargs -n1 | xargs -I@ echo "cd $DEPLOY_DIR && time bash change-default-permission-$REPLICA_NAME-@.sh 1>change-default-permission-$REPLICA_NAME-@-stdout.log 2>change-default-permission-$REPLICA_NAME-@-stderr.log "
