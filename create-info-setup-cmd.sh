#!/usr/bin/env bash

WORK_DIR=$HOME/script-machines

ENV_DETERMINE_DIR=/usr/local/src

ENV_DETERMINE_FILE_NAME=systemd_nspawn-container-list.json

ENV_VARIABLE_FILE_NAME=/etc/environment

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

#コンテナゲストメタ情報ファイルの作成
machinectl list -o json --no-pager | jq '' >$WORK_DIR/$ENV_DETERMINE_FILE_NAME

#コンテナゲストメタ情報の配備
eval echo {$START_HOST_NO..$END_HOST_NO} | xargs -n1|nl|\
  while read n h;do

    echo -e "echo \x27export MACHINE_NAME=$REPLICA_NAME-$(printf  $SUBGRP_DIGIT $[n])\x27 >> $DEPLOY_DIR/$REPLICA_NAME-$(printf  $SUBGRP_DIGIT $[n])$ENV_VARIABLE_FILE_NAME"

    MACHINE_IP=$(cat $WORK_DIR/$ENV_DETERMINE_FILE_NAME | jq -r --arg MACHINE_NAME $REPLICA_NAME-$(printf  $SUBGRP_DIGIT $[n]) 'map(select(.machine==$MACHINE_NAME))[].addresses|split("\n")[0]')

    echo -e "echo \x27export MACHINE_IP=$MACHINE_IP\x27 >> $DEPLOY_DIR/$REPLICA_NAME-$(printf  $SUBGRP_DIGIT $[n])$ENV_VARIABLE_FILE_NAME"

    echo "cp $WORK_DIR/$ENV_DETERMINE_FILE_NAME $DEPLOY_DIR/$REPLICA_NAME-$(printf  $SUBGRP_DIGIT $[n])$ENV_DETERMINE_DIR/$ENV_DETERMINE_FILE_NAME"

  done
