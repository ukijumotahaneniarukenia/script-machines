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

$ time sudo bash execute-boot-setup-cmd-vir-ubuntu-18-04-001.sh
```

一度コンテナゲストをブート起動すると、コンテナホストからのmachinectlでの制御はできなくなり、コンテナ環境内のネットワークが無効になるので、コンテナゲストファイルの洗い替え等からやり直すオペレーションが発生することが確認できた
