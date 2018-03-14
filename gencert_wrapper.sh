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

echo -en "$CONFIG" > /tmp/config.json

cfssl info \
  -config /tmp/config.json | cfssljson -bare $output-ca

echo -en "$CSR" | cfssl gencert \
  -config /tmp/config.json \
  -profile $profile - | cfssljson -bare $output
