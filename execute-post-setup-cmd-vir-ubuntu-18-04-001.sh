cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-001 /usr/bin/sed -i.bak 's@archive.ubuntu.com@ftp.jaist.ac.jp/pub/Linux@g' /etc/apt/sources.list
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-001 /usr/bin/apt update
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-001 /usr/bin/apt install -y git curl unzip
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-001 /bin/bash -c 'cd /usr/local/src && git clone https://github.com/ukijumotahaneniarukenia/script-repo.git'
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-001 /bin/bash -c 'cd /usr/local/src/script-repo && bash ubuntu-18-04-install-dev-pkg.sh'
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-001 /usr/bin/apt install -y autoconf automake gcc git make
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-001 /bin/bash -c 'cd /usr/local/src && rm -rf vim && git clone https://github.com/vim/vim.git'
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-001 /bin/bash -c 'cd /usr/local/src/vim && ./configure --with-features=huge --enable-multibyte --enable-gpm --enable-cscope --enable-fontset --enable-fail-if-missing --prefix=/usr/local'
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-001 /bin/bash -c 'cd /usr/local/src/vim && make -j12'
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-001 /bin/bash -c 'cd /usr/local/src/vim && make -j12 install'
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-001 $(/usr/bin/which ln) -fsr /usr/local/bin/vim /usr/bin/vi
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-001 /usr/bin/which vim
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-001 /usr/bin/which vi
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-001 /bin/bash -c 'cd /usr/local/src/script-repo && bash ubuntu-18-04-install-vim-user.sh'
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-001 /bin/bash -c 'cd /usr/local/src/script-repo && bash ubuntu-18-04-install-vim_plug.sh'
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-001 /bin/bash -c 'cd /usr/local/src/script-repo && bash ubuntu-00-00-config-dotfile-system.sh'
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-001 /bin/bash -c 'cd /usr/local/src/script-repo && bash ubuntu-18-04-config-locale.sh'
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-001 /bin/bash -c 'cd /usr/local/src/script-repo && bash ubuntu-00-00-config-env-system.sh'
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-001 /bin/bash -c 'cd /usr/local/src/script-repo && bash ubuntu-18-04-config-font-RictyDiminished.sh'
wait $!
cd /var/lib/machines && machinectl shell aine@vir-ubuntu-18-04-001 /bin/bash -c 'cd /usr/local/src/script-repo && bash ubuntu-18-04-install-vim-user.sh'
wait $!
cd /var/lib/machines && machinectl shell aine@vir-ubuntu-18-04-001 /bin/bash -c 'cd /usr/local/src/script-repo && bash ubuntu-18-04-install-vim_plug.sh'
wait $!
cd /var/lib/machines && machinectl shell aine@vir-ubuntu-18-04-001 /bin/bash -c 'cd /usr/local/src/script-repo && bash ubuntu-00-00-config-dotfile-system.sh'
wait $!
cd /var/lib/machines && machinectl shell aine@vir-ubuntu-18-04-001 /bin/bash -c 'cd /usr/local/src/script-repo && bash ubuntu-00-00-config-env-system.sh'
wait $!
cd /var/lib/machines && machinectl shell aine@vir-ubuntu-18-04-001 /bin/bash -c 'cd /usr/local/src/script-repo && bash ubuntu-18-04-config-font-RictyDiminished.sh'
wait $!
