# virtualbox.sh

VBOX_VERSION=$(cat /home/tc/.vbox_version)
MODULES_DIR=/lib/modules/3.8.10-tinycore/misc

# Install files from Virtualbox Guest Additions
mkdir -p $MODULES_DIR
tar xvfz vbox-ga.tar.gz
chown root:root *.ko; chmod 644 *.ko
mv ./vboxguest.ko ./vboxsf.ko ./vboxvideo.ko $MODULES_DIR
mv ./mount.vboxsf bin/
rm -f ./vbox-ga.tar.gz

sudo sh -c "cat >> /opt/bootsync.sh" << EOF
/sbin/modprobe vboxguest
/sbin/modprobe vboxsf
/bin/ln -s /home/tc/bin/mount.vboxsf /sbin/mount.vboxsf
EOF

# Cleaning up
rm -f VBoxGuestAdditions_$VBOX_VERSION.iso
rm -f /home/tc/vbox-ga_tar_gz.sh
