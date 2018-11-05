# can_xavier
CAN Bus Drive Script

----

# **Configure CAN controller**

- **Install busybox, we need a tool called devmem:**

>sudo apt install busybox

- **Check current values of related registers:**

>sudo busybox devmem 0x0c303000

>sudo busybox devmem 0x0c303008

>sudo busybox devmem 0x0c303010

>sudo busybox devmem 0x0c303018

- **We can continue to modify registers if returned values are exactly these:**

>0x0000C055

>0x0000C055

>0x0000C059

>0x0000C059

- **Use devmem to modify registers:**

>sudo busybox devmem 0x0c303000 32 0x0000C400

>sudo busybox devmem 0x0c303008 32 0x0000C458

>sudo busybox devmem 0x0c303010 32 0x0000C400

>sudo busybox devmem 0x0c303018 32 0x0000C458

- **Check modified values of related registers:**

>sudo busybox devmem 0x0c303000

>sudo busybox devmem 0x0c303008

>sudo busybox devmem 0x0c303010

>sudo busybox devmem 0x0c303018

- **It supposed to be successful if returned values are exactly these:**

>0x0000C400

>0x0000C458

>0x0000C400

>0x0000C458

- **Load prebuilt but not loaded drivers(Please modify path if system has been updated)**

>sudo insmod /lib/modules/4.9.108-tegra/kernel/net/can/can.ko

>sudo insmod /lib/modules/4.9.108-tegra/kernel/net/can/can-raw.ko

>sudo insmod /lib/modules/4.9.108-tegra/kernel/net/can/can-bcm.ko

>sudo insmod /lib/modules/4.9.108-tegra/kernel/net/can/can-gw.ko

>sudo insmod /lib/modules/4.9.108-tegra/kernel/drivers/net/can/can-dev.ko

>sudo insmod /lib/modules/4.9.108-tegra/kernel/drivers/net/can/mttcan/native/mttcan.ko

- **Or you can use modprobe to mount CAN Controller**

>sudo modprobe can

>sudo modprobe can_raw

>sudo modprobe mttcan

### **Notice: It seems that use modprobe is same as load drivers, so either is OK.**

- **Configure CAN controller with 1Mbps baudrate**

>sudo ip link set can0 type can bitrate 1000000

>sudo ip link set can1 type can bitrate 1000000

- **Configure CAN controller as loopback test mode**

>sudo ip link set can0 type can bitrate 1000000 loopback on

>sudo ip link set can1 type can bitrate 1000000 loopback on

- **Open CAN controller**

>sudo ip link set up can0

>sudo ip link set up can1

- **Check the status of CAN controller**

>ip -s -d link show can0

>ip -s -d link show can1

- **Close CAN controller**

>sudo ip link set down can0

>sudo ip link set down can1

----

# **Test CAN0 controller(loopback test)**

- **Open two treminals A and B,run this command in treminal A:**

>candump can0

- **Now the command executed in terminal A should under a listener mode and user inputs are not accepted.Now execute the following command in terminal B and watch what will happen in terminal A.**

>cansend can0 5A1#1122334455667788

- **It supposed to be successful if returned values are these:**

>can0 5A1 [8] 11 22 33 44 55 66 77 88

----

# **Test two CAN controllers if you have configured hardware transceiver circuit.**

- **Open two treminals A and B,run this command in treminal A:**

>candump can0

- **Now the command executed in terminal A should under a listener mode and user inputs are not accepted.Now execute the following command in terminal B and watch what will happen in terminal A.**

>cansend can1 5A1#1122334455667788

- **It supposed to be successful if returned values are these:**

>can0 5A1 [8] 11 22 33 44 55 66 77 88
