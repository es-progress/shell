# Certificate

Functions for managing X509 certificates & keys. It essentially serves as a wrapper for `openssl`.

These functions offer a way to set up your own Certificate Authority (CA) and issue [X509 Certificates](https://en.wikipedia.org/wiki/X.509){target=\_blank} (a standard defining the format of public key certificates) on your behalf which are useful for TLS (Transport Layer Security).
Only your Root CA certificate needs to be trusted by clients, and all your issued certificates will be trusted too.
It may not be trusted by anyone except you. So it can't be used for public sites. However, it's great for internal use and Dev/CI environments.

---

## cert-create

Create an X509 certificate by combining `csr-create` and `csr-sign`.
Use the subject to insert any details about the site.

Subject example: `/C=CountryCode/ST=State/L=City/O=Your Company/CN=Your site URL`.

**Usage**

```
cert-create KEY SUBJECT CA_KEY CA_CERT CERT VALIDITY

Params:
KEY                Filename of private key
SUBJECT            Certificate subject
CA_KEY             Filename of CA private key to sign a certificate with
CA_CERT            Filename of CA certificate to be used for signing
CERT               Filename for newly created certificate
VALIDITY           Certificate validity in days
```

---

## cert-key

Create a 4096-bit RSA private key.

**Usage**

```
cert-key KEY [EXTRA]...

Params:
KEY                Filename to write the newly created private key to
EXTRA              Optional extra params to 'openssl-genpkey'
```

---

## cert-selfsigned

Create self-signed certificate. This could be used as a Root CA certificate.
Use the subject to insert any details about the certificate.

Subject example: `/C=CountryCode/ST=State/L=City/O=ACME Company/CN=ACME Root CA`.

**Usage**

```
cert-selfsigned KEY CERT VALIDITY SUBJECT [EXTRA]...

Params:
KEY                Filename of private key
CERT               Filename for newly created certificate
VALIDITY           Certificate validity in days
SUBJECT            Certificate subject
EXTRA              Optional extra params to 'openssl-req'
```

---

## cert-view

Inspect a certificate. Print certificate to stdout.

**Usage**

```
cert-view CERT [EXTRA]...

Params:
CERT               Path to certificate
EXTRA              Optional extra params to 'openssl-x509'
```

---

## csr-create

Create a Certificate Signing Request (CSR).
Use the subject to insert any details about the site.

Subject example: `/C=CountryCode/ST=State/L=City/O=Your Company/CN=Your site URL`.

**Usage**

```
csr-create KEY CSR SUBJECT [EXTRA]...

Params:
KEY                Filename to write the newly created private key to
CSR                Filename for newly created CSR
SUBJECT            Certificate subject
EXTRA              Optional extra params to 'openssl-req'
```

---

## csr-sign

Sign a Certificate Signing Request (CSR).

**Usage**

```
csr-sign CA_KEY CA_CERT CSR CERT VALIDITY [EXTRA]...

Params:
CA_KEY             Filename of CA private key to sign a certificate with
CA_CERT            Filename of CA certificate to be used for signing
CSR                Filename of CSR to sign
CERT               Filename for newly created signed CSR (which is a certificate now)
VALIDITY           Certificate validity in days
EXTRA              Optional extra params to 'openssl-x509'
```

---

## csr-view

Inspect a Certificate Signing Request (CSR). Print CSR to stdout.

**Usage**

```
csr-view CSR [EXTRA]...

Params:
CSR                Path to CSR to check
EXTRA              Optional extra params to 'openssl-req'
```
