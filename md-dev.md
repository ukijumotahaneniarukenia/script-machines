作業ディレクトリへの移動

CMD

```
$ cd /var/lib/machines
```

テンプレートからクローン

CMD

```
$ cp -a vir-ubuntu-18-04-template vir-ubuntu-18-04-001
```

コンテナ起動

CMD
```
$ machinectl start vir-ubuntu-18-04-001
```

コンテナ状態確認

CMD
```
$ machinectl list
```

OUT
```
MACHINE              CLASS     SERVICE        OS     VERSION ADDRESSES
vir-ubuntu-18-04-001 container systemd-nspawn ubuntu 18.04   -        

1 machines listed.
```

rootユーザーのパスワード設定

CMD

```
machinectl shell root@vir-ubuntu-18-04-001
```

EXE
```
$ machinectl shell root@vir-ubuntu-18-04-001
```

OUT

```
root@aine-MS-7B98:~# passwd
Enter new UNIX password: 
Retype new UNIX password: 
passwd: password updated successfully
```

aineユーザーの作成

CMD


```
groupadd -g 1000 aine
useradd -m -g aine -u 1000 aine
chsh -s /bin/bash aine
echo 'aine:aine_pwd' | chpasswd
echo 'aine ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
```

コンテナ停止

CMD
```
$ machinectl terminate vir-ubuntu-18-04-001
```

コンテナ状態確認


CMD
```
$ machinectl list
```

OUT
```
No machines.
```

ブート起動

CMD

```
$ systemd-nspawn -b -D /var/lib/machines/vir-ubuntu-18-04-001
```


OUT

```
Spawning container vir-ubuntu-18-04-001 on /var/lib/machines/vir-ubuntu-18-04-001.
Press ^] three times within 1s to kill container.
systemd 237 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 +IDN -PCRE2 default-hierarchy=hybrid)
Detected virtualization systemd-nspawn.
Detected architecture x86-64.

Welcome to Ubuntu 18.04 LTS!

Set hostname to <aine-MS-7B98>.
File /lib/systemd/system/systemd-journald.service:36 configures an IP firewall (IPAddressDeny=any), but the local system does not support BPF/cgroup based firewalling.
Proceeding WITHOUT firewalling in effect! (This warning is only shown for the first loaded unit using IP firewalling.)
[  OK  ] Started Forward Password Requests to Wall Directory Watch.
[  OK  ] Started Dispatch Password Requests to Console Directory Watch.
[  OK  ] Reached target Local Encrypted Volumes.
[  OK  ] Reached target Swap.
[  OK  ] Reached target Paths.
[  OK  ] Created slice System Slice.
[  OK  ] Listening on /dev/initctl Compatibility Named Pipe.
[  OK  ] Listening on Journal Socket.
         Mounting FUSE Control File System...
[  OK  ] Listening on Journal Socket (/dev/log).
         Mounting Huge Pages File System...
[  OK  ] Created slice User and Session Slice.
[  OK  ] Reached target Slices.
         Starting Set the console keyboard layout...
[  OK  ] Listening on Syslog Socket.
         Starting Journal Service...
[  OK  ] Reached target Remote File Systems.
sys-fs-fuse-connections.mount: Mount process exited, code=exited status=1
sys-fs-fuse-connections.mount: Failed with result 'exit-code'.
[FAILED] Failed to mount FUSE Control File System.
See 'systemctl status sys-fs-fuse-connections.mount' for details.
dev-hugepages.mount: Mount process exited, code=exited status=1
dev-hugepages.mount: Failed with result 'exit-code'.
[FAILED] Failed to mount Huge Pages File System.
See 'systemctl status dev-hugepages.mount' for details.
[  OK  ] Started Journal Service.
         Starting Flush Journal to Persistent Storage...
[  OK  ] Started Set the console keyboard layout.
[  OK  ] Reached target Local File Systems (Pre).
[  OK  ] Reached target Local File Systems.
         Starting Set console font and keymap...
[  OK  ] Started Set console font and keymap.
[  OK  ] Started Flush Journal to Persistent Storage.
         Starting Create Volatile Files and Directories...
[  OK  ] Started Create Volatile Files and Directories.
         Starting Update UTMP about System Boot/Shutdown...
         Starting Network Name Resolution...
[  OK  ] Reached target System Time Synchronized.
[  OK  ] Started Update UTMP about System Boot/Shutdown.
[  OK  ] Reached target System Initialization.
[  OK  ] Started Daily Cleanup of Temporary Directories.
[  OK  ] Started Discard unused blocks once a week.
[  OK  ] Started Message of the Day.
[  OK  ] Started Daily apt download activities.
[  OK  ] Listening on D-Bus System Message Bus Socket.
[  OK  ] Reached target Sockets.
[  OK  ] Reached target Basic System.
[  OK  ] Started D-Bus System Message Bus.
         Starting System Logging Service...
[  OK  ] Started Regular background program processing daemon.
         Starting Login Service...
[  OK  ] Started Daily apt upgrade and clean activities.
[  OK  ] Reached target Timers.
         Starting Permit User Sessions...
         Starting Dispatcher daemon for systemd-networkd...
[  OK  ] Started System Logging Service.
[  OK  ] Started Permit User Sessions.
[  OK  ] Started Console Getty.
[  OK  ] Created slice system-getty.slice.
[  OK  ] Reached target Login Prompts.
[  OK  ] Started Login Service.
[  OK  ] Started Network Name Resolution.
[  OK  ] Reached target Host and Network Name Lookups.
[  OK  ] Started Dispatcher daemon for systemd-networkd.
[  OK  ] Reached target Multi-User System.
[  OK  ] Reached target Graphical Interface.
         Starting Update UTMP about System Runlevel Changes...
[  OK  ] Started Update UTMP about System Runlevel Changes.

Ubuntu 18.04 LTS aine-MS-7B98 console

aine-MS-7B98 login: aine
Password: 
Welcome to Ubuntu 18.04 LTS (GNU/Linux 5.4.0-47-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

The programs included with the Ubuntu system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
applicable law.


The programs included with the Ubuntu system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
applicable law.


```

