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
rm -rf /var/lib/machines/vir-ubuntu-18-04-001
wait $!
rm -rf /var/lib/machines/vir-ubuntu-18-04-002
wait $!
rm -rf /var/lib/machines/vir-ubuntu-18-04-003
wait $!
rm -rf /var/lib/machines/vir-ubuntu-18-04-004
wait $!
rm -rf /var/lib/machines/vir-ubuntu-18-04-005
wait $!
cp -a /var/lib/machines/vir-ubuntu-18-04-template /var/lib/machines/vir-ubuntu-18-04-001
wait $!
cp -a /var/lib/machines/vir-ubuntu-18-04-template /var/lib/machines/vir-ubuntu-18-04-002
wait $!
cp -a /var/lib/machines/vir-ubuntu-18-04-template /var/lib/machines/vir-ubuntu-18-04-003
wait $!
cp -a /var/lib/machines/vir-ubuntu-18-04-template /var/lib/machines/vir-ubuntu-18-04-004
wait $!
cp -a /var/lib/machines/vir-ubuntu-18-04-template /var/lib/machines/vir-ubuntu-18-04-005
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
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-001 /bin/bash -c 'echo "root:root_pwd"|chpasswd';
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-002 /bin/bash -c 'echo "root:root_pwd"|chpasswd';
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-003 /bin/bash -c 'echo "root:root_pwd"|chpasswd';
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-004 /bin/bash -c 'echo "root:root_pwd"|chpasswd';
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-005 /bin/bash -c 'echo "root:root_pwd"|chpasswd';
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-001 /usr/bin/ln -sf /dev/null /etc/systemd/network/80-container-host0.network
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-002 /usr/bin/ln -sf /dev/null /etc/systemd/network/80-container-host0.network
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-003 /usr/bin/ln -sf /dev/null /etc/systemd/network/80-container-host0.network
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-004 /usr/bin/ln -sf /dev/null /etc/systemd/network/80-container-host0.network
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-005 /usr/bin/ln -sf /dev/null /etc/systemd/network/80-container-host0.network
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-001 /usr/bin/sed -i '/^#DNS=$/s/#DNS=/DNS=192.168.1.1/' /etc/systemd/resolved.conf
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-002 /usr/bin/sed -i '/^#DNS=$/s/#DNS=/DNS=192.168.1.1/' /etc/systemd/resolved.conf
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-003 /usr/bin/sed -i '/^#DNS=$/s/#DNS=/DNS=192.168.1.1/' /etc/systemd/resolved.conf
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-004 /usr/bin/sed -i '/^#DNS=$/s/#DNS=/DNS=192.168.1.1/' /etc/systemd/resolved.conf
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-005 /usr/bin/sed -i '/^#DNS=$/s/#DNS=/DNS=192.168.1.1/' /etc/systemd/resolved.conf
wait $!
cp /home/aine/script-machines/80-container-host0.network /var/lib/machines/vir-ubuntu-18-04-001/etc/systemd/network/80-container-host0.network
wait $!
cp /home/aine/script-machines/80-container-host0.network /var/lib/machines/vir-ubuntu-18-04-002/etc/systemd/network/80-container-host0.network
wait $!
cp /home/aine/script-machines/80-container-host0.network /var/lib/machines/vir-ubuntu-18-04-003/etc/systemd/network/80-container-host0.network
wait $!
cp /home/aine/script-machines/80-container-host0.network /var/lib/machines/vir-ubuntu-18-04-004/etc/systemd/network/80-container-host0.network
wait $!
cp /home/aine/script-machines/80-container-host0.network /var/lib/machines/vir-ubuntu-18-04-005/etc/systemd/network/80-container-host0.network
wait $!
cp /home/aine/script-machines/host0.network-192.168.1.210 /var/lib/machines/vir-ubuntu-18-04-001/etc/systemd/network/host0.network
wait $!
cp /home/aine/script-machines/host0.network-192.168.1.211 /var/lib/machines/vir-ubuntu-18-04-002/etc/systemd/network/host0.network
wait $!
cp /home/aine/script-machines/host0.network-192.168.1.212 /var/lib/machines/vir-ubuntu-18-04-003/etc/systemd/network/host0.network
wait $!
cp /home/aine/script-machines/host0.network-192.168.1.213 /var/lib/machines/vir-ubuntu-18-04-004/etc/systemd/network/host0.network
wait $!
cp /home/aine/script-machines/host0.network-192.168.1.214 /var/lib/machines/vir-ubuntu-18-04-005/etc/systemd/network/host0.network
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-001 /usr/bin/ln -sf /dev/null /etc/systemd/network/80-container-host0.network
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-002 /usr/bin/ln -sf /dev/null /etc/systemd/network/80-container-host0.network
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-003 /usr/bin/ln -sf /dev/null /etc/systemd/network/80-container-host0.network
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-004 /usr/bin/ln -sf /dev/null /etc/systemd/network/80-container-host0.network
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-005 /usr/bin/ln -sf /dev/null /etc/systemd/network/80-container-host0.network
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-001 /bin/systemctl stop systemd-networkd
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-001 /bin/systemctl stop systemd-resolved
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-002 /bin/systemctl stop systemd-networkd
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-002 /bin/systemctl stop systemd-resolved
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-003 /bin/systemctl stop systemd-networkd
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-003 /bin/systemctl stop systemd-resolved
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-004 /bin/systemctl stop systemd-networkd
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-004 /bin/systemctl stop systemd-resolved
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-005 /bin/systemctl stop systemd-networkd
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-005 /bin/systemctl stop systemd-resolved
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-001 /bin/systemctl enable systemd-networkd
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-001 /bin/systemctl enable systemd-resolved
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-002 /bin/systemctl enable systemd-networkd
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-002 /bin/systemctl enable systemd-resolved
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-003 /bin/systemctl enable systemd-networkd
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-003 /bin/systemctl enable systemd-resolved
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-004 /bin/systemctl enable systemd-networkd
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-004 /bin/systemctl enable systemd-resolved
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-005 /bin/systemctl enable systemd-networkd
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-005 /bin/systemctl enable systemd-resolved
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-001 /bin/systemctl start systemd-networkd
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-001 /bin/systemctl start systemd-resolved
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-002 /bin/systemctl start systemd-networkd
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-002 /bin/systemctl start systemd-resolved
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-003 /bin/systemctl start systemd-networkd
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-003 /bin/systemctl start systemd-resolved
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-004 /bin/systemctl start systemd-networkd
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-004 /bin/systemctl start systemd-resolved
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-005 /bin/systemctl start systemd-networkd
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-005 /bin/systemctl start systemd-resolved
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-001 /bin/systemctl --no-pager status systemd-networkd
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-001 /bin/systemctl --no-pager status systemd-resolved
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-002 /bin/systemctl --no-pager status systemd-networkd
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-002 /bin/systemctl --no-pager status systemd-resolved
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-003 /bin/systemctl --no-pager status systemd-networkd
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-003 /bin/systemctl --no-pager status systemd-resolved
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-004 /bin/systemctl --no-pager status systemd-networkd
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-004 /bin/systemctl --no-pager status systemd-resolved
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-005 /bin/systemctl --no-pager status systemd-networkd
wait $!
cd /var/lib/machines && machinectl shell root@vir-ubuntu-18-04-005 /bin/systemctl --no-pager status systemd-resolved
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
systemctl enable systemd-nspawn@vir-ubuntu-18-04-001.service
wait $!
systemctl enable systemd-nspawn@vir-ubuntu-18-04-002.service
wait $!
systemctl enable systemd-nspawn@vir-ubuntu-18-04-003.service
wait $!
systemctl enable systemd-nspawn@vir-ubuntu-18-04-004.service
wait $!
systemctl enable systemd-nspawn@vir-ubuntu-18-04-005.service
wait $!
systemctl start systemd-nspawn@vir-ubuntu-18-04-001.service
wait $!
systemctl start systemd-nspawn@vir-ubuntu-18-04-002.service
wait $!
systemctl start systemd-nspawn@vir-ubuntu-18-04-003.service
wait $!
systemctl start systemd-nspawn@vir-ubuntu-18-04-004.service
wait $!
systemctl start systemd-nspawn@vir-ubuntu-18-04-005.service
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
