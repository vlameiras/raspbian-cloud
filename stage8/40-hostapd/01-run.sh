#!/bin/bash -e

install -m 644 -g root -o root files/default ${ROOTFS_DIR}/etc/default/hostapd
install -m 755 -g root -o root files/bin/forwarding.sh ${ROOTFS_DIR}/etc/hostapd/forwarding-eth0.sh
install -m 755 -g root -o root files/bin/forwarding.sh ${ROOTFS_DIR}/etc/hostapd/forwarding-wlan0.sh

# Systemd service
mkdir -p ${ROOTFS_DIR}/etc/systemd/system/wpa_supplicant.service.d
mkdir -p ${ROOTFS_DIR}/etc/systemd/system/wpa_supplicant@wlan0.service.d
install -m 644 -g root -o root files/systemd/wpa_supplicant.conf ${ROOTFS_DIR}/etc/systemd/system/wpa_supplicant.service.d
install -m 644 -g root -o root files/systemd/wpa_supplicant.conf ${ROOTFS_DIR}/etc/systemd/system/wpa_supplicant@wlan0.service.d

install -m 644 -g root -o root files/systemd/hostapd@.service ${ROOTFS_DIR}/lib/systemd/system
install -m 644 -g root -o root files/systemd/hostapd.service ${ROOTFS_DIR}/lib/systemd/system

on_chroot <<EOF
# Enable service
systemctl enable hostapd.service
EOF

