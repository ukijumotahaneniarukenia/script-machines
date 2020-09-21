# script-machines

コンテナ一括作成

```
$ bash create-main-setup-cmd.sh 1 5 ubuntu-18-04 | while read cmd;do echo $cmd;echo 'wait $!';done  >execute-main-setup-cmd.sh

$ chmod 755 execute-main-setup-cmd.sh

$ time sudo bash execute-main-setup-cmd.sh

real	0m20.181s
user	0m0.992s
sys	0m3.393s

$ reboot

$ bash create-post-setup-cmd.sh 1 5 ubuntu-18-04 | while read cmd;do echo $cmd;echo 'wait $!';done  >execute-post-setup-cmd.sh

$ chmod 755 execute-post-setup-cmd.sh

5つのコンテナで同じ規模感のスクリプト実行時にこの経過時間はdockerより早い気がする
$ time sudo bash execute-post-setup-cmd.sh

real	14m0.725s
user	0m1.116s
sys	0m1.503s

#一括boot
$ bash create-boot-setup-cmd.sh 1 5 ubuntu-18-04 | while read cmd;do echo $cmd;echo 'wait $!';done  >execute-boot-setup-cmd.sh

$ chmod 755 execute-boot-setup-cmd.sh

$ time sudo bash execute-boot-setup-cmd.sh

#個別boot
$ cat execute-boot-setup-cmd.sh | grep vir-ubuntu-18-04-001 | while read cmd;do echo $cmd;echo 'wait $!';done  >execute-boot-setup-cmd-vir-ubuntu-18-04-001.sh

$ chmod 755 execute-boot-setup-cmd-vir-ubuntu-18-04-001.sh

#権限デフォ値一括設定の経過時間でほとんど
$ time sudo bash execute-boot-setup-cmd-vir-ubuntu-18-04-001.sh

real	1m4.807s
user	0m40.652s
sys	0m28.170s

real	1m8.980s
user	0m40.742s
sys	0m28.234s
```

一度コンテナゲストをブート起動すると、コンテナホストからのmachinectlでの制御はできなくなり、コンテナ環境内のネットワークが無効になるので、コンテナゲストファイルの洗い替え等からやり直すオペレーションが発生することが確認できた


一度コンテナゲストをブート起動すると、ネットワークサービスが停止していることが確認できた。


machinectlで起動したあと、X転送を有効にするために以下の設定を実行ユーザー単位に即した値を設定してやればよさげ

XDG_RUNTIME_DIR環境変数の値とソケットファイルのマウント

現状は実行ユーザー単位に即した値ではなく、一般ユーザーでログインしてもルートユーザーのものとなっている

これを直せばいけるかも

- https://www.atmarkit.co.jp/fsecurity/rensai/lids03/lids01.html

```
aine@aine-MS-7B98:~$ systemctl --no-pager status systemd-networkd
● systemd-networkd.service - Network Service
   Loaded: loaded (/lib/systemd/system/systemd-networkd.service; enabled; vendor preset: enabled)
   Active: inactive (dead)
Condition: start condition failed at Mon 2020-09-21 14:56:00 JST; 2min 39s ago
           └─ ConditionCapability=CAP_NET_ADMIN was not met
     Docs: man:systemd-networkd.service(8)
     
     
     
     
XDG_RUNTIME_DIR=/run/user/1000
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games
LESSOPEN=| /usr/bin/lesspipe %s
_=/usr/bin/env
aine@aine-MS-7B98:~$ ll /run/user/1000
total 0
drwx------ 3 aine aine 60 Sep 21 14:56 ./
drwxr-xr-x 3 root root 60 Sep 21 14:56 ../
drwxr-xr-x 2 aine aine 80 Sep 21 14:56 systemd/
aine@aine-MS-7B98:~$ 
aine@aine-MS-7B98:~$ 
aine@aine-MS-7B98:~$ 
aine@aine-MS-7B98:~$ ll /run/user/1000/systemd/
total 0
drwxr-xr-x 2 aine aine 80 Sep 21 14:56 ./
drwx------ 3 aine aine 60 Sep 21 14:56 ../
srwxrwxr-x 1 aine aine  0 Sep 21 14:56 notify=
srwxrwxr-x 1 aine aine  0 Sep 21 14:56 private=
aine@aine-MS-7B98:~$ ll /run/user/1000/systemd/*
srwxrwxr-x 1 aine aine 0 Sep 21 14:56 /run/user/1000/systemd/notify=
srwxrwxr-x 1 aine aine 0 Sep 21 14:56 /run/user/1000/systemd/private=
```
