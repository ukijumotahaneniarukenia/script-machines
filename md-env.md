環境の作り込み

CMD

```
sed -i.bak 's@archive.ubuntu.com@ftp.jaist.ac.jp/pub/Linux@g' /etc/apt/sources.list
```

EXE

```
root@aine-MS-7B98:/usr/local/src/script-repo# sed -i.bak 's@archive.ubuntu.com@ftp.jaist.ac.jp/pub/Linux@g' /etc/apt/sources.list
```


CMD


```
apt update
```

EXE

```
root@aine-MS-7B98:/usr/local/src/script-repo# apt update
```


CMD

```
apt upgrade -y
```

EXE

```
root@aine-MS-7B98:/usr/local/src/script-repo# apt upgrade -y
```


CMD

```
bash ubuntu-18-04-install-dev-pkg.sh
```

EXE

```
root@aine-MS-7B98:/usr/local/src/script-repo# bash ubuntu-18-04-install-dev-pkg.sh
```

システムVIMのインストール

CMD

```
apt install -y autoconf automake gcc git make

apt update

cd /usr/local/src

rm -rf vim

git clone https://github.com/vim/vim.git

cd vim

./configure --with-features=huge  --with-x --enable-multibyte  --enable-gpm   --enable-cscope   --enable-fontset   --enable-fail-if-missing   --prefix=/usr/local

make -j12

make -j12 install

ln -fsr /usr/local/bin/vim /usr/bin/vi
```

ユーザー個別のVIM設定のインストール


CMD

```
bash ubuntu-18-04-install-vim-user.sh
```


CMD

```
root@aine-MS-7B98:/usr/local/src/script-repo# apt install -y curl
```

EXE

```
root@aine-MS-7B98:/usr/local/src/script-repo# bash ubuntu-18-04-install-vim_plug.sh

```

CMD

```
root@aine-MS-7B98:/usr/local/src/script-repo# bash ubuntu-00-00-config-dotfile-system.sh

```

CMD

```

root@aine-MS-7B98:/usr/local/src/script-repo# bash ubuntu-18-04-config-locale.sh

```

CMD

```
root@aine-MS-7B98:/usr/local/src/script-repo# bash ubuntu-00-00-config-env-system.sh

```

CMD

```
root@aine-MS-7B98:/usr/local/src/script-repo# bash ubuntu-18-04-config-font-RictyDiminished.sh

```


CMD

```
aine@aine-MS-7B98:/usr/local/src/script-repo$ source ~/.bashrc
```


日本語入力以外はOK
