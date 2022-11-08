---
title: Gateway

aliases: ["/developers/gateway/"]
---

Gateways are ways to convert the application server format of notifications to the UnifiedPush format of notifications. 

Right now, the only gateway that exists is for the Matrix protocol.

## Discovery & Hosting

App developers should host default gateways (otherwise it'll be impossible to use your app with a public push provider), however for some gateways, the user can host their own. This is called **Gateway Discovery**.

## Matrix

Matrix homeservers don't directly support UnifiedPush (yet). This means that a gateway is needed.

**All Matrix applications have defined a default gateway that will forward notifications to your push provider's server. You can use your own matrix gateway instead if you host your push service provider's server yourself and also want to host the gateway yourself.**

Discovery URL: `http(s)://endpoint.domain/_matrix/push/v1/notify` (replace whole path and query with `/_matrix/push/v1/notify`)

Discovery GET response: `{"unifiedpush":{"gateway":"matrix"}}`

### Built-in provider gateway

**Recommended**

Some providers come with a built-in matrix gateway :

* [ntfy](/users/distributors/ntfy/)

* [NextPush](/users/distributors/nextpush/) You need to setup a rule on your reverse proxy. More information at <https://github.com/UP-NextPush/server-app#gateways>

### Common-Proxies

**Recommended, if your provider does not have a built-in gateway or you want to host a public gateway**

Common-Proxies is a set of rewrite proxies and push gateways for UnifiedPush. It can be used as a matrix gateway. If needed, it supports forwarding to any public remote URL with defense against requests to internal networks.

Information on setup is in the documentation for the [Common-Proxies](https://github.com/UnifiedPush/common-proxies)

### Nginx

**Not recommended**

It is possible to do a personnal matrix gateway with nginx compiled with lua support.

Change the value of `accepted` to the endpoint URL you want to allow, do not forget the last `/` :

```nginx
resolver 127.0.0.1;

location /_matrix/push/v1/notify {
  mirror /mx-mirror;
  mirror_request_body on; 
  if ($request_method = GET ) { 
    return 200 '{"unifiedpush":{"gateway":"matrix"}}';
  }
  proxy_pass https://$server_name/mx-upstream;
}

location /mx-upstream {
  return 200 '{"rejected":[]}';
}

location /mx-mirror {
  internal;
  set $target ''; 
  rewrite_by_lua_block {
    local cjson = require("cjson")
    ngx.req.read_body()
    local body = ngx.req.get_body_data()
    local parsedBody = cjson.decode(body)
    local accepted = "https://relay.example.tld/"
    ngx.var.target = parsedBody["notification"]["devices"][1]["pushkey"]
    ngx.req.set_body_data(body)
    if(string.sub(ngx.var.target,1,string.len(accepted))~=accepted) then ngx.var.target="http://0.0.0.0/"
    end 
  }
  proxy_set_header Content-Type application/json;
  proxy_set_header Host $host;
  proxy_pass $target;
}

```