POST

```
aine@aine-MS-7B98:~$ whoami
aine
aine@aine-MS-7B98:~$ id
uid=1000(aine) gid=1000(aine) groups=1000(aine)
aine@aine-MS-7B98:~$ ll
total 20
drwxr-xr-x 2 106628072 106628072 4096 Sep 20 13:26 ./
drwxr-xr-x 3 106627072 106627072 4096 Sep 20 13:26 ../
-rw-r--r-- 1 106628072 106628072  220 Apr  5  2018 .bash_logout
-rw-r--r-- 1 106628072 106628072 3771 Apr  5  2018 .bashrc
-rw-r--r-- 1 106628072 106628072  807 Apr  5  2018 .profile
```


権限変更を実行

一度ブートすると、権限等がおかしくなるので、一度デフォルトに戻す

- https://github.com/ukijumotahaneniarukenia/script-machines/blob/master/README.md

```
time bash change-default-permission.sh 1>change-default-permission-stdout.log 2>change-default-permission-stderr.log
```

再度ブートログイン

いろいろでるので、治すかどうか（一旦なおさず問題出たら治す）

CMD

```
$ systemd-nspawn -b -D /var/lib/machines/vir-ubuntu-18-04-001
```

OUT

```
Spawning container vir-ubuntu-18-04-001 on /var/lib/machines/vir-ubuntu-18-04-001.
Press ^] three times within 1s to kill container.
systemd 237 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 +IDN -PCRE2 default-hierarchy=hybrid)
Detected virtualization systemd-nspawn.
Detected architecture x86-64.

Welcome to Ubuntu 18.04 LTS!

Set hostname to <aine-MS-7B98>.
File /lib/systemd/system/systemd-journald.service:36 configures an IP firewall (IPAddressDeny=any), but the local system does not support BPF/cgroup based firewalling.
Proceeding WITHOUT firewalling in effect! (This warning is only shown for the first loaded unit using IP firewalling.)
Configuration file /lib/systemd/system/systemd-udevd.service is marked executable. Please remove executable permission bits. Proceeding anyway.
Configuration file /lib/systemd/system/systemd-udevd.service is marked world-writable. Please remove world writability permission bits. Proceeding anyway.
Configuration file /lib/systemd/system/systemd-random-seed.service is marked executable. Please remove executable permission bits. Proceeding anyway.
Configuration file /lib/systemd/system/systemd-random-seed.service is marked world-writable. Please remove world writability permission bits. Proceeding anyway.
Configuration file /lib/systemd/system/systemd-tmpfiles-clean.timer is marked executable. Please remove executable permission bits. Proceeding anyway.
Configuration file /lib/systemd/system/systemd-tmpfiles-clean.timer is marked world-writable. Please remove world writability permission bits. Proceeding anyway.
Configuration file /lib/systemd/system/multi-user.target is marked executable. Please remove executable permission bits. Proceeding anyway.
Configuration file /lib/systemd/system/multi-user.target is marked world-writable. Please remove world writability permission bits. Proceeding anyway.
Configuration file /lib/systemd/system/graphical.target is marked executable. Please remove executable permission bits. Proceeding anyway.
Configuration file /lib/systemd/system/graphical.target is marked world-writable. Please remove world writability permission bits. Proceeding anyway.
Configuration file /lib/systemd/system/rescue.target is marked executable. Please remove executable permission bits. Proceeding anyway.
Configuration file /lib/systemd/system/rescue.target is marked world-writable. Please remove world writability permission bits. Proceeding anyway.
Configuration file /lib/systemd/system/dbus.socket is marked executable. Please remove executable permission bits. Proceeding anyway.
Configuration file /lib/systemd/system/dbus.socket is marked world-writable. Please remove world writability permission bits. Proceeding anyway.
Configuration file /lib/systemd/system/getty.target is marked executable. Please remove executable permission bits. Proceeding anyway.
Configuration file /lib/systemd/system/getty.target is marked world-writable. Please remove world writability permission bits. Proceeding anyway.
Configuration file /lib/systemd/system/rc-local.service is marked executable. Please remove executable permission bits. Proceeding anyway.
Configuration file /lib/systemd/system/rc-local.service is marked world-writable. Please remove world writability permission bits. Proceeding anyway.
Configuration file /lib/systemd/system/getty-static.service is marked executable. Please remove executable permission bits. Proceeding anyway.
Configuration file /lib/systemd/system/getty-static.service is marked world-writable. Please remove world writability permission bits. Proceeding anyway.
Configuration file /lib/systemd/system/dbus.service is marked executable. Please remove executable permission bits. Proceeding anyway.
Configuration file /lib/systemd/system/dbus.service is marked world-writable. Please remove world writability permission bits. Proceeding anyway.
Configuration file /lib/systemd/system/sys-kernel-debug.mount is marked executable. Please remove executable permission bits. Proceeding anyway.
Configuration file /lib/systemd/system/sys-kernel-debug.mount is marked world-writable. Please remove world writability permission bits. Proceeding anyway.
Configuration file /lib/systemd/system/sys-kernel-config.mount is marked executable. Please remove executable permission bits. Proceeding anyway.
Configuration file /lib/systemd/system/sys-kernel-config.mount is marked world-writable. Please remove world writability permission bits. Proceeding anyway.
Configuration file /lib/systemd/system/sys-fs-fuse-connections.mount is marked executable. Please remove executable permission bits. Proceeding anyway.
Configuration file /lib/systemd/system/sys-fs-fuse-connections.mount is marked world-writable. Please remove world writability permission bits. Proceeding anyway.
Configuration file /lib/systemd/system/proc-sys-fs-binfmt_misc.automount is marked executable. Please remove executable permission bits. Proceeding anyway.
Configuration file /lib/systemd/system/proc-sys-fs-binfmt_misc.automount is marked world-writable. Please remove world writability permission bits. Proceeding anyway.
Configuration file /lib/systemd/system/kmod-static-nodes.service is marked executable. Please remove executable permission bits. Proceeding anyway.
Configuration file /lib/systemd/system/kmod-static-nodes.service is marked world-writable. Please remove world writability permission bits. Proceeding anyway.
Configuration file /lib/systemd/system/dev-mqueue.mount is marked executable. Please remove executable permission bits. Proceeding anyway.
Configuration file /lib/systemd/system/dev-mqueue.mount is marked world-writable. Please remove world writability permission bits. Proceeding anyway.
Configuration file /lib/systemd/system/dev-hugepages.mount is marked executable. Please remove executable permission bits. Proceeding anyway.
Configuration file /lib/systemd/system/dev-hugepages.mount is marked world-writable. Please remove world writability permission bits. Proceeding anyway.
Configuration file /lib/systemd/system/cryptsetup.target is marked executable. Please remove executable permission bits. Proceeding anyway.
Configuration file /lib/systemd/system/cryptsetup.target is marked world-writable. Please remove world writability permission bits. Proceeding anyway.
[  OK  ] Reached target Swap.
[  OK  ] Created slice System Slice.
[  OK  ] Listening on Syslog Socket.
[  OK  ] Listening on /dev/initctl Compatibility Named Pipe.
[  OK  ] Listening on Journal Socket.
         Starting Set the console keyboard layout...
[  OK  ] Listening on Journal Socket (/dev/log).
         Mounting Huge Pages File System...
[  OK  ] Created slice User and Session Slice.
[  OK  ] Started Dispatch Password Requests to Console Directory Watch.
         Mounting FUSE Control File System...
[  OK  ] Reached target Slices.
         Starting Journal Service...
[  OK  ] Reached target Remote File Systems.
[  OK  ] Started Forward Password Requests to Wall Directory Watch.
[  OK  ] Reached target Paths.
[  OK  ] Reached target Local Encrypted Volumes.
[  OK  ] Mounted Huge Pages File System.
[  OK  ] Mounted FUSE Control File System.
[  OK  ] Started Journal Service.
         Starting Flush Journal to Persistent Storage...
[  OK  ] Started Set the console keyboard layout.
[  OK  ] Reached target Local File Systems (Pre).
[  OK  ] Reached target Local File Systems.
         Starting Set console font and keymap...
[  OK  ] Started Set console font and keymap.
[  OK  ] Started Flush Journal to Persistent Storage.
         Starting Create Volatile Files and Directories...
[  OK  ] Started Create Volatile Files and Directories.
         Starting Network Name Resolution...
[  OK  ] Reached target System Time Synchronized.
         Starting Update UTMP about System Boot/Shutdown...
[  OK  ] Started Update UTMP about System Boot/Shutdown.
[  OK  ] Reached target System Initialization.
[  OK  ] Started Daily apt download activities.
[  OK  ] Started Discard unused blocks once a week.
[  OK  ] Listening on D-Bus System Message Bus Socket.
[  OK  ] Reached target Sockets.
[  OK  ] Reached target Basic System.
         Starting Login Service...
         Starting Dispatcher daemon for systemd-networkd...
[  OK  ] Started Regular background program processing daemon.
[  OK  ] Started Daily apt upgrade and clean activities.
[  OK  ] Started D-Bus System Message Bus.
[  OK  ] Started Message of the Day.
         Starting Permit User Sessions...
         Starting System Logging Service...
[  OK  ] Started Daily Cleanup of Temporary Directories.
[  OK  ] Reached target Timers.
[  OK  ] Started Login Service.
[  OK  ] Started Permit User Sessions.
[  OK  ] Started Console Getty.
[  OK  ] Created slice system-getty.slice.
[  OK  ] Reached target Login Prompts.
[  OK  ] Started System Logging Service.
[  OK  ] Started Network Name Resolution.
[  OK  ] Reached target Host and Network Name Lookups.
[  OK  ] Started Dispatcher daemon for systemd-networkd.
[  OK  ] Reached target Multi-User System.
[  OK  ] Reached target Graphical Interface.
         Starting Update UTMP about System Runlevel Changes...
[  OK  ] Started Update UTMP about System Runlevel Changes.

Ubuntu 18.04 LTS aine-MS-7B98 console

aine-MS-7B98 login: 

```


