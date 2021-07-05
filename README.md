# HProx

Containerized lightweight HTTP/HTTPS proxy server `hprox`

# Features

* Basic HTTP proxy functionality.
* Simple password authentication.
* TLS encryption (requires a valid certificate). Supports TLS 1.3 and HTTP/2, also known as SPDY Proxy.
* TLS SNI validation (blocks all clients with invalid domain name).
* Provide PAC file for easy client side configuration (supports Chrome and Firefox).
* Websocket redirection (compatible with [v2ray-plugin](https://github.com/shadowsocks/v2ray-plugin)).
* Reverse proxy support (redirect requests to a fallback server).
* Implemented as a middleware, compatible with any Haskell Web Application built with `wai` interface.
  Defaults to fallback to a dumb application which simulate the default empty page from Apache.

# Run `hprox`

```
podman run --rm --name hprox -p 8080:8080 romankspb/hprox
```

# Run `hprox` with simple password authentication

```
echo "user:pass" > /opt/hprox/userpass.txt && \
podman run --rm --name hprox -p 8080:8080 -v /opt/hprox/userpass.txt:/opt/hprox/userpass.txt -e HPROX_OPTIONS='-a /opt/hprox/userpass.txt' romankspb/hprox
```

# Documentation

Please see `hprox` repo at https://github.com/bjin/hprox
