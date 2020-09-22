# script-machines

コンテナホストとコンテナゲストで共有ディレクトリの作成

```
$ echo {001..005} | xargs -n1 | xargs -I{} mkdir -p /home/aine/Downloads-for-systemd_nspawn-container/ubuntu-18-04-{}
```

コンテナ削除

単一実行

```
$ su root

$ systemctl status --no-pager systemd-nspawn@vir-ubuntu-18-04-001

$ systemctl stop systemd-nspawn@vir-ubuntu-18-04-001

$ rm -rf /var/lib/machines/vir-ubuntu-18-04-001
```

一括実行

```
$ su root

$ cd /var/lib/machines

$ systemctl status --no-pager systemd-nspawn@vir-ubuntu-18-04-*

$ systemctl stop systemd-nspawn@vir-ubuntu-18-04-*

$ ls /var/lib/machines/vir-ubuntu-18-04-* | grep -v template | xargs rm -rf
```

コンテナ作成

コンテナ作成後はコンテナホストを再起動する

単一作成コマンドの作成

```
$ cd $HOME

$ git clone https://github.com/ukijumotahaneniarukenia/script-machines.git

$ cd $HOME/script-machines

$ echo {001..005} | xargs -n1 | while read nnn;do bash create-main-setup-cmd.sh $nnn $nnn ubuntu-18-04 | while read cmd;do echo $cmd;echo 'wait $!';echo 'sleep 3';done >execute-main-setup-cmd-vir-ubuntu-18-04-$nnn.sh;chmod 755 execute-main-setup-cmd-vir-ubuntu-18-04-$nnn.sh;done
```

単一実行

```
$ time sudo bash execute-main-setup-cmd-vir-ubuntu-18-04-001.sh

real	1m38.055s
user	0m0.217s
sys	0m0.448s
```

一括作成コマンドの作成

```
$ cd $HOME

$ git clone https://github.com/ukijumotahaneniarukenia/script-machines.git

$ cd $HOME/script-machines

$ bash create-main-setup-cmd.sh 1 5 ubuntu-18-04 | while read cmd;do echo $cmd;echo 'wait $!';echo 'sleep 3';done  >execute-main-setup-cmd.sh

$ chmod 755 execute-main-setup-cmd.sh
```

一括実行

```
$ time sudo bash execute-main-setup-cmd.sh

real	0m20.181s
user	0m0.992s
sys	0m3.393s
```

コンテナ作成後、コンテナホストを再起動

```
$ reboot
```

コンテナ環境整備

単一整備コマンドの作成

```
$ echo {001..005} | xargs -n1 | while read nnn;do bash create-post-setup-cmd.sh $nnn $nnn ubuntu-18-04 | while read cmd;do echo $cmd;echo 'wait $!';echo 'sleep 3';done >execute-post-setup-cmd-vir-ubuntu-18-04-$nnn.sh;chmod 755 execute-post-setup-cmd-vir-ubuntu-18-04-$nnn.sh;done
```

単一実行

```
$ time sudo bash execute-post-setup-cmd-vir-ubuntu-18-04-001.sh

real	6m9.254s
user	0m0.390s
sys	0m0.442s
```

一括整備コマンドの作成

```
$ bash create-post-setup-cmd.sh 1 5 ubuntu-18-04 | while read cmd;do echo $cmd;echo 'wait $!';echo 'sleep 3';done  >execute-post-setup-cmd.sh

$ chmod 755 execute-post-setup-cmd.sh
```

一括実行

```
$ time sudo bash execute-post-setup-cmd.sh

real	14m0.725s
user	0m1.116s
sys	0m1.503s
```

コンテナブート起動

単一整備コマンドの作成

```
$ echo {001..005} | xargs -n1 | while read nnn;do cat execute-boot-setup-cmd.sh | grep vir-ubuntu-18-04-$nnn| while read cmd;do echo $cmd;echo 'wait $!';echo 'sleep 3';done >execute-boot-setup-cmd-vir-ubuntu-18-04-$nnn.sh;chmod 755 execute-boot-setup-cmd-vir-ubuntu-18-04-$nnn.sh;done
```

単一実行

```
$ time sudo bash execute-boot-setup-cmd-vir-ubuntu-18-04-001.sh

real	1m4.807s
user	0m40.652s
sys	0m28.170s

real	1m8.980s
user	0m40.742s
sys	0m28.234s
```

一括整備コマンドの作成

```
$ bash create-boot-setup-cmd.sh 1 5 ubuntu-18-04 | while read cmd;do echo $cmd;echo 'wait $!';echo 'sleep 3';done  >execute-boot-setup-cmd.sh

$ chmod 755 execute-boot-setup-cmd.sh
```

一括実行

```
$ time sudo bash execute-boot-setup-cmd.sh
```

ブート起動

ユーザー名：aine

パスワード：aine_pwd

```
$ su root

$ cd /var/lib/machines

$ machinectl list --all

$ machinectl terminate vir-ubuntu-18-04-001

$ machinectl list --all

$ systemd-nspawn --bind=/home/aine/Downloads-for-systemd_nspawn-container/ubuntu-18-04-001:/home/aine/media -b -D /var/lib/machines/vir-ubuntu-18-04-001
```

コンテナログイン後、権限整備

```
$ su root

$ chown -R aine:aine /home/aine

$ chmod 4755 /usr/bin/sudo

$ source $HOME/.bashrc

$ Ctrl + D

$ sudo echo unko

$ source $HOME/.bashrc

$ sudo apt install -y firefox
```
