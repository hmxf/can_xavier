sudo busybox devmem 0x0c303000
sudo busybox devmem 0x0c303008
sudo busybox devmem 0x0c303010
sudo busybox devmem 0x0c303018

sudo busybox devmem 0x0c303000 32 0x0000C400
sudo busybox devmem 0x0c303008 32 0x0000C458
sudo busybox devmem 0x0c303010 32 0x0000C400
sudo busybox devmem 0x0c303018 32 0x0000C458

sudo busybox devmem 0x0c303000
sudo busybox devmem 0x0c303008
sudo busybox devmem 0x0c303010
sudo busybox devmem 0x0c303018

sudo insmod /lib/modules/4.9.108-tegra/kernel/net/can/can.ko
sudo insmod /lib/modules/4.9.108-tegra/kernel/net/can/can-raw.ko
sudo insmod /lib/modules/4.9.108-tegra/kernel/net/can/can-bcm.ko
sudo insmod /lib/modules/4.9.108-tegra/kernel/net/can/can-gw.ko
sudo insmod /lib/modules/4.9.108-tegra/kernel/drivers/net/can/can-dev.ko
sudo insmod /lib/modules/4.9.108-tegra/kernel/drivers/net/can/mttcan/native/mttcan.ko