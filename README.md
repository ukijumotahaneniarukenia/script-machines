# script-machines

単一コンテナの削除

```
$ su root

$ systemctl status systemd-nspawn@vir-ubuntu-18-04-001

$ systemctl stop systemd-nspawn@vir-ubuntu-18-04-001

$ rm -rf /var/lib/machines/vir-ubuntu-18-04-001

```

コンテナホストとコンテナゲストで共有ディレクトリの作成

```
$ echo {001..005} | xargs -n1 | xargs -I{} mkdir -p /home/aine/Downloads-for-systed_nspawn-container/ubuntu-18-04-{}
```


コンテナ一括作成

```
$ cd $HOME

$ git clone https://github.com/ukijumotahaneniarukenia/script-machines.git

$ cd $HOME/script-machines

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

#一括boot（まれ）
$ bash create-boot-setup-cmd.sh 1 5 ubuntu-18-04 | while read cmd;do echo $cmd;echo 'wait $!';done  >execute-boot-setup-cmd.sh

$ chmod 755 execute-boot-setup-cmd.sh

$ time sudo bash execute-boot-setup-cmd.sh

#個別boot（よく）

$ echo {001..005} | xargs -n1 | while read nnn;do cat execute-boot-setup-cmd.sh | grep vir-ubuntu-18-04-$nnn| while read cmd;do echo $cmd;echo 'wait $!';done >execute-boot-setup-cmd-vir-ubuntu-18-04-$nnn.sh;chmod 755 execute-boot-setup-cmd-vir-ubuntu-18-04-$nnn.sh;done

#権限デフォ値一括設定の経過時間でほとんど
$ time sudo bash execute-boot-setup-cmd-vir-ubuntu-18-04-001.sh

real	1m4.807s
user	0m40.652s
sys	0m28.170s

real	1m8.980s
user	0m40.742s
sys	0m28.234s


#ブート起動

$ systemd-nspawn --bind=/home/aine/Downloads-for-systed_nspawn-container/ubuntu-18-04-002:/home/aine/media -b -D /var/lib/machines/vir-ubuntu-18-04-002

#ブート起動で権限整備

$ su root

$ cd /var/lib/machines

$ machinectl list --all

$ machinectl terminate vir-ubuntu-18-04-001

$ machinectl list --all

コンテナログイン後

$ chown -R aine:aine /home/aine

$ chmod 4755 /usr/bin/sudo

$ sudo echo unko

$ source $HOME/.bashrc

$ sudo apt install -y firefox
```
