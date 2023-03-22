docker stop vpn-openconnect
AUTHORIZED_SSH_KEY=$(cat ~/.ssh/id_ecdsa.pub)
docker run --init --rm -e AUTHORIZED_SSH_KEY="${AUTHORIZED_SSH_KEY}" -d --name vpn-openconnect -p1111:22 --device=/dev/net/tun --cap-add=NET_ADMIN --cap-add=DAC_READ_SEARCH  --cap-add=CAP_SYS_CHROOT  vpn-openconnect
