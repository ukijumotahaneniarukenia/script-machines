#systemctl status --no-pager systemd-nspawn@vir-ubuntu-18-04-001.service
#wait $!
#systemctl stop systemd-nspawn@vir-ubuntu-18-04-001.service
#wait $!
#systemctl status --no-pager systemd-nspawn@vir-ubuntu-18-04-001.service
#wait $!
#cd /var/lib/machines && machinectl terminate vir-ubuntu-18-04-001
#wait $!
#echo /var/lib/machines/.#vir-ubuntu-18-04-001 | xargs rm -rf
#wait $!
#rm -rf /var/lib/machines/vir-ubuntu-18-04-001
#wait $!
#cp -a /var/lib/machines/vir-ubuntu-18-04-template /var/lib/machines/vir-ubuntu-18-04-001
#wait $!
#cd /var/lib/machines && machinectl start vir-ubuntu-18-04-001
#wait $!
#cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-001 /bin/bash -c 'echo "root:root_pwd"|chpasswd';
#wait $!
#cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-001 /usr/sbin/groupadd -g 1000 aine
#wait $!
#cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-001 /usr/sbin/useradd -m -g aine -u 1000 aine
#wait $!
#cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-001 /usr/bin/chsh -s /bin/bash aine
#wait $!
#cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-001 /bin/bash -c 'echo "aine:aine_pwd"|chpasswd'
#wait $!
#cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-001 /bin/bash -c 'echo "aine ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers '
#wait $!
#cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-001 /usr/bin/ln -sf /dev/null /etc/systemd/network/80-container-host0.network
#wait $!
#cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-001 /usr/bin/sed -i '/^#DNS=$/s/#DNS=/DNS=192.168.1.1/' /etc/systemd/resolved.conf
#wait $!
#cp /home/aine/script-machines/80-container-host0.network /var/lib/machines/vir-ubuntu-18-04-001/etc/systemd/network/80-container-host0.network
#wait $!
#cp /home/aine/script-machines/host0.network-192.168.1.210 /var/lib/machines/vir-ubuntu-18-04-001/etc/systemd/network/host0.network
#wait $!
#cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-001 /usr/bin/ln -sf /dev/null /etc/systemd/network/80-container-host0.network
#wait $!
#cp /home/aine/script-machines/systemd_nspawn.env /var/lib/machines/vir-ubuntu-18-04-001/usr/local/src/systemd_nspawn.env
#wait $!
#cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-001 /bin/systemctl stop systemd-networkd
#wait $!
#cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-001 /bin/systemctl stop systemd-resolved
#wait $!
#cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-001 /bin/systemctl enable systemd-networkd
#wait $!
#cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-001 /bin/systemctl enable systemd-resolved
#wait $!
#cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-001 /bin/systemctl start systemd-networkd
#wait $!
#cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-001 /bin/systemctl start systemd-resolved
#wait $!
#cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-001 /bin/systemctl --no-pager status systemd-networkd
#wait $!
#cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-001 /bin/systemctl --no-pager status systemd-resolved
#wait $!
systemctl stop systemd-nspawn@vir-ubuntu-18-04-001.service
wait $!
systemctl enable systemd-nspawn@vir-ubuntu-18-04-001.service
wait $!
systemctl start systemd-nspawn@vir-ubuntu-18-04-001.service
wait $!
systemctl status --no-pager systemd-nspawn@vir-ubuntu-18-04-001.service
wait $!