一般ユーザーディレクトリの権限再整備

PRE

```
aine@aine-MS-7B98:/home$ su root
Password: 
root@aine-MS-7B98:/home# ll
total 12
drwxr-xr-x  3 root      root      4096 Sep 20 13:26 ./
drwxr-xr-x 21 106627072 106627072 4096 Aug 15 02:49 ../
drwxr-xr-x  2 root      root      4096 Sep 20 13:26 aine/
```

CMD

```
root@aine-MS-7B98:/home# chown -R aine:aine /home/aine
```

POST

```
root@aine-MS-7B98:/home# ll
total 12
drwxr-xr-x  3 root      root      4096 Sep 20 13:26 ./
drwxr-xr-x 21 106627072 106627072 4096 Aug 15 02:49 ../
drwxr-xr-x  2 aine      aine      4096 Sep 20 13:26 aine/
```

sudoコマンドの権限整備


PRE
```
root@aine-MS-7B98:/home/aine# ll /usr/bin/sudo
-rwxrwxrwx 1 root root 149080 Jan 18  2018 /usr/bin/sudo*
```

CMD

```
root@aine-MS-7B98:/home/aine# chmod 4755 /usr/bin/sudo
```

POST
```
root@aine-MS-7B98:/home/aine# ll /usr/bin/sudo
-rwsr-xr-x 1 root root 149080 Jan 18  2018 /usr/bin/sudo*
```

