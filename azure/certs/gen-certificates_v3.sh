#! /usr/bin/env bash
read -p "Enter client name: " clientname

FILE=private/ca.key
if [ ! -f "$FILE" ]; then
  openssl genrsa -des3 -out private/ca.key 1024
  openssl req -new -x509 -key private/ca.key -out public/ca.crt -days 365
  openssl genrsa -des3 -out private/server.key 1024
  openssl req -new -key private/server.key -out server.csr
  openssl x509 -req -days 360 -in server.csr -CA public/ca.crt -CAkey private/ca.key -CAcreateserial -out public/server.crt
fi

openssl req -new -newkey rsa:1024 -nodes -out client/$clientname.req -keyout client/$clientname.key
openssl x509 -CA public/ca.crt -CAkey private/ca.key -CAserial public/ca.srl -req -in client/$clientname.req -out client/$clientname.pem -days 100
openssl pkcs12 -export -clcerts -in client/$clientname.pem -inkey client/$clientname.key -out client/$clientname.pfx -name Ujwol