# Networking
Basic networking concepts..

## Ip Key Commands

list and modify interfaces on the host:  ``iplink``  
list assigned ip addresses to the interfaces: ``ip addr``  
set ip addresses on the interfaces: ``ip addr add 192.168.1.10/24 dev eth0`` (does not persist reboot, see above example for that)  
view routing table: ``route`` or ``ip route``  
add entries to the routing table: ``ip route add 192.168.1.0/24 via 192.168.2.1``  

### *From labs*

```bash
sudo ip addr add 172.16.238.15/24 dev eth0
sudo ip addr add 172.16.238.16/24 dev eth0
sudo ip addr add 172.16.239.15/24 dev eth0
sudo ip addr add 172.16.239.16/24 dev eth0

# iNet ip addresses (notice 238, and 239)
172.16.238.10/24
172.16.239.10/24

# On machines with ip addr 172.16.238.*
sudo ip route add 172.16.239.0/24 via 172.16.238.10

# On machines with ip addr 172.16.239.*
sudo ip route add 172.16.238.0/24 via 172.16.239.10

```

## Switching

A switch connects devices within the same network. E.g. 192.168.**1**.0 or 192.168.**2**.0 as shown below

![gateway](imgs/gateway_routing.png)

The router connects the two switches, i.e. 192.168.1.1 & 192.168.2.1.

Running the command ``ip route add {ipaddress} via {ipaddress}`` connects the two as shown above.
This configuration has to be made on all the systems, meaning it's not enough to only configure one-way.  

```bash
ip route add 192.168.2.0/24 via 192.168.1.1
ip route add 192.168.1.0/24 via 192.168.1.1
```
This only configures the two networks to talk to each other. If we also want to connect to the internet, say for example Google. We'd need to add that to the routing.

```bash
ip route add 192.168.2.0/24 via 192.168.1.1
ip route add 192.168.1.0/24 via 192.168.1.1
ip route add 172.217.194.0/24 via 192.168.2.1
```
But because we do not know ALL the ip addresses of all hosts, we can set up the router to go via a default routing. ``ip route add default via 192.168.2.1``. It's basically the same as ``0.0.0.0``.  

However, if we both have an internal network as well as "public" network then we'd need to set that up.

![multi-network](imgs/multiple_network_routing.png)

To make ensure that routing works correctly, use ``ping {ipaddress}``. But on linux it has to be specified in a particular folder.  

```bash
cat proc/sys/net/ipv4/ip_forward
# Default value is 0
>> 0  
# Does not persist across reboots
echo 1 > proc/sys/net/ipv4/ip_forward 
>> 1

# If host is configured to act as a router configure value in
/etc/sysctl.conf
net.ipv4.ip_forward = #input number 
```