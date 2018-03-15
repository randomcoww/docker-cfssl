#!/bin/sh
echo -en "$CONFIG" > /tmp/config.json

cfssl serve \
  "$@" \
  -config /tmp/config.json
