# Networking

Utilities for networking.

---

## dns-mail

Retrieve email related DNS records: MX, [SPF](https://en.wikipedia.org/wiki/Sender_Policy_Framework){target=\_blank} (Sender Policy Framework: a method to detect forged sender addresses), [DMARC](https://dmarc.org/){target=\_blank} (Domain-based Message Authentication, Reporting & Conformance: an email policy, and reporting protocol) and [DKIM](https://en.wikipedia.org/wiki/DomainKeys_Identified_Mail){target=\_blank} (DomainKeys Identified Mail: an authentication method to digitally sign emails).

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
You need an Ipstack account and an access key to query information.
This function looks for this token in an environment variable: `IPSTACK_TOKEN`.
You can configure this in your `.bashrc` or if you prefer not to provide credentials in env vars, you can give token just for this command: `IPSTACK_TOKEN=yourtoken iplocation 8.8.8.8`.

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
