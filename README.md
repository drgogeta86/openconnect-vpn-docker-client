# Container to connect to a Ivanti/PulseSecure/Juniper VPN

You cannot use podman (even rootfull), usefull to connect against multifactor login vpn

``` shell

# First build (don't forget the last dot)
sudo docker build -t vpn-openconnect --build-arg "SITE_NAME=${VPN_SITE_NAME}" .

# Start Daemon
AUTHORIZED_SSH_KEY=$(cat ~/.ssh/id_ecdsa.pub)
docker run --init --rm -e AUTHORIZED_SSH_KEY="${AUTHORIZED_SSH_KEY}" -d --name vpn-openconnect -p12222:22 --device=/dev/net/tun --cap-add=NET_ADMIN --cap-add=DAC_READ_SEARCH  --cap-add=CAP_SYS_CHROOT  vpn-ike

# Start VPN connexion (CTRL+C top stop)
# This will ask for key password
sudo docker exec -it vpn-openconnect ikec -r "${VPN_SITE_NAME}" -u "${VPN_USER}" -p "${VPN_PASSWORD}" -a 

# Stop Daemon
```
sudo docker stop vpn-openconnect
```

There are some helper script in `contrib` folder

1. Launch Vpn Container ( kill container at every launch)

```shell
bash contrib/run_container.sh
```

2. Initiate vpn Login

```shell
bash contrib/launch_vpn.sh https://vpnssl.mydomain.com/MYVPN/ 
```