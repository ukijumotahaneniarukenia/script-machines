systemctl status --no-pager systemd-nspawn@vir-ubuntu-18-04-005.service
wait $!
sleep 3
systemctl stop systemd-nspawn@vir-ubuntu-18-04-005.service
wait $!
sleep 3
systemctl status --no-pager systemd-nspawn@vir-ubuntu-18-04-005.service
wait $!
sleep 3
cd /var/lib/machines && machinectl terminate vir-ubuntu-18-04-005
wait $!
sleep 3
echo /var/lib/machines/.#vir-ubuntu-18-04-005 | xargs rm -rf
wait $!
sleep 3
cd /var/lib/machines && machinectl start vir-ubuntu-18-04-005
wait $!
sleep 3
ag /var/lib/machines/vir-ubuntu-18-04-template change-default-permission.sh -l | xargs perl -pe "s;/var/lib/machines/vir-ubuntu-18-04-template;/var/lib/machines/vir-ubuntu-18-04-005;g" > /var/lib/machines/change-default-permission-vir-ubuntu-18-04-005.sh
wait $!
sleep 3
cd /var/lib/machines && chmod 755 change-default-permission-vir-ubuntu-18-04-005.sh
wait $!
sleep 3
cd /var/lib/machines && time bash change-default-permission-vir-ubuntu-18-04-005.sh 1>change-default-permission-vir-ubuntu-18-04-005-stdout.log 2>change-default-permission-vir-ubuntu-18-04-005-stderr.log
wait $!
sleep 3