安心安全にunko

CMD

```
aine@aine-MS-7B98:~$ sudo echo unko
unko
```

firefoxをインストール

```
sudo apt install firefox
```


X転送許可

PRE
```
aine@aine-MS-7B98:~$ env
LS_COLORS=rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:
LESSCLOSE=/usr/bin/lesspipe %s %s
INVOCATION_ID=e34e1401a75c4079842e17f3c1222e50
XDG_SESSION_ID=142
HUSHLOGIN=FALSE
USER=aine
PWD=/home/aine
HOME=/home/aine
JOURNAL_STREAM=9:2257322
MAIL=/var/mail/aine
SHELL=/bin/bash
TERM=xterm-256color
SHLVL=1
LOGNAME=aine
XDG_RUNTIME_DIR=/run/user/1000
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games
LESSOPEN=| /usr/bin/lesspipe %s
_=/usr/bin/env
OLDPWD=/home
```

CMD

```
export DISPLAY=:0.0
```

EXE

```
aine@aine-MS-7B98:~$ export DISPLAY=:0.0
```

POST

```
aine@aine-MS-7B98:~$ env
LS_COLORS=rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:
LESSCLOSE=/usr/bin/lesspipe %s %s
DISPLAY=:0.0
OLDPWD=/home
INVOCATION_ID=e34e1401a75c4079842e17f3c1222e50
XDG_SESSION_ID=142
HUSHLOGIN=FALSE
USER=aine
PWD=/home/aine
HOME=/home/aine
JOURNAL_STREAM=9:2257322
MAIL=/var/mail/aine
SHELL=/bin/bash
TERM=xterm-256color
SHLVL=1
LOGNAME=aine
XDG_RUNTIME_DIR=/run/user/1000
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games
LESSOPEN=| /usr/bin/lesspipe %s
_=/usr/bin/env
```


