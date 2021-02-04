---
title: Gotify
---

Gotify is "a simple server for sending and receiving messages".

* License: MIT
* Sources: <https://github.com/gotify/android/tree/unifiedpush>
* Server: <https://github.com/gotify/server>
* Download for Android:
  * [F-Droid](https://f-droid.org/de/packages/com.github.gotify/) ⚠️  **You need to add the** [unifiedpush repo](https://repo.unifiedpush.org) **first!** ⚠️

## Requirements

* A server to connect to. There is, at this moment, no server opened to registration. But if you can't self-host yours, come on matrix (or IRC) unifiedpush room to ask if someone can create an account for you. Maybe someone will!

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
        ngx.req.read_body()
        local req = ngx.req.get_body_data()
        local newreq, n, err = ngx.re.gsub(req, '\\\\', '\\\\')
        local newreq, n, err = ngx.re.gsub(newreq, '"', '\\"')
        local newreq, n, err = ngx.re.gsub(newreq, "^", "{\"message\":\"")
        local newreq, n, err = ngx.re.gsub(newreq, "$", "\"}")
        ngx.req.set_body_data(newreq)
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

It can be achieved with [Golang Rewrite Proxy](https://github.com/karmanyaahm/golang-unified-push-rewrite-proxy), a program that can be installed to run as a rewrite proxy for Gotify.

Traffic from /UP on any reverse proxy running Gotify can be proxied to it. The following is an example for Nginx.

```nginx
location  /UP {    
        proxy_pass            http://127.0.0.1:5000;
}
```

