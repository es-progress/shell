# SSH

Helper functions for SSH.

---

## socks5-tunnel-close

Close a previously opened SOCKS5 tunnel.
You can open a tunnel with `socks5-tunnel-open` and you need to give the same params to close that tunnel.

**Usage**

```
socks5-tunnel-close HOST PORT

Params:
HOST               Remote host (IP or hostname)
PORT               Local port
```

---

## socks5-tunnel-open

Open a SOCKS5 tunnel to a remote host. You can use IP address or hostname also.
With this tunnel you can route your HTTP traffic through the secure (SSH) tunnel and use the remote host as your proxy.

**Usage**

```
socks5-tunnel-open HOST PORT

Params:
HOST               Remote host (IP or hostname)
PORT               Local port
```

---

## ssh-create-key

Generate a new ed25519 SSH key-pair.
Key is saved in current directory and 96 rounds of hashing is done on the private key.

**Usage**

```
ssh-create-key NAME COMMENT [EXTRA]...

Params:
NAME               Key name
COMMENT            Key comment
EXTRA              Optional extra params to 'ssh-keygen'
```

---

## ssh-sign-user

Sign a user's public key with a Certificate Authority (CA) key.
This creates a certificate that can be used for authenticating to an SSH server.
The server then only needs to trust the CA certificate not every single user's public key.

**Usage**

```
ssh-sign-user VALIDITY CA_KEY ID PRINCIPALS SERIAL PUBLIC_KEY [EXTRA]...

Params:
VALIDITY           Certificate validity, e.g. +52w
CA_KEY             CA key file
ID                 Key identity (this will be logged later when authenticating to ssh)
PRINCIPALS         Principals: username for this cert is valid
SERIAL             Certificate serial number
PUBLIC_KEY         Public key, this will be signed
EXTRA              Optional extra params to 'ssh-keygen'
```

---

## ssh-tunnel-close

Close a previously opened SSH tunnel. If opened by `ssh-tunnel-open` you need to give the same params.
Before closing check if still exists and check again after closing to confirm.

**Usage**

```
ssh-tunnel-close [EXTRA]...

Params:
EXTRA              Optional extra params to 'ssh'
```

---

## ssh-tunnel-open

Open an SSH tunnel. This is a general, backend function (this is used by `socks5-tunnel-open`) but can be used on it's own.
Before opening a new tunnel check if already exists and check again after opening to confirm.

**Usage**

```
ssh-tunnel-open [EXTRA]...

Params:
EXTRA              Optional extra params to 'ssh'
```

---

## ssh-view-cert

Inspect a certificate. Print certificate to stdout.

**Usage**

```
ssh-view-cert CERT [EXTRA]...

Params:
CERT               Certificate file
EXTRA              Optional extra params to 'ssh-keygen'
```

---

## unlock-key

Add a password protected SSH key to `ssh-agent` so it can be used in the next 6 hours without prompting for password.
Password is retrieved from [`pass` password manager utility](https://www.passwordstore.org/){target=_blank}.

**Usage**

```
unlock-key KEY PASS_PATH

Params:
KEY                Private key file
PASS_PATH          Path to password in 'pass'
```
