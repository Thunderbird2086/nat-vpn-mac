#!/bin/sh

# default gateway interface to share with other devices
gw_if="en0"

# vpn interface
vpn_if="tun10"

args=`getopt f:t: $*`

set -- $args

while [ $# -ne 0 ]; do
    case "$1" in
      -f)
        shift;
        gw_if=$1
        ;;
      -t)
        shift;
        vpn_if=$1
        ;;
      --)
        ;;
    esac

    shift;
done

# enable packet forwarding
sudo sysctl -w net.inet.ip.forwarding=1

# writing nat rule
cat > .nat-rules << EOF

# The users whose connection must be redirected.
gw_if = "${gw_if}"

# target interface to redirect
vpn_if = "${vpn_if}"

nat on \$vpn_if from \$gw_if:network to any -> (\$vpn_if)

EOF

# load rule
sudo pfctl -f ./.nat-rules -e

rm .nat-rules
