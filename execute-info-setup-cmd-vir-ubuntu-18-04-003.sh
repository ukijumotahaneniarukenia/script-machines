echo 'export MACHINE_NAME=vir-ubuntu-18-04-001' >> /var/lib/machines/vir-ubuntu-18-04-001/etc/environment
wait $!
sleep 3
echo 'export MACHINE_IP=' >> /var/lib/machines/vir-ubuntu-18-04-001/etc/environment
wait $!
sleep 3
cp /home/aine/script-machines/systemd_nspawn-container-list.json /var/lib/machines/vir-ubuntu-18-04-001/usr/local/src/systemd_nspawn-container-list.json
wait $!
sleep 3
