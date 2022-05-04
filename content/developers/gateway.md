---
title: Gateway
---

Gateways are ways to convert the application server format of notifications to the UnifiedPush format of notifications. 

Right now, the only gateway that exists is for the Matrix protocol.

## Discovery & Hosting

App developers should host default gateways (otherwise it'll be impossible to use your app with a public push provider), however for some gateways, the user can host their own. This is called **Gateway Discovery**.

## Matrix

Matrix homeservers don't directly support UnifiedPush (yet). This means that a gateway is needed.

Discovery URL: `http(s)://endpoint.domain/_matrix/push/v1/notify` (replace whole path and query with `/_matrix/push/v1/notify`)

Discovery GET response: `{"unifiedpush":{"gateway":"matrix"}}`


### Nginx

Until [MSC2970](https://github.com/matrix-org/matrix-doc/pull/2970) is figured out we unfortunately
need another re-write proxy. 

The one at https://matrix.gateway.unifiedpush.org is publically available, however you can easily self-host it.

Here is a gateway, change the value of `accepted` to the endpoint URL you want to allow, do not forget the last `/` :

```
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

### Common-Proxies

This gateway supports forwarding to any public remote URL with defense against requests to internal networks.

Information on setup is in the documentation for the [Common-Proxies](https://github.com/UnifiedPush/common-proxies)

