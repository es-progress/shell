# shellcheck shell=bash
###################################
## ES-Ubuntu                     ##
##                               ##
## Certificate Functions Library ##
##                               ##
## Managing certificates & keys  ##
## Wrapper for openssl           ##
###################################

# Create private key
#
# @param    $1  Key path
########################
cert-create-key(){
    local key="${1?:"Key path missing"}"
    shift
    openssl genpkey \
        -aes-256-cbc \
        -algorithm rsa \
        -pkeyopt rsa_keygen_bits:4096 \
        -out "${key}" "${@}"
}

# Create self-signed certificate
#
# @param    $1  Private key path
# @param    $2  Certificate path
# @param    $3  Validity in days
# @param    $4  Certificate subject
###################################
cert-create-selfsigned(){
    local priv_key="${1?:"Private key path missing"}"
    local cert="${2?:"Certificate path missing"}"
    local validity="${3?:"Valid days missing"}"
    local subject="${4?:"Certificate subject missing"}"
    shift 4
    openssl req \
        -new \
        -x509 \
        -sha512 \
        -extensions v3_ca \
        -addext "keyUsage=critical,keyCertSign,cRLSign" \
        -key "${priv_key}" \
        -out "${cert}" \
        -days "${validity}" \
        -subj "${subject}" "${@}"
}

# Create Certificate Signing Request (CSR)
#
# @param    $1  Private key path
# @param    $2  CSR path
# @param    $3  CSR subject
##########################################
cert-create-csr(){
    local priv_key="${1?:"Private key path missing"}"
    local csr="${2?:"CSR path missing"}"
    local subject="${3?:"CSR subject missing"}"
    shift 3
    openssl req \
        -new \
        -sha512 \
        -newkey rsa:4096 \
        -nodes \
        -keyout "${priv_key}" \
        -out "${csr}" \
        -subj "${subject}" "${@}"
}

# Sign Certificate Signing Request (CSR)
#
# @param    $1  CA private key path
# @param    $2  CA cert path
# @param    $3  CSR path
# @param    $4  Certificate path
# @param    $5  Validity in days
##########################################
cert-sign-csr(){
    local ca_priv_key="${1?:"CA private key path missing"}"
    local ca_cert="${2?:"CA cert path missing"}"
    local csr="${3?:"CSR path missing"}"
    local cert="${4?:"Certificate path missing"}"
    local validity="${5?:"Valid days missing"}"
    shift 5

    local tmp_config=$(mktemp)
    cat <<EOF >>"${tmp_config}"
basicConstraints=critical,CA:false
keyUsage=critical,digitalSignature,keyEncipherment
extendedKeyUsage=serverAuth,clientAuth
subjectKeyIdentifier=hash
authorityKeyIdentifier=keyid,issuer
EOF

    openssl x509 \
        -req \
        -sha512 \
        -extfile "${tmp_config}" \
        -CAkey "${ca_priv_key}" \
        -CA "${ca_cert}" \
        -CAcreateserial \
        -in "${csr}" \
        -out "${cert}" \
        -days "${validity}" "${@}"
}

# Create site certificate
#
# @param    $1  Private key path
# @param    $2  CSR subject
# @param    $3  CA private key path
# @param    $4  CA cert path
# @param    $5  Certificate path
# @param    $6  Validity in days
###################################
cert-create-certificate(){
    local priv_key="${1?:"Private key path missing"}"
    local subject="${2?:"CSR subject missing"}"
    local ca_priv_key="${3?:"CA private key path missing"}"
    local ca_cert="${4?:"CA cert path missing"}"
    local cert="${5?:"Certificate path missing"}"
    local validity="${6?:"Valid days missing"}"

    local csr=$(mktemp)
    cert-create-csr "${priv_key}" "${csr}" "${subject}"
    cert-sign-csr "${ca_priv_key}" "${ca_cert}" "${csr}" "${cert}" "${validity}"
}

# Check CSR
#
# @param    $1  CSR path
########################
cert-view-csr(){
    local csr="${1?:"CSR path missing"}"
    shift
    openssl req \
        -noout \
        -text \
        -in "${csr}" "${@}"
}

# Check Certificate
#
# @param    $1  Cert path
#########################
cert-view-cert(){
    local cert="${1?:"Certificate path missing"}"
    shift
    openssl x509 \
        -noout \
        -text \
        -in "${cert}" "${@}"
}
