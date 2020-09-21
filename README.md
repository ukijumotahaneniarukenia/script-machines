# script-machines

コンテナ一括作成

```
$ bash create-main-setup-cmd.sh 1 5 ubuntu-18-04 | while read cmd;do echo $cmd;echo 'wait $!';done  >execute-main-setup-cmd.sh

$ chmod 755 execute-main-setup-cmd.sh

$ sudo bash execute-main-setup-cmd.sh
```


権限一括デフォルト変更

```
$ cat $HOME/script-machines/vir-ubuntu-18-04-template.tsv |awk -v CHMOD_F="chmod" -v CHMOD_D="chmod -R " -v CHOWN_F="chown" -v CHOWN_D="chown -R " -v FS='\t' '$1!="type" && $1!="report" && $5!="" && $5!=""{if($1=="directory"){print CHOWN_D,$5":"$6,$2;print CHMOD_D,$3,$2}else{print CHOWN_F,$5":"$6,$2;print CHMOD_F,$3,$2}}' >change-default-permission.sh
```

ファイル移動

```
$ sudo mv change-default-permission.sh /var/lib/machines/
```

作業ディレクトリに移動

```
cd /var/lib/machines
```


権限・所有者変更

```
$ chmod 700 change-default-permission.sh

$ chown -R root:root change-default-permission.sh 

$ ls -lh change-default-permission.sh
-rwx------ 1 root root 2.9M  9月 20 13:59 change-default-permission.sh
```


一括置換

CMD

```
$ ag /home/aine/script-machines/vir-ubuntu-18-04-template change-default-permission.sh -l | xargs perl -i -pe 's;/home/aine/script-machines/vir-ubuntu-18-04-template;/var/lib/machines/vir-ubuntu-18-04-001;g'
```


実行

CMD

```
$ time bash change-default-permission.sh 1>change-default-permission-stdout.log 2>change-default-permission-stderr.log
```

OUT

```

real	1m3.830s
user	0m39.465s
sys	0m28.379s
```

POST

```
$ ls -lh change-default-permission-*log
-rwxrwxrwx 1 root root 8.2K  9月 20 14:05 change-default-permission-stderr.log
-rwxrwxrwx 1 root root    0  9月 20 14:04 change-default-permission-stdout.log
```


POST

