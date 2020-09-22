cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-005 /usr/bin/sed -i.bak 's@archive.ubuntu.com@ftp.jaist.ac.jp/pub/Linux@g' /etc/apt/sources.list
wait $!
sleep 3
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-005 /usr/bin/apt update
wait $!
sleep 3
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-005 /usr/bin/apt install -y git curl unzip
wait $!
sleep 3
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-005 /bin/bash -c 'echo "deb http://ftp.jaist.ac.jp/pub/Linux/ubuntu bionic main" | tee -a /etc/apt/sources.list'
wait $!
sleep 3
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-005 /bin/bash -c 'echo "deb http://jp.archive.ubuntu.com/ubuntu/ bionic main restricted" | tee -a /etc/apt/sources.list'
wait $!
sleep 3
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-005 /bin/bash -c 'echo "deb http://jp.archive.ubuntu.com/ubuntu/ bionic-updates main restricted" | tee -a /etc/apt/sources.list'
wait $!
sleep 3
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-005 /bin/bash -c 'echo "deb http://jp.archive.ubuntu.com/ubuntu/ bionic universe" | tee -a /etc/apt/sources.list'
wait $!
sleep 3
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-005 /bin/bash -c 'echo "deb http://jp.archive.ubuntu.com/ubuntu/ bionic-updates universe" | tee -a /etc/apt/sources.list'
wait $!
sleep 3
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-005 /bin/bash -c 'echo "deb http://jp.archive.ubuntu.com/ubuntu/ bionic multiverse" | tee -a /etc/apt/sources.list'
wait $!
sleep 3
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-005 /bin/bash -c 'echo "deb http://jp.archive.ubuntu.com/ubuntu/ bionic-updates multiverse" | tee -a /etc/apt/sources.list'
wait $!
sleep 3
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-005 /bin/bash -c 'echo "deb http://jp.archive.ubuntu.com/ubuntu/ bionic-backports main restricted universe multiverse" | tee -a /etc/apt/sources.list'
wait $!
sleep 3
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-005 /bin/bash -c 'echo "deb http://security.ubuntu.com/ubuntu bionic-security main restricted" | tee -a /etc/apt/sources.list'
wait $!
sleep 3
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-005 /bin/bash -c 'echo "deb http://security.ubuntu.com/ubuntu bionic-security universe" | tee -a /etc/apt/sources.list'
wait $!
sleep 3
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-005 /bin/bash -c 'echo "deb http://security.ubuntu.com/ubuntu bionic-security multiverse" | tee -a /etc/apt/sources.list'
wait $!
sleep 3
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-005 /usr/bin/apt update
wait $!
sleep 3
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-005 /bin/bash -c 'cd /usr/local/src && git clone https://github.com/ukijumotahaneniarukenia/script-repo.git'
wait $!
sleep 3
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-005 /bin/bash -c 'cd /usr/local/src/script-repo && bash ubuntu-18-04-install-dev-pkg.sh'
wait $!
sleep 3
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-005 /usr/bin/apt install -y autoconf automake gcc git make
wait $!
sleep 3
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-005 /bin/bash -c 'cd /usr/local/src && rm -rf vim && git clone https://github.com/vim/vim.git'
wait $!
sleep 3
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-005 /bin/bash -c 'cd /usr/local/src/vim && ./configure --with-features=huge --enable-multibyte --enable-gpm --enable-cscope --enable-fontset --enable-fail-if-missing --prefix=/usr/local'
wait $!
sleep 3
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-005 /bin/bash -c 'cd /usr/local/src/vim && make -j12'
wait $!
sleep 3
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-005 /bin/bash -c 'cd /usr/local/src/vim && make -j12 install'
wait $!
sleep 3
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-005 $(/usr/bin/which ln) -fsr /usr/local/bin/vim /usr/bin/vi
wait $!
sleep 3
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-005 /usr/bin/which vim
wait $!
sleep 3
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-005 /usr/bin/which vi
wait $!
sleep 3
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-005 /bin/bash -c 'cd /usr/local/src/script-repo && bash ubuntu-18-04-install-vim-user.sh'
wait $!
sleep 3
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-005 /bin/bash -c 'cd /usr/local/src/script-repo && bash ubuntu-18-04-install-vim_plug.sh'
wait $!
sleep 3
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-005 /bin/bash -c 'cd /usr/local/src/script-repo && bash ubuntu-00-00-config-dotfile-system.sh'
wait $!
sleep 3
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-005 /bin/bash -c 'cd /usr/local/src/script-repo && bash ubuntu-18-04-config-locale.sh'
wait $!
sleep 3
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-005 /bin/bash -c 'cd /usr/local/src/script-repo && bash ubuntu-00-00-config-env-system.sh'
wait $!
sleep 3
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-005 /bin/bash -c 'cd /usr/local/src/script-repo && bash ubuntu-18-04-config-font-RictyDiminished.sh'
wait $!
sleep 3
cd /var/lib/machines && machinectl shell aine@vir-ubuntu-18-04-005 /bin/bash -c 'cd /usr/local/src/script-repo && bash ubuntu-18-04-install-vim-user.sh'
wait $!
sleep 3
cd /var/lib/machines && machinectl shell aine@vir-ubuntu-18-04-005 /bin/bash -c 'cd /usr/local/src/script-repo && bash ubuntu-18-04-install-vim_plug.sh'
wait $!
sleep 3
cd /var/lib/machines && machinectl shell aine@vir-ubuntu-18-04-005 /bin/bash -c 'cd /usr/local/src/script-repo && bash ubuntu-00-00-config-dotfile-system.sh'
wait $!
sleep 3
cd /var/lib/machines && machinectl shell aine@vir-ubuntu-18-04-005 /bin/bash -c 'cd /usr/local/src/script-repo && bash ubuntu-00-00-config-env-system.sh'
wait $!
sleep 3
cd /var/lib/machines && machinectl shell aine@vir-ubuntu-18-04-005 /bin/bash -c 'cd /usr/local/src/script-repo && bash ubuntu-18-04-config-font-RictyDiminished.sh'
wait $!
sleep 3
