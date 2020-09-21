# script-machines

コンテナ一括作成

```
$ bash create-main-setup-cmd.sh 1 5 ubuntu-18-04 | while read cmd;do echo $cmd;echo 'wait $!';done  >execute-main-setup-cmd.sh

$ chmod 755 execute-main-setup-cmd.sh

$ time sudo bash execute-main-setup-cmd.sh

real	0m20.181s
user	0m0.992s
sys	0m3.393s


$ bash create-post-setup-cmd.sh 1 5 ubuntu-18-04 | while read cmd;do echo $cmd;echo 'wait $!';done  >execute-post-setup-cmd.sh

$ chmod 755 execute-post-setup-cmd.sh

$ time sudo bash execute-post-setup-cmd.sh

$ bash create-boot-setup-cmd.sh 1 5 ubuntu-18-04 | while read cmd;do echo $cmd;echo 'wait $!';done  >execute-boot-setup-cmd.sh

$ chmod 755 execute-boot-setup-cmd.sh

$ time sudo bash execute-boot-setup-cmd.sh
```

一度コンテナゲストをブート起動すると、コンテナホストからのmachinectlでの制御はできなくなり、コンテナ環境内のネットワークが無効になるので、コンテナゲストファイルの洗い替え等からやり直すオペレーションが発生することが確認できた
