#! usr/bin/env bash
$domainname = $1

openssl genrsa -des3 -out rootCA.key 4096
openssl req -x509 -new -nodes -key rootCA.key -sha256 -days 1024 -out rootCA.cer
openssl genrsa -out $domainname.key 2048
openssl req -new -key $domainname.key -out $domainname.csr
openssl x509 -req -in $domainname.csr -CA rootCA.cer -CAkey rootCA.key -CAcreateserial -out $domainname.crt -days 500 -sha256