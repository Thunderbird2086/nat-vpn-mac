# nat-vpn-mac
VPN Share on MacOS

## usage
On the mac you want to share your VPN, pick up network interface as a gateway for other devices.
```
$ #
$ #./nat-vpn.sh -f <interface to share> -t <vpn interface>
$ #
$ # see sample below
$ ./nat-vpn.sh -f en0 -t tun10
```

On other devices, set IP address for **en0** as the gateway, then all the packets from your devices to interface **en0** will passed to **tun10**.

## TL;DR
I have various development machines such as MacOS, Linux and/or Windows, and one of them is using VPN on Mac.  As MacOS support Internet Sharing, I thought I could use it to share VPN.  However, it was not that easy especially when the VPN is using **Tunnelblick**.
  I played with `route` and `netstat` for some time, but I ended up with [`PF`](https://en.wikipedia.org/wiki/PF_(firewall)).

The idea is very simple: make my Mac as a gateway for the other devices and all the packets to vpn interface, and it is working like charm. 
