作業ディレクトリに移動

CMD

```
cd $HOME/script-machines
```


コマンドインストール

CMD

```
sudo apt install -y debootstrap

sudo apt install -y systemd-container
```


OSファイル群インストール

CMD

```
$ time sudo debootstrap --arch=amd64 bionic $HOME/script-machines/vir-ubuntu-18-04-template http://archive.ubuntu.com/ubuntu
```

OUT

```
I: Base system installed successfully.

real	5m4.908s
user	0m33.271s
sys	0m14.974s
```


POST

```
$ ls -lh $HOME/script-machines
合計 8.0K
-rw-rw-r--  1 aine aine   17  9月 20 11:42 README.md
drwxr-xr-x 21 root root 4.0K  9月 20 11:50 vir-ubuntu-18-04-template
```




初期状態の権限等をダンプ

CMD

```
$ filedump-jq $HOME/script-machines/vir-ubuntu-18-04-template >vir-ubuntu-18-04-template.tsv
```

POST

```
$ ls -lh vir-ubuntu-18-04-template.tsv
-rw-rw-r-- 1 aine aine 2.1M  9月 20 11:55 vir-ubuntu-18-04-template.tsv
```


テンプレートからクローン


CMD


```
$ sudo cp -a vir-ubuntu-18-04-template vir-ubuntu-18-04-001
```


OUT

```
$ ls -lh $HOME/script-machines
合計 2.1M
-rw-rw-r--  1 aine aine   17  9月 20 11:42 README.md
drwxr-xr-x 21 root root 4.0K  9月 20 11:50 vir-ubuntu-18-04-001
drwxr-xr-x 21 root root 4.0K  9月 20 11:50 vir-ubuntu-18-04-template
-rw-rw-r--  1 aine aine 2.1M  9月 20 11:55 vir-ubuntu-18-04-template.tsv
```

POST

ステップごとに権限周り確認

