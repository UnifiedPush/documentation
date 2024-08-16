---
geekdocHidden: true
geekdocHiddenTocTree: true
title: "[Deprecated] Gotify-UP - Android"
weight: 70
---

{{< hint type=caution >}}
**UnifiedPush using Gotify-UP is no longer supported**. It does not support new versions of the UnifiedPush protocol. It will continue working with existing apps, but there are no guarantees.
Check out one of the many other UnifiedPush [distributors](/users/distributors).
{{< /hint >}}

Gotify is "a simple server for sending and receiving messages".

* License: MIT
* Sources: <https://codeberg.org/UnifiedPush/gotify-android/>
* Server: <https://github.com/gotify/server>
* Technology: WebSocket
* Download for Android:

[<img alt="Get it on F-Droid" src="/img/f-droid-badge.png" height=100>](https://f-droid.org/en/packages/com.github.gotify.up)

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
    
    if ($request_method = GET ) { 
        return 200 '{"unifiedpush":{"version":1}}';
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

### Common-Proxies

It can be achieved with [UnifiedPush Common Proxies](https://codeberg.org/UnifiedPush/common-proxies), which is a standalone program that can be installed to run as a rewrite proxy for Gotify. It can also run with docker.
