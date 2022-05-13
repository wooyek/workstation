#!/usr/bin/env bash

echo "----> mitmproxy"
echo "----> https://docs.mitmproxy.org/stable/"


echo "Dumping mitmproxy certificates"
docker run -d -v ~/.mitmproxy:/home/mitmproxy/.mitmproxy:rw mitmproxy/mitmproxy mitmdump
tree ~/.mitmproxy

CERT=$(openssl x509 -in ~/.mitmproxy/mitmproxy-ca.pem -inform PEM)
echo $CERT




CERT_PATH=$(python -m certifi)
export HTTP_PROXY=http://localhost:9001
export HTTPS_PROXY=https://localhost:9001
export http_proxy=$HTTP_PROXY
export https_proxy=$HTTPS_PROXY
export SSL_CERT_FILE=${CERT_PATH}
export REQUESTS_CA_BUNDLE=${CERT_PATH}


docker run --rm -it \
	-v ~/.mitmproxy:/home/mitmproxy/.mitmproxy:rw \
	-p 9001:9001 \
	--network adverity \
	--net-alias=mitmproxy \
	--set ssl_insecure=true \
	mitmproxy/mitmproxy \
	mitmproxy --listen-port=9001
