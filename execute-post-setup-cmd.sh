systemctl status --no-pager systemd-nspawn@vir-ubuntu-18-04-001.service
wait $!
systemctl status --no-pager systemd-nspawn@vir-ubuntu-18-04-002.service
wait $!
systemctl status --no-pager systemd-nspawn@vir-ubuntu-18-04-003.service
wait $!
systemctl status --no-pager systemd-nspawn@vir-ubuntu-18-04-004.service
wait $!
systemctl status --no-pager systemd-nspawn@vir-ubuntu-18-04-005.service
wait $!
systemctl stop systemd-nspawn@vir-ubuntu-18-04-001.service
wait $!
systemctl stop systemd-nspawn@vir-ubuntu-18-04-002.service
wait $!
systemctl stop systemd-nspawn@vir-ubuntu-18-04-003.service
wait $!
systemctl stop systemd-nspawn@vir-ubuntu-18-04-004.service
wait $!
systemctl stop systemd-nspawn@vir-ubuntu-18-04-005.service
wait $!
systemctl status --no-pager systemd-nspawn@vir-ubuntu-18-04-001.service
wait $!
systemctl status --no-pager systemd-nspawn@vir-ubuntu-18-04-002.service
wait $!
systemctl status --no-pager systemd-nspawn@vir-ubuntu-18-04-003.service
wait $!
systemctl status --no-pager systemd-nspawn@vir-ubuntu-18-04-004.service
wait $!
systemctl status --no-pager systemd-nspawn@vir-ubuntu-18-04-005.service
wait $!
cd /var/lib/machines && machinectl terminate vir-ubuntu-18-04-001
wait $!
cd /var/lib/machines && machinectl terminate vir-ubuntu-18-04-002
wait $!
cd /var/lib/machines && machinectl terminate vir-ubuntu-18-04-003
wait $!
cd /var/lib/machines && machinectl terminate vir-ubuntu-18-04-004
wait $!
cd /var/lib/machines && machinectl terminate vir-ubuntu-18-04-005
wait $!
echo /var/lib/machines/.#vir-ubuntu-18-04-001 | xargs rm -rf
wait $!
echo /var/lib/machines/.#vir-ubuntu-18-04-002 | xargs rm -rf
wait $!
echo /var/lib/machines/.#vir-ubuntu-18-04-003 | xargs rm -rf
wait $!
echo /var/lib/machines/.#vir-ubuntu-18-04-004 | xargs rm -rf
wait $!
echo /var/lib/machines/.#vir-ubuntu-18-04-005 | xargs rm -rf
wait $!
cd /var/lib/machines && machinectl start vir-ubuntu-18-04-001
wait $!
cd /var/lib/machines && machinectl start vir-ubuntu-18-04-002
wait $!
cd /var/lib/machines && machinectl start vir-ubuntu-18-04-003
wait $!
cd /var/lib/machines && machinectl start vir-ubuntu-18-04-004
wait $!
cd /var/lib/machines && machinectl start vir-ubuntu-18-04-005
wait $!
machinectl list -all
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-001 /usr/sbin/groupadd -g 1000 aine
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-002 /usr/sbin/groupadd -g 1000 aine
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-003 /usr/sbin/groupadd -g 1000 aine
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-004 /usr/sbin/groupadd -g 1000 aine
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-005 /usr/sbin/groupadd -g 1000 aine
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-001 /usr/sbin/useradd -m -g aine -u 1000 aine
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-002 /usr/sbin/useradd -m -g aine -u 1000 aine
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-003 /usr/sbin/useradd -m -g aine -u 1000 aine
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-004 /usr/sbin/useradd -m -g aine -u 1000 aine
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-005 /usr/sbin/useradd -m -g aine -u 1000 aine
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-001 /usr/bin/chsh -s /bin/bash aine
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-002 /usr/bin/chsh -s /bin/bash aine
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-003 /usr/bin/chsh -s /bin/bash aine
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-004 /usr/bin/chsh -s /bin/bash aine
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-005 /usr/bin/chsh -s /bin/bash aine
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-001 /bin/bash -c 'echo "aine:aine_pwd"|chpasswd'
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-002 /bin/bash -c 'echo "aine:aine_pwd"|chpasswd'
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-003 /bin/bash -c 'echo "aine:aine_pwd"|chpasswd'
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-004 /bin/bash -c 'echo "aine:aine_pwd"|chpasswd'
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-005 /bin/bash -c 'echo "aine:aine_pwd"|chpasswd'
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-001 /bin/bash -c 'echo "aine ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers '
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-002 /bin/bash -c 'echo "aine ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers '
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-003 /bin/bash -c 'echo "aine ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers '
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-004 /bin/bash -c 'echo "aine ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers '
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-005 /bin/bash -c 'echo "aine ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers '
wait $!
cd /var/lib/machines && machinectl terminate vir-ubuntu-18-04-001
wait $!
cd /var/lib/machines && machinectl terminate vir-ubuntu-18-04-002
wait $!
cd /var/lib/machines && machinectl terminate vir-ubuntu-18-04-003
wait $!
cd /var/lib/machines && machinectl terminate vir-ubuntu-18-04-004
wait $!
cd /var/lib/machines && machinectl terminate vir-ubuntu-18-04-005
wait $!
machinectl list -all
wait $!
ag /var/lib/machines/vir-ubuntu-18-04-template change-default-permission.sh -l | xargs perl -pe "s;/var/lib/machines/vir-ubuntu-18-04-template;/var/lib/machines/vir-ubuntu-18-04-001;g" > change-default-permission-vir-ubuntu-18-04-001.sh
wait $!
ag /var/lib/machines/vir-ubuntu-18-04-template change-default-permission.sh -l | xargs perl -pe "s;/var/lib/machines/vir-ubuntu-18-04-template;/var/lib/machines/vir-ubuntu-18-04-002;g" > change-default-permission-vir-ubuntu-18-04-002.sh
wait $!
ag /var/lib/machines/vir-ubuntu-18-04-template change-default-permission.sh -l | xargs perl -pe "s;/var/lib/machines/vir-ubuntu-18-04-template;/var/lib/machines/vir-ubuntu-18-04-003;g" > change-default-permission-vir-ubuntu-18-04-003.sh
wait $!
ag /var/lib/machines/vir-ubuntu-18-04-template change-default-permission.sh -l | xargs perl -pe "s;/var/lib/machines/vir-ubuntu-18-04-template;/var/lib/machines/vir-ubuntu-18-04-004;g" > change-default-permission-vir-ubuntu-18-04-004.sh
wait $!
ag /var/lib/machines/vir-ubuntu-18-04-template change-default-permission.sh -l | xargs perl -pe "s;/var/lib/machines/vir-ubuntu-18-04-template;/var/lib/machines/vir-ubuntu-18-04-005;g" > change-default-permission-vir-ubuntu-18-04-005.sh
wait $!
cd /var/lib/machines && chmod 755 change-default-permission-vir-ubuntu-18-04-001.sh
wait $!
cd /var/lib/machines && chmod 755 change-default-permission-vir-ubuntu-18-04-002.sh
wait $!
cd /var/lib/machines && chmod 755 change-default-permission-vir-ubuntu-18-04-003.sh
wait $!
cd /var/lib/machines && chmod 755 change-default-permission-vir-ubuntu-18-04-004.sh
wait $!
cd /var/lib/machines && chmod 755 change-default-permission-vir-ubuntu-18-04-005.sh
wait $!
cd /var/lib/machines && time bash change-default-permission-vir-ubuntu-18-04-001.sh 1>change-default-permission-vir-ubuntu-18-04-001-stdout.log 2>change-default-permission-vir-ubuntu-18-04-001-stderr.log
wait $!
cd /var/lib/machines && time bash change-default-permission-vir-ubuntu-18-04-002.sh 1>change-default-permission-vir-ubuntu-18-04-002-stdout.log 2>change-default-permission-vir-ubuntu-18-04-002-stderr.log
wait $!
cd /var/lib/machines && time bash change-default-permission-vir-ubuntu-18-04-003.sh 1>change-default-permission-vir-ubuntu-18-04-003-stdout.log 2>change-default-permission-vir-ubuntu-18-04-003-stderr.log
wait $!
cd /var/lib/machines && time bash change-default-permission-vir-ubuntu-18-04-004.sh 1>change-default-permission-vir-ubuntu-18-04-004-stdout.log 2>change-default-permission-vir-ubuntu-18-04-004-stderr.log
wait $!
cd /var/lib/machines && time bash change-default-permission-vir-ubuntu-18-04-005.sh 1>change-default-permission-vir-ubuntu-18-04-005-stdout.log 2>change-default-permission-vir-ubuntu-18-04-005-stderr.log
wait $!
