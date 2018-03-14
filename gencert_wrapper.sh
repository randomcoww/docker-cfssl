#!/bin/sh
while getopts "p:o:" opt; do
  case "$opt" in
    p)
      profile=$OPTARG
      ;;
    o)
      output=$OPTARG
      ;;
  esac
done

echo -en "$CSR" > /tmp/csr.json
echo -en "$CONFIG" > /tmp/config.json

cfssl gencert \
  -config /tmp/config.json \
  -profile $profile /tmp/csr.json | cfssljson -bare $output
