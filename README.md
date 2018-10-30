# can_xavier
CAN Bus Drive Script

----

- Rev1 for register-modify Version.(NOT Recommended.)

- Rev2 for prebuilt-driver Version.(Recommended because the drivers are shipped with system.)

----
Here are contents you neet to use these scripts.

----

#Rev1

## **Modify registers(This has been updated because it's complex and dangerous.)**

### **Install busybox, we need a tool called devmem:**

>sudo apt install busybox

### **Check current values of related registers:**

>sudo busybox devmem 0x0c303000
>sudo busybox devmem 0x0c303008
>sudo busybox devmem 0x0c303010
>sudo busybox devmem 0x0c303018

### **We can continue to modify registers if returned values are exactly these:**

>0x0000C055
>0x0000C055
>0x0000C059
>0x0000C059

### **Use devmem to modify registers:**

>sudo busybox devmem 0x0c303000 32 0x0000C400
>sudo busybox devmem 0x0c303008 32 0x0000C458
>sudo busybox devmem 0x0c303010 32 0x0000C400
>sudo busybox devmem 0x0c303018 32 0x0000C458

### **Check modified values of related registers:**

>sudo busybox devmem 0x0c303000
>sudo busybox devmem 0x0c303008
>sudo busybox devmem 0x0c303010
>sudo busybox devmem 0x0c303018

### **It supposed to be successful if returned values are exactly these:**

>0x0000C400
>0x0000C458
>0x0000C400
>0x0000C458

## **Mount CAN Bus**

### **Use modprobe to mount CAN Bus Controller:**

>sudo modprobe can
>sudo modprobe can_raw
>sudo modprobe mttcan

## **Open CAN Controller**


### **The following command initialize CAN0 controller and set baudrate to 500Kbps,modify port number and baudrate if you need.**
>sudo ip link set can0 type can bitrate 500000

### **The following command open CAN0 controller,you can test data TX/RX on port CAN0 if you have functionally configured hardware transceiver circuit.**
>sudo ip link set up can0

### **The following command initialize CAN0 controller,open loopback function,set baudrate to 500Kbps,and open CAN0 controller.Modify port number and baudrate if you need.**
>sudo ip link set can0 up type can bitrate 500000 loopback on

### **Use the following cammand to get details about CAN0 controller.You may find informations useful for debug.Go for ifconfig is also an access to information.**
>ip -details -statistics link show can0

### **Shutdown CAN0 controller if need.**
>sudo ip link set down can0

## **Data sending and receiving test**

### **Send data to default ID 0x1 with CAN standard frame,data are 0x11 22 33 44 55 66 77 88**
### **8 byte max every frame**
>cansend can0 0x11 0x22 0x33 0x44 0x55 0x66 0x77 0x88

### **-e for extend frame,CAN_ID 29bit max;standard frame's CAN_ID 11bit max**
### **-i for CAN_ID**
>cansend can0 -i 0x800 0x11 0x22 0x33 0x44 0x55 0x66 0x77 0x88 -e

### **--loop=20 for send 20 packets**
>cansend can0 -i 0x02 0x11 0x12 --loop=20

### **Receive CAN0 data**
>candump can0

----

#Rev2

## **Configure CAN controller**

### **Load prebuilt but not loaded drivers(Please modify path if system has been updated)**

>sudo insmod /lib/modules/4.9.108-tegra/kernel/net/can/can.ko
>sudo insmod /lib/modules/4.9.108-tegra/kernel/net/can/can-raw.ko
>sudo insmod /lib/modules/4.9.108-tegra/kernel/net/can/can-bcm.ko
>sudo insmod /lib/modules/4.9.108-tegra/kernel/net/can/can-gw.ko
>sudo insmod /lib/modules/4.9.108-tegra/kernel/drivers/net/can/can-dev.ko 
>sudo insmod /lib/modules/4.9.108-tegra/kernel/drivers/net/can/mttcan/native/mttcan.ko

### **Configure CAN controller with 1Mbps baudrate**

>sudo ip link set can0 type can bitrate 1000000
>sudo ip link set can1 type can bitrate 1000000

### **Configure CAN controller as loopback test mode**

>sudo ip link set can0 type can bitrate 1000000 loopback on
>sudo ip link set can1 type can bitrate 1000000 loopback on

### **Open CAN controller**

>sudo ip link set up can0
>sudo ip link set up can1

### **Check the status of CAN controller**

>ip -s -d link show can0
>ip -s -d link show can1

### **Close CAN controller**

>sudo ip link set down can0
>sudo ip link set down can1

## **Test CAN0 controller(loopback test)**

### **Open two treminals A and B,run this command in treminal A:**

>candump can0

### **Now the command executed in terminal A should under a listener mode and user inputs are not accepted.Now execute the following command in terminal B and watch what will happen in terminal A.**

>cansend can0 5A1#1122334455667788
