# Container to connect to a Shrew Soft IPSec VPN

You can use docker or podman (rootfull)

You need a valid configuration file named SERVER_NAME.vpn, for example `ssl.example.org.vpn`. We use `ike-qtgui` to make and export the configuration file.

``` ini
n:version:4
n:network-ike-port:500
n:network-mtu-size:1380
n:client-addr-auto:1
n:network-natt-port:4500
n:network-natt-rate:15
n:network-dpd-enable:0
n:network-notify-enable:0
n:client-banner-enable:1
n:client-dns-used:1
n:client-dns-auto:1
n:client-dns-suffix-auto:1
b:auth-server-cert-data:xxxxx
b:auth-client-cert-data:xxxxx
b:auth-client-key-data:xxxxx
n:phase1-dhgroup:2
n:phase1-keylen:256
n:phase1-life-secs:86400
n:phase1-life-kbytes:0
n:vendor-chkpt-enable:1
n:phase2-keylen:128
n:phase2-pfsgroup:-1
n:phase2-life-secs:3600
n:phase2-life-kbytes:0
n:policy-nailed:0
n:policy-list-auto:0
s:auth-server-cert-name:cacrt.pem
s:auth-client-cert-name:usercrt.pem
s:auth-client-key-name:userkey.pem
s:network-host:ssl.example.org
s:client-auto-mode:pull
s:client-iface:virtual
s:network-natt-mode:enable
s:network-frag-mode:disable
s:auth-method:mutual-rsa
s:ident-client-type:asn1dn
s:ident-server-type:any
s:phase1-exchange:main
s:phase1-cipher:aes
s:phase1-hash:sha1
s:phase2-transform:esp-aes
s:phase2-hmac:sha1
s:ipcomp-transform:disabled
s:policy-level:auto
s:policy-list-include:192.168.0.0 / 255.255.255.0
```

**Warning, here we defini `policy-list-include` to route only targeted resources.**

``` shell
# First build (don't forget the last dot)
sudo podman build -t vpn-ike -arg ssl.example.org .

# Start Daemon
sudo podman run --init --rm -d --name vpn-ike --device=/dev/net/tun --privileged --net host vpn-ike

# Start VPN connexion (CTRL+C top stop)
# This will ask for key password
sudo podman exec -it vpn-ike ikec -r ssl.example.org -u $VPN_USER -p $VPN_PASSWORD -a 

# Stop Daemon
sudo podman stop vpn-nevers
```