```
$ filedump-jq $HOME/script-machines/vir-ubuntu-18-04-001 >vir-ubuntu-18-04-001-step01.tsv


$ ls -lh vir-ubuntu-18-04*tsv
-rw-rw-r-- 1 aine aine 2.0M  9月 20 12:00 vir-ubuntu-18-04-001-step01.tsv
-rw-rw-r-- 1 aine aine 2.1M  9月 20 11:55 vir-ubuntu-18-04-template.tsv


$ filedump-jq /home/aine/script-machines/vir-ubuntu-18-04-001/usr/local/share >a

$ filedump-jq /home/aine/script-machines/vir-ubuntu-18-04-template/usr/local/share >b


ディレクトリ名の違いで1Mがぐらい差分でる
$ diff a b
2,4c2,4
< directory	/home/aine/script-machines/vir-ubuntu-18-04-001/usr/local/share								
< directory	/home/aine/script-machines/vir-ubuntu-18-04-001/usr/local/share/ca-certificates	0755	drwxr-xr-x	root	root	4.0K	2020-09-20T11:50:17		
< directory	/home/aine/script-machines/vir-ubuntu-18-04-001/usr/local/share/man	0755	drwxr-xr-x	root	root	4.0K	2020-09-20T11:49:46		
---
> directory	/home/aine/script-machines/vir-ubuntu-18-04-template/usr/local/share								
> directory	/home/aine/script-machines/vir-ubuntu-18-04-template/usr/local/share/ca-certificates	0755	drwxr-xr-x	root	root	4.0K	2020-09-20T11:50:17		
> directory	/home/aine/script-machines/vir-ubuntu-18-04-template/usr/local/share/man	0755	drwxr-xr-x	root	root	4.0K	2020-09-20T11:49:46		



一括置換して確認

$ ag vir-ubuntu-18-04-001 vir-ubuntu-18-04-001-step01.tsv -l | xargs perl -i -pe 's/vir-ubuntu-18-04-001/vir-ubuntu-18-04-template/'


$ ls -lh $HOME/script-machines
合計 4.1M
-rw-rw-r--  1 aine aine   17  9月 20 11:42 README.md
drwxr-xr-x 21 root root 4.0K  9月 20 11:50 vir-ubuntu-18-04-001
-rw-rw-r--  1 aine aine 2.1M  9月 20 12:07 vir-ubuntu-18-04-001-step01.tsv
drwxr-xr-x 21 root root 4.0K  9月 20 11:50 vir-ubuntu-18-04-template
-rw-rw-r--  1 aine aine 2.1M  9月 20 11:55 vir-ubuntu-18-04-template.tsv


結構ステップごとに差分でる
$ diff vir-ubuntu-18-04-001-step01.tsv vir-ubuntu-18-04-template.tsv
1366c1366
< directory	/home/aine/script-machines/vir-ubuntu-18-04-template/lib/x86_64-linux-gnu	0755	drwxr-xr-x	root	root	4.0K	2020-09-20T11:50:10		
---
> directory	/home/aine/script-machines/vir-ubuntu-18-04-template/lib/x86_64-linux-gnu	0755	drwxr-xr-x	root	root	12K	2020-09-20T11:50:10		
2312c2312
< directory	/home/aine/script-machines/vir-ubuntu-18-04-template/usr/lib/python3.6	0755	drwxr-xr-x	root	root	4.0K	2020-09-20T11:50:10		
---
> directory	/home/aine/script-machines/vir-ubuntu-18-04-template/usr/lib/python3.6	0755	drwxr-xr-x	root	root	12K	2020-09-20T11:50:10		
2712c2712
< directory	/home/aine/script-machines/vir-ubuntu-18-04-template/usr/lib/python3.6/encodings/__pycache__	0755	drwxr-xr-x	root	root	4.0K	2020-09-20T11:49:59		
---
> directory	/home/aine/script-machines/vir-ubuntu-18-04-template/usr/lib/python3.6/encodings/__pycache__	0755	drwxr-xr-x	root	root	12K	2020-09-20T11:49:59		
3502c3502
< directory	/home/aine/script-machines/vir-ubuntu-18-04-template/usr/lib/x86_64-linux-gnu/gconv	0755	drwxr-xr-x	root	root	12K	2020-09-20T11:49:50		
---
> directory	/home/aine/script-machines/vir-ubuntu-18-04-template/usr/lib/x86_64-linux-gnu/gconv	0755	drwxr-xr-x	root	root	36K	2020-09-20T11:49:50		
4984c4984
< directory	/home/aine/script-machines/vir-ubuntu-18-04-template/usr/share/bash-completion/completions	0755	drwxr-xr-x	root	root	4.0K	2020-09-20T11:50:14		
---
> directory	/home/aine/script-machines/vir-ubuntu-18-04-template/usr/share/bash-completion/completions	0755	drwxr-xr-x	root	root	12K	2020-09-20T11:50:14		
5654c5654
< directory	/home/aine/script-machines/vir-ubuntu-18-04-template/usr/share/doc	0755	drwxr-xr-x	root	root	4.0K	2020-09-20T11:50:15		
---
> directory	/home/aine/script-machines/vir-ubuntu-18-04-template/usr/share/doc	0755	drwxr-xr-x	root	root	12K	2020-09-20T11:50:15		
7018c7018
< directory	/home/aine/script-machines/vir-ubuntu-18-04-template/usr/share/i18n/locales	0755	drwxr-xr-x	root	root	12K	2020-09-20T11:50:11		
---
> directory	/home/aine/script-machines/vir-ubuntu-18-04-template/usr/share/i18n/locales	0755	drwxr-xr-x	root	root	16K	2020-09-20T11:50:11		

```

グラフィックに見ると便利

```
$ gitmerge-p4merge-bash vir-ubuntu-18-04-001-step01.tsv vir-ubuntu-18-04-template.tsv
```






