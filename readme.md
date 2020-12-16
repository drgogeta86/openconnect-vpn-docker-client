# Container to connect to a Shrew Soft IPSec VPN

You can use docker or podman (rootfull)

You need a valid configuration file named SERVER_NAME.vpn in folder VPN. See example in `VPN/ssl.example.org.vpn`. We use `ike-qtgui` to make and export the configuration file.

**Warning, in the sample we define `policy-list-include` to route only targeted resources.**

``` shell
#.envrc
export VPN_SITE_NAME=ssl.example.org
export VPN_USER=user
export VPN_PASSWORD=xxxxxxx

# First build (don't forget the last dot)
sudo podman build -t vpn-ike --build-arg "SITE_NAME=${VPN_SITE_NAME}" .

# Start Daemon
sudo podman run --init --rm -d --name vpn-ike --device=/dev/net/tun --privileged --net host vpn-ike

# Start VPN connexion (CTRL+C top stop)
# This will ask for key password
sudo podman exec -it vpn-ike ikec -r "${VPN_SITE_NAME}" -u "${VPN_USER}" -p "${VPN_PASSWORD}" -a 

# Stop Daemon
sudo podman stop vpn-ike
```
