systemctl status --no-pager systemd-nspawn@vir-ubuntu-18-04-003.service
wait $!
systemctl stop systemd-nspawn@vir-ubuntu-18-04-003.service
wait $!
systemctl status --no-pager systemd-nspawn@vir-ubuntu-18-04-003.service
wait $!
cd /var/lib/machines && machinectl terminate vir-ubuntu-18-04-003
wait $!
echo /var/lib/machines/.#vir-ubuntu-18-04-003 | xargs rm -rf
wait $!
cd /var/lib/machines && machinectl start vir-ubuntu-18-04-003
wait $!
ag /var/lib/machines/vir-ubuntu-18-04-template change-default-permission.sh -l | xargs perl -pe "s;/var/lib/machines/vir-ubuntu-18-04-template;/var/lib/machines/vir-ubuntu-18-04-003;g" > /var/lib/machines/change-default-permission-vir-ubuntu-18-04-003.sh
wait $!
cd /var/lib/machines && chmod 755 change-default-permission-vir-ubuntu-18-04-003.sh
wait $!
cd /var/lib/machines && time bash change-default-permission-vir-ubuntu-18-04-003.sh 1>change-default-permission-vir-ubuntu-18-04-003-stdout.log 2>change-default-permission-vir-ubuntu-18-04-003-stderr.log
wait $!