起動

PRE

```
aine@aine-MS-7B98:~$ which firefox
/usr/bin/firefox
```

CMD

```
firefox
```

EXE
```
aine@aine-MS-7B98:~$ firefox
```

OUT

```
Gtk-Message: 14:25:51.877: Failed to load module "canberra-gtk-module"
Gtk-Message: 14:25:51.878: Failed to load module "canberra-gtk-module"

(firefox:1669): LIBDBUSMENU-GLIB-WARNING **: 14:25:52.511: Unable to get session bus: Failed to execute child process ?dbus-launch? (No such file or directory)
Gtk-Message: 14:25:52.512: Failed to load module "canberra-gtk-module"
Gtk-Message: 14:25:52.519: Failed to load module "canberra-gtk-module"
Gtk-Message: 14:25:52.841: Failed to load module "canberra-gtk-module"
Gtk-Message: 14:25:52.842: Failed to load module "canberra-gtk-module"
Gtk-Message: 14:25:53.564: Failed to load module "canberra-gtk-module"
Gtk-Message: 14:25:53.565: Failed to load module "canberra-gtk-module"
Gtk-Message: 14:26:09.588: Failed to load module "canberra-gtk-module"
Gtk-Message: 14:26:09.589: Failed to load module "canberra-gtk-module"

(firefox:1669): Gtk-WARNING **: 14:26:11.649: Error loading theme icon 'dialog-question' for stock: Icon 'dialog-question' not present in theme Yaru
```
