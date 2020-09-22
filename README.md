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

一度コンテナゲストをブート起動すると、コンテナホストからのmachinectlでの制御はできなくなり（shellサブコマンドの操作）、コンテナ環境内のネットワークが無効になるので、コンテナゲストファイルの洗い替え等からやり直すオペレーションが発生することが確認できた


GUI起動できるがブリッチ接続できている（他コンテナゲストへのpingは通った）がipの表示がコンテナホストのものになっている（コンテナホストの環境変数を持ってくればうまくいけそうな予感）

起動パタン１

```
$ systemd-nspawn -b -D /var/lib/machines/vir-ubuntu-18-04-002
```

ログイン後以下の環境変数を手動設定

だいぶいけてない（）

```
export MACHINE_NAME=vir-ubuntu-18-04-002
export MACHINE_IP=$(cat systemd_nspawn-container-list.json | jq -r 'map(select(.machine=="vir-ubuntu-18-04-002"))[].addresses|split("\n")[0]')
```


起動パタン２

```
$ systemd-nspawn --capability=CAP_NET_ADMIN -b -D /var/lib/machines/vir-ubuntu-18-04-002
```

ログイン後以下の環境変数を手動設定

だいぶいけてない

```
export MACHINE_NAME=vir-ubuntu-18-04-002
export MACHINE_IP=$(cat systemd_nspawn-container-list.json | jq -r 'map(select(.machine=="vir-ubuntu-18-04-002"))[].addresses|split("\n")[0]')
```

起動パタン３（systemdがつかえないので、dockerと同じ振る舞いになる。systemdを使えるようにしたいので、これはNG。）

ブート起動しないなら環境変数をコンテナゲスト側に持ってこれた

IPはこれから引っ張る

```
$ cat systemd_nspawn-container-list.json | jq -r 'map(select(.machine=="vir-ubuntu-18-04-002"))[].addresses|split("\n")[0]'
192.168.1.211
```

```
$ systemd-nspawn --user=aine --setenv=MACHINE_NAME=vir-ubuntu-18-04-002 --setenv=MACHINE_IP=192.168.1.211 -D /var/lib/machines/vir-ubuntu-18-04-002
```

この起動パタンだとhostnameの方から影響がでるので、hostsファイルにhostnameコマンドの出力結果を追記

```
$ which sudo
/usr/bin/sudo

$ ll /usr/bin/sudo
-rwsr-xr-x 1 root root 146K  1月 18  2018 /usr/bin/sudo

$ hostname
vir-ubuntu-18-04-002

$ sudo echo unko
sudo: unable to resolve host vir-ubuntu-18-04-002: Resource temporarily unavailable
unko

$ sudo vi /etc/hosts

ホストファイルにhostnameの出力結果を追記
$ cat /etc/hosts
127.0.0.1	localhost vir-ubuntu-18-04-002
::1		localhost ip6-localhost ip6-loopback
ff02::1		ip6-allnodes
ff02::2		ip6-allrouters
```


GUI起動できないがブリッチ接続できている（他コンテナゲストへのpingは通った）

起動パタン１

```
$ systemd-nspawn --network-bridge=br0 -b -D /var/lib/machines/vir-ubuntu-18-04-002

```

起動パタン２

```
$ machinectl shell root@vir-ubuntu-18-04-002
```


コンテナホストでどのコンテナゲストがどのIPアドレスを使用しているか確認できる
```
$ machinectl list -o json --no-pager | jq '' >systemd_nspawn-container-list.json
$ cat systemd_nspawn-container-list.json
[
  {
    "machine": "vir-ubuntu-18-04-001",
    "class": "container",
    "service": "systemd-nspawn",
    "os": "ubuntu",
    "version": "18.04",
    "addresses": "192.168.1.210\nfe80::ec3e:dff:febc:4d55"
  },
  {
    "machine": "vir-ubuntu-18-04-002",
    "class": "container",
    "service": "systemd-nspawn",
    "os": "ubuntu",
    "version": "18.04",
    "addresses": "192.168.1.211\nfe80::18d7:6aff:fef7:799c"
  },
  {
    "machine": "vir-ubuntu-18-04-003",
    "class": "container",
    "service": "systemd-nspawn",
    "os": "ubuntu",
    "version": "18.04",
    "addresses": "192.168.1.212\nfe80::12:92ff:fe02:380e"
  },
  {
    "machine": "vir-ubuntu-18-04-004",
    "class": "container",
    "service": "systemd-nspawn",
    "os": "ubuntu",
    "version": "18.04",
    "addresses": "192.168.1.213\nfe80::c878:ecff:fe6b:f8cb"
  },
  {
    "machine": "vir-ubuntu-18-04-005",
    "class": "container",
    "service": "systemd-nspawn",
    "os": "ubuntu",
    "version": "18.04",
    "addresses": "192.168.1.214\nfe80::f0ad:efff:fec2:ddce"
  }
]
```


あとなぜかviへのリンクがうまくいっていなかったので、やさしくコンテナゲストで手動実行

```
$ sudo ln -fsr /usr/local/bin/vim /usr/bin/vi
```


レポジトリ寂しいので、以下をいい感じに追加

```
$ cat <<EOS >/etc/apt/sources.list
deb http://ftp.jaist.ac.jp/pub/Linux/ubuntu bionic main

deb http://jp.archive.ubuntu.com/ubuntu/ bionic main restricted

deb http://jp.archive.ubuntu.com/ubuntu/ bionic-updates main restricted

deb http://jp.archive.ubuntu.com/ubuntu/ bionic universe

deb http://jp.archive.ubuntu.com/ubuntu/ bionic-updates universe

deb http://jp.archive.ubuntu.com/ubuntu/ bionic multiverse

deb http://jp.archive.ubuntu.com/ubuntu/ bionic-updates multiverse

deb http://jp.archive.ubuntu.com/ubuntu/ bionic-backports main restricted universe multiverse

deb http://security.ubuntu.com/ubuntu bionic-security main restricted

deb http://security.ubuntu.com/ubuntu bionic-security universe

deb http://security.ubuntu.com/ubuntu bionic-security multiverse
EOS

$ sudo apt update
```
