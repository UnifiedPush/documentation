---
title: FCM Rewrite Proxy
weight: 10
---

As a developer, if you're using the FCM added version of the libraries, you will need a rewrite proxy for FCM-fallback for users who don't have a UnifiedPush Distributor. It is close to the ususal needed gateway to FCM or [trusted server](https://firebase.google.com/docs/cloud-messaging/server)

The rewrite proxy can be done in many ways, here are some.

## Nginx

```nginx
location /FCM {
    access_by_lua_block{
        ngx.req.read_body()
        local args = ngx.req.get_uri_args()
        local token = args["token"]
        local req = ngx.req.get_body_data()
        local newreq, n, err = ngx.re.gsub(req, '\\\\', '\\\\')
        local newreq, n, err = ngx.re.gsub(newreq, '"', '\\"')
        local newreq, n, err = ngx.re.gsub(newreq, "^", "{\"to\":\"" .. token .. "\",\"data\":{\"body\":\"")
        local newreq, n, err = ngx.re.gsub(newreq, "$", "\"}}")
        ngx.req.set_body_data(newreq)
    }
    proxy_set_header        Authorization key=<SERVER_KEY>;
    proxy_set_header        Content-Type application/json;
    proxy_pass              https://fcm.googleapis.com/fcm/send;
    proxy_set_header        Host fcm.googleapis.com;

    # Force https
    if ($scheme = http) {
        rewrite ^ https://$server_name$request_uri? permanent;
    }
}
```

## Go

[Golang Rewrite Proxy](https://github.com/karmanyaahm/golang-unified-push-rewrite-proxy) is a program can be installed to run as a rewrite proxy for FCM.

Traffic from /FCM on any reverse proxy (for TLS) can be proxied to it. The following is an example for Nginx.

```nginx
location  /FCM {    
        proxy_pass            http://127.0.0.1:5000;
}
```

