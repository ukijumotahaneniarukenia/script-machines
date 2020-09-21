systemctl status --no-pager systemd-nspawn@vir-ubuntu-18-04-001.service
wait $!
systemctl stop systemd-nspawn@vir-ubuntu-18-04-001.service
wait $!
systemctl status --no-pager systemd-nspawn@vir-ubuntu-18-04-001.service
wait $!
cd /var/lib/machines && machinectl terminate vir-ubuntu-18-04-001
wait $!
echo /var/lib/machines/.#vir-ubuntu-18-04-001 | xargs rm -rf
wait $!
cd /var/lib/machines && machinectl start vir-ubuntu-18-04-001
wait $!
ag /var/lib/machines/vir-ubuntu-18-04-template change-default-permission.sh -l | xargs perl -pe "s;/var/lib/machines/vir-ubuntu-18-04-template;/var/lib/machines/vir-ubuntu-18-04-001;g" > /var/lib/machines/change-default-permission-vir-ubuntu-18-04-001.sh
wait $!
cd /var/lib/machines && chmod 755 change-default-permission-vir-ubuntu-18-04-001.sh
wait $!
cd /var/lib/machines && time bash change-default-permission-vir-ubuntu-18-04-001.sh 1>change-default-permission-vir-ubuntu-18-04-001-stdout.log 2>change-default-permission-vir-ubuntu-18-04-001-stderr.log
wait $!
