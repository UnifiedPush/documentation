---
title: Gotify
---

Gotify is "a simple server for sending and receiving messages".

* License: MIT
* Sources: <https://github.com/UnifiedPush/gotify-android/>
* Server: <https://github.com/gotify/server>
* Download for Android:
  * [F-Droid](https://f-droid.org/de/packages/com.github.gotify/) ⚠️  **You need to add the** [unifiedpush repo](https://repo.unifiedpush.org) **first!** ⚠️

## Requirements

* A server to connect to. A server is open to registration at <https://gotify1.unifiedpush.org>, though it is recommended to host your own so your data stays private and the public server doesn't overload.

## Setting Up

* Install the application.
* Connect to the server.
* You're ready!

## Self Hosting

If you are self-hosting the server, you will need to add a rewrite-proxy to the default configuration.

### Nginx

It can be achieved with the following nginx rule (which uses lua):

```nginx
location /UP {
    access_by_lua_block{
        local json=require("cjson")
        ngx.req.read_body()
        local req = ngx.req.get_body_data()
        local newreq = { ["message"] = req }
        local body = json.encode(newreq)
        ngx.req.set_body_data(body)
    }

    proxy_set_header        Content-Type application/json;
    proxy_pass            http://127.0.0.1:8080/message;
    proxy_set_header            Host $host;

    # Force https
    if ($scheme = http) {
        rewrite ^ https://$server_name$request_uri? permanent;
     }
}
```

### Go

It can be achieved with [Golang Rewrite Proxy](https://github.com/UnifiedPush/common-proxies), a program that can be installed to run as a rewrite proxy for Gotify.

Traffic from /UP on any reverse proxy running Gotify can be proxied to it. The following is an example for Nginx.

```nginx
location  /UP {
        proxy_pass            http://127.0.0.1:5000;
}
```
