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

sudo modprobe can
sudo modprobe can_raw
sudo modprobe mttcan