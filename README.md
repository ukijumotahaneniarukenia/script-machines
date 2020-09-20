# script-machines


権限一括デフォルト変更

```
$ cat vir-ubuntu-18-04-template.tsv |awk -v CHMOD_F="chmod" -v CHMOD_D="chmod -R " -v CHOWN_F="chown" -v CHOWN_D="chown -R " -v FS='\t' '$1!="type" && $1!="report" && $5!="" && $5!=""{if($1=="directory"){print CHOWN_D,$5":"$6,$2;print CHMOD_D,$3,$2}else{print CHOWN_F,$5":"$6,$2;print CHMOD_F,$3,$2}}' >change-default-permission.sh
```


CMD

```
$ time sudo bash change-default-permission.sh 1>change-default-permission-stdout.log 2>change-default-permission-stderr.log

real	1m4.494s
user	0m40.551s
sys	0m27.486s
```

OUT

```
$ ls -lh change-default-permission*log
-rwxrwxrwx 1 root root 8.9K  9月 20 13:49 change-default-permission-stderr.log
-rwxrwxrwx 1 root root    0  9月 20 13:48 change-default-permission-stdout.log
```



