
# OpenVPN server

## Prepare server
```sh
apt update && apt install -y openvpn easy-rsa
```

```sh
make-cadir /etc/openvpn/easy-rsa
cd /etc/openvpn/easy-rsa
./easyrsa init-pki
./easyrsa build-ca
./easyrsa build-server-full server nopass
./easyrsa build-dh
openvpn --genkey --secret ta.key
```

## Configuration file (example)

```
port 1194
proto tcp
dev tun

ca /etc/openvpn/easy-rsa/pki/ca.crt
cert /etc/openvpn/easy-rsa/pki/issued/server.crt
key /etc/openvpn/easy-rsa/pki/private/server.key
dh /etc/openvpn/easy-rsa/pki/dh.pem

server 10.0.7.0 255.255.255.0
ifconfig-pool-persist ipp.txt
client-to-client
keepalive 10 120

plugin /usr/lib/openvpn/openvpn-plugin-auth-pam.so login
verify-client-cert optional

persist-key
persist-tun

#push "route 10.0.7.0 255.255.255.0"
#push "redirect-gateway def1 bypass-dhcp"
#push "dhcp-option DNS 8.8.8.8"
#push "dhcp-option DNS 1.1.1.1"

status openvpn-status.log
verb 3
```

## Add routing 
/etc/sysctl.conf  
```
net.ipv4.ip_forward=1
```
activate changes:
```
sysctl -p
```

## Start/enable server
```
systemctl start openvpn@server
systemctl enable openvpn@server
```

# OpenVPN client

## Certificates

```sh
cd /etc/openvpn/easy-rsa
./easyrsa build-client-full client1 nopass
```
Result:
```
/etc/openvpn/easy-rsa/pki/issued/client1.crt
/etc/openvpn/easy-rsa/pki/private/client1.key
/etc/openvpn/easy-rsa/pki/ca.crt
```

## Client configuration file (example)
client.ovpn file:
```
client
dev tun
proto tcp
remote srv16.mikr.us 20176
resolv-retry infinite
nobind
#remote-cert-tls server

persist-key
persist-tun
#route 10.0.7.0 255.255.255.0

auth-user-pass

verb 3

<ca>
-----BEGIN CERTIFICATE-----
(ca.crt content )
-----END CERTIFICATE-----
</ca>

<cert>
-----BEGIN CERTIFICATE-----
(client1.crt)
-----END CERTIFICATE-----
</cert>

<key>
-----BEGIN PRIVATE KEY-----
(client1.key)
-----END PRIVATE KEY-----
</key>

```

## Xubuntu NetworkManager fix
- Network -> VPN
- select your configuration -> edit
- IPv4 options -> Routes -> [v] Use this connection for resources on its network

## Windows (to check)
add 
```
route-nopull
route 10.0.7.0 255.255.255.0
```
to `client1.ovpn` file