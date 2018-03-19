#!/bin/sh
echo -en "$CONFIG" > /tmp/config.json

exec cfssl serve \
  "$@" \
  -config /tmp/config.json
