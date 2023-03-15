export VPN_SITE_NAME=VPN
export VPN_USER='user'
export VPN_PASS='password
docker exec -it vpn-ike ikec -r "${VPN_SITE_NAME}" -u "${VPN_USER} -p "${VPN_PASS}" -a
