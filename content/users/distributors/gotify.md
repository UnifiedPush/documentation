---
title: Gotify
---

Gotify is "a simple server for sending and receiving messages".

## Links

* [Android application](https://github.com/gotify/android/tree/unifiedpush)
* [Server](https://github.com/gotify/server)
<!-- TODO F-Droid link? some sort of easy install link -->


The version of the android application working as a distributor is on the [unifiedpush branch](https://github.com/gotify/android/tree/unifiedpush). This version is available on the repo.unifiedpush.org repository.

## Rewrite Proxies

### Nginx
Gotify server needs a new reverse proxy rule to work.
The additional rule is as follows:
```
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

[Golang Rewrite Proxy](https://github.com/karmanyaahm/golang-unified-push-rewrite-proxy) is a program can be installed to run as a rewrite proxy for Gotify.

Traffic from /UP on any reverse proxy running Gotify can be proxied to it. The following is an example for Nginx.

```nginx
location  /UP {    
        proxy_pass            http://127.0.0.1:5000;
}
```

