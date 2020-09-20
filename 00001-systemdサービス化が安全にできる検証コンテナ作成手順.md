作業ディレクトリに移動

CMD

```
cd /var/lib/machines
```

サービスの停止

CMD

```
systemctl stop systemd-nspawn@vir-ubuntu-18-04-001.service
```

サービスの状態確認

CMD

```
systemctl status systemd-nspawn@vir-ubuntu-18-04-001.service --no-pager
```


ファイル削除

CMD

```
rm -rf vir-ubuntu-18-04-001
```


テンプレートからクローン

CMD

```
cp -a vir-ubuntu-18-04-template vir-ubuntu-18-04-001
```


コンテナの起動

CMD

```
machinectl start vir-ubuntu-18-04-001
```


コンテナの状態確認

CMD

```
machinectl list
```


rootユーザーのパスワード設定


CMD

```
machinectl shell root@vir-ubuntu-18-04-001 /bin/bash -c 'echo "root:root_pwd"|chpasswd';
```


一般ユーザーの作成

CMD

```
machinectl shell root@vir-ubuntu-18-04-001 /usr/sbin/groupadd -g 1000 vir-aine


machinectl shell root@vir-ubuntu-18-04-001 /usr/sbin/useradd -m -g vir-aine -u 1000 vir-aine


machinectl shell root@vir-ubuntu-18-04-001 /usr/bin/chsh -s /bin/bash vir-aine


machinectl shell root@vir-ubuntu-18-04-001 /bin/bash -c 'echo "vir-aine:vir-aine_pwd"|chpasswd';


machinectl shell root@vir-ubuntu-18-04-001 /bin/bash -c 'echo "vir-aine ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers';
```



コンテナの停止

CMD

```
machinectl terminate vir-ubuntu-18-04-001
```

コンテナの状態確認

CMD

```
machinectl list
```


ブート起動

一般ユーザーでログインできるか確認

CMD

```
systemd-nspawn -b -D /var/lib/machines/vir-ubuntu-18-04-001
```


EXE
```
aine-MS-7B98 login: vir-aine
Password: vir-aine_pwd
```

POST

```
vir-aine@aine-MS-7B98:~$ whoami
vir-aine
vir-aine@aine-MS-7B98:~$ id
uid=1000(vir-aine) gid=1000(vir-aine) groups=1000(vir-aine)
```


権限整備

一度ブートすると、権限等がおかしくなるので、一度デフォルトに戻す

対象の枝番に置換

```
$ ag /var/lib/machines/vir-ubuntu-18-04-001 change-default-permission.sh -l | xargs perl -i -pe 's;/var/lib/machines/vir-ubuntu-18-04-001;/var/lib/machines/vir-ubuntu-18-04-002;g'
```

実行

```
time bash change-default-permission.sh 1>change-default-permission-stdout.log 2>change-default-permission-stderr.log
```


再ブート起動

一般ユーザーでログインできるか確認

CMD

```
systemd-nspawn -b -D /var/lib/machines/vir-ubuntu-18-04-001
```

EXE
```
aine-MS-7B98 login: vir-aine
Password: vir-aine_pwd
```

POST

```
vir-aine@aine-MS-7B98:~$ whoami
vir-aine
vir-aine@aine-MS-7B98:~$ id
uid=1000(vir-aine) gid=1000(vir-aine) groups=1000(vir-aine)
```

一般ユーザーからrootユーザーにスウィッチできるか確認

CMD

```
vir-aine@aine-MS-7B98:~$ su root
Password: 
root@aine-MS-7B98:/home/vir-aine# whoami
root
root@aine-MS-7B98:/home/vir-aine# id
uid=0(root) gid=0(root) groups=0(root)
```

権限再整備


PRE

```
root@aine-MS-7B98:/home# ll
total 12
drwxr-xr-x  3 root      root      4096 Sep 20 17:45 ./
drwxr-xr-x 21 106627072 106627072 4096 Aug 15 02:49 ../
drwxr-xr-x  2 root      root      4096 Sep 20 17:45 vir-aine/
```



CMD

```
chown -R vir-aine:vir-aine /home/vir-aine
```

POST

```
root@aine-MS-7B98:/home# ll
total 12
drwxr-xr-x  3 root      root      4096 Sep 20 17:45 ./
drwxr-xr-x 21 106627072 106627072 4096 Aug 15 02:49 ../
drwxr-xr-x  2 vir-aine  vir-aine  4096 Sep 20 17:45 vir-aine/
```

sudoコマンドの整備


PRE

```
root@aine-MS-7B98:/home# ll /usr/bin/sudo
-rwxrwxrwx 1 root root 149080 Jan 18  2018 /usr/bin/sudo*
```

CMD

```
chmod 4755 /usr/bin/sudo
```

EXE

```
root@aine-MS-7B98:/home# chmod 4755 /usr/bin/sudo
```

POST

```
root@aine-MS-7B98:/home# ll /usr/bin/sudo
-rwsr-xr-x 1 root root 149080 Jan 18  2018 /usr/bin/sudo*

vir-aine@aine-MS-7B98:~$ sudo echo unko
unko
```

Xアプリ起動確認


音は飛ばせないが、動画再生等はできる

インターネットにもつながる


CMD

```
export DISPLAY=:0.0

sudo apt install -y firefox

firefox
```


EXE

```
vir-aine@aine-MS-7B98:~$ export DISPLAY=:0.0

vir-aine@aine-MS-7B98:~$ sudo apt install -y firefox

vir-aine@aine-MS-7B98:~$ firefox
```