```
$ cat change-default-permission-stderr.log
chmod: '/var/lib/machines/vir-ubuntu-18-04-001/dev/fd' のパーミッションを変更しています: 許可されていない操作です
chown: '/var/lib/machines/vir-ubuntu-18-04-001/etc/ssl/certs/157753a5.0' を参照できません: そのようなファイルやディレクトリはありません
chmod: 参照先がないシンボリックリンク '/var/lib/machines/vir-ubuntu-18-04-001/etc/ssl/certs/157753a5.0' を操作できません
chown: '/var/lib/machines/vir-ubuntu-18-04-001/etc/ssl/certs/2c11d503.0' を参照できません: そのようなファイルやディレクトリはありません
chmod: 参照先がないシンボリックリンク '/var/lib/machines/vir-ubuntu-18-04-001/etc/ssl/certs/2c11d503.0' を操作できません
chown: '/var/lib/machines/vir-ubuntu-18-04-001/etc/ssl/certs/451b5485.0' を参照できません: そのようなファイルやディレクトリはありません
chmod: 参照先がないシンボリックリンク '/var/lib/machines/vir-ubuntu-18-04-001/etc/ssl/certs/451b5485.0' を操作できません
chown: '/var/lib/machines/vir-ubuntu-18-04-001/etc/ssl/certs/608a55ad.0' を参照できません: そのようなファイルやディレクトリはありません
chmod: 参照先がないシンボリックリンク '/var/lib/machines/vir-ubuntu-18-04-001/etc/ssl/certs/608a55ad.0' を操作できません
chown: '/var/lib/machines/vir-ubuntu-18-04-001/etc/ssl/certs/7992b8bb.0' を参照できません: そのようなファイルやディレクトリはありません
chmod: 参照先がないシンボリックリンク '/var/lib/machines/vir-ubuntu-18-04-001/etc/ssl/certs/7992b8bb.0' を操作できません
chown: '/var/lib/machines/vir-ubuntu-18-04-001/etc/ssl/certs/87229d21.0' を参照できません: そのようなファイルやディレクトリはありません
chmod: 参照先がないシンボリックリンク '/var/lib/machines/vir-ubuntu-18-04-001/etc/ssl/certs/87229d21.0' を操作できません
chown: '/var/lib/machines/vir-ubuntu-18-04-001/etc/ssl/certs/9168f543.0' を参照できません: そのようなファイルやディレクトリはありません
chmod: 参照先がないシンボリックリンク '/var/lib/machines/vir-ubuntu-18-04-001/etc/ssl/certs/9168f543.0' を操作できません
chown: '/var/lib/machines/vir-ubuntu-18-04-001/etc/ssl/certs/AddTrust_External_Root.pem' を参照できません: そのようなファイルやディレクトリはありません
chmod: 参照先がないシンボリックリンク '/var/lib/machines/vir-ubuntu-18-04-001/etc/ssl/certs/AddTrust_External_Root.pem' を操作できません
chown: '/var/lib/machines/vir-ubuntu-18-04-001/etc/ssl/certs/Certplus_Root_CA_G1.pem' を参照できません: そのようなファイルやディレクトリはありません
chmod: 参照先がないシンボリックリンク '/var/lib/machines/vir-ubuntu-18-04-001/etc/ssl/certs/Certplus_Root_CA_G1.pem' を操作できません
chown: '/var/lib/machines/vir-ubuntu-18-04-001/etc/ssl/certs/Certplus_Root_CA_G2.pem' を参照できません: そのようなファイルやディレクトリはありません
chmod: 参照先がないシンボリックリンク '/var/lib/machines/vir-ubuntu-18-04-001/etc/ssl/certs/Certplus_Root_CA_G2.pem' を操作できません
chown: '/var/lib/machines/vir-ubuntu-18-04-001/etc/ssl/certs/OpenTrust_Root_CA_G1.pem' を参照できません: そのようなファイルやディレクトリはありません
chmod: 参照先がないシンボリックリンク '/var/lib/machines/vir-ubuntu-18-04-001/etc/ssl/certs/OpenTrust_Root_CA_G1.pem' を操作できません
chown: '/var/lib/machines/vir-ubuntu-18-04-001/etc/ssl/certs/OpenTrust_Root_CA_G2.pem' を参照できません: そのようなファイルやディレクトリはありません
chmod: 参照先がないシンボリックリンク '/var/lib/machines/vir-ubuntu-18-04-001/etc/ssl/certs/OpenTrust_Root_CA_G2.pem' を操作できません
chown: '/var/lib/machines/vir-ubuntu-18-04-001/etc/ssl/certs/OpenTrust_Root_CA_G3.pem' を参照できません: そのようなファイルやディレクトリはありません
chmod: 参照先がないシンボリックリンク '/var/lib/machines/vir-ubuntu-18-04-001/etc/ssl/certs/OpenTrust_Root_CA_G3.pem' を操作できません
chown: '/var/lib/machines/vir-ubuntu-18-04-001/etc/ssl/certs/TÜRKTRUST_Elektronik_Sertifika_Hizmet_Sağlayıcısı_H5.pem' を参照できません: そのようなファイルやディレクトリはありません
chmod: 参照先がないシンボリックリンク '/var/lib/machines/vir-ubuntu-18-04-001/etc/ssl/certs/TÜRKTRUST_Elektronik_Sertifika_Hizmet_Sağlayıcısı_H5.pem' を操作できません
chown: '/var/lib/machines/vir-ubuntu-18-04-001/etc/ssl/certs/Visa_eCommerce_Root.pem' を参照できません: そのようなファイルやディレクトリはありません
chmod: 参照先がないシンボリックリンク '/var/lib/machines/vir-ubuntu-18-04-001/etc/ssl/certs/Visa_eCommerce_Root.pem' を操作できません
chown: '/var/lib/machines/vir-ubuntu-18-04-001/etc/ssl/certs/a760e1bd.0' を参照できません: そのようなファイルやディレクトリはありません
chmod: 参照先がないシンボリックリンク '/var/lib/machines/vir-ubuntu-18-04-001/etc/ssl/certs/a760e1bd.0' を操作できません
chown: '/var/lib/machines/vir-ubuntu-18-04-001/lib64/ld-linux-x86-64.so.2' を参照できません: そのようなファイルやディレクトリはありません
chmod: 参照先がないシンボリックリンク '/var/lib/machines/vir-ubuntu-18-04-001/lib64/ld-linux-x86-64.so.2' を操作できません
chown: '/var/lib/machines/vir-ubuntu-18-04-001/usr/lib/python3.6/sitecustomize.py' を参照できません: そのようなファイルやディレクトリはありません
chmod: 参照先がないシンボリックリンク '/var/lib/machines/vir-ubuntu-18-04-001/usr/lib/python3.6/sitecustomize.py' を操作できません
chown: '/var/lib/machines/vir-ubuntu-18-04-001/usr/share/doc/libxml2/NEWS.gz' を参照できません: そのようなファイルやディレクトリはありません
chmod: 参照先がないシンボリックリンク '/var/lib/machines/vir-ubuntu-18-04-001/usr/share/doc/libxml2/NEWS.gz' を操作できません
chown: '/var/lib/machines/vir-ubuntu-18-04-001/usr/share/doc/openssl/changelog.gz' を参照できません: そのようなファイルやディレクトリはありません
chmod: 参照先がないシンボリックリンク '/var/lib/machines/vir-ubuntu-18-04-001/usr/share/doc/openssl/changelog.gz' を操作できません
chown: '/var/lib/machines/vir-ubuntu-18-04-001/usr/share/man/fr/man1/editor.1.gz' を参照できません: そのようなファイルやディレクトリはありません
chmod: 参照先がないシンボリックリンク '/var/lib/machines/vir-ubuntu-18-04-001/usr/share/man/fr/man1/editor.1.gz' を操作できません
chown: '/var/lib/machines/vir-ubuntu-18-04-001/usr/share/man/it/man1/editor.1.gz' を参照できません: そのようなファイルやディレクトリはありません
chmod: 参照先がないシンボリックリンク '/var/lib/machines/vir-ubuntu-18-04-001/usr/share/man/it/man1/editor.1.gz' を操作できません
chown: '/var/lib/machines/vir-ubuntu-18-04-001/usr/share/man/ja/man1/editor.1.gz' を参照できません: そのようなファイルやディレクトリはありません
chmod: 参照先がないシンボリックリンク '/var/lib/machines/vir-ubuntu-18-04-001/usr/share/man/ja/man1/editor.1.gz' を操作できません
chown: '/var/lib/machines/vir-ubuntu-18-04-001/usr/share/man/pl/man1/editor.1.gz' を参照できません: そのようなファイルやディレクトリはありません
chmod: 参照先がないシンボリックリンク '/var/lib/machines/vir-ubuntu-18-04-001/usr/share/man/pl/man1/editor.1.gz' を操作できません
chown: '/var/lib/machines/vir-ubuntu-18-04-001/usr/share/man/ru/man1/editor.1.gz' を参照できません: そのようなファイルやディレクトリはありません
chmod: 参照先がないシンボリックリンク '/var/lib/machines/vir-ubuntu-18-04-001/usr/share/man/ru/man1/editor.1.gz' を操作できません
```
