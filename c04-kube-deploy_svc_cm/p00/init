#!/bin/bash

apt-get update -y
apt-get install -y vim curl pv cmatrix jq
curl -Ls https://github.com/tmate-io/tmate/releases/download/2.4.0/tmate-2.4.0-static-linux-amd64.tar.xz |
  tar -P --xform='s|.*\/|/usr/local/bin/|' -C / -Jxvf -
