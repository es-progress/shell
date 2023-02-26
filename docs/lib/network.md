# Networking

Utilities for networking.

---

## dns-mail

Retrieve email related DNS records: SPF, DMARC and DKIM.

**Usage**

```
dns-mail DOMAIN SELECTOR

Params:
DOMAIN             Domain to inspect
SELECTOR           DKIM selector
```

---

## iplocation

Query [Ipstack](https://ipstack.com/){target=\_blank} for GeoIP data.
You need an Ipstack account and access key to query info.
This function looks for this token in an environment variable: `IPSTACK_TOKEN`.
You can set this in your `.bashrc` or if you're generally not happy by providing credentials in env vars, you can give token just for this command: `IPSTACK_TOKEN=yourtoken iplocation 8.8.8.8`.

**Usage**

```
iplocation [IP]...

Params:
IP                 IP address to check
```

---

## whatsmyip4

Return you own external IPv4 address. Retrieved from Google nameservers.

**Usage**

```
whatsmyip4
```

---

## whatsmyip6

Return you own external IPv6 address. Retrieved from Google nameservers.

**Usage**

```
whatsmyip6
```
