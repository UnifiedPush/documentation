---
title: NoProvider2Push
---

In its own words
> NoProvider2Push is a UnifiedPush distributor able to provide push notifications without a push provider. For this, it needs a static address even with the roaming. It is achievable with a custom network such as a VPN (eg. wireguard) or the yggdrasil network.

* License: Apache2
* Sources: <https://github.com/NoProvider2Push/android>
* Server: -
* Download for Android:
  * [F-Droid](https://f-droid.org/packages/org.unifiedpush.distributor.noprovider2push/)

## Requirements

* A Static IP on your phone. This is achievable by using a VPN (such as Wireguard) or a meshing network like Yggdrasil.
* A Proxy to reach your phone from Internet. There is no known public proxy at this moment, see [Self Hosting](#self-hosting) to host your own.

## Setting Up

* Install the application.
* Set your static IP and your proxy in the settings.
* You're ready!

## Self Hosting

If you are self-hosting a proxy, you can use one of the following.

### Nginx

```nginx
location /proxy/allowed.address:51515/ {
    proxy_pass                 http://allowed.address:51515/;
    client_max_body_size        50M;
    # Force https
    if ($scheme = http) {
        rewrite ^ https://$server_name$request_uri? permanent;
     }
}
```

### Enqueued Proxy

With this proxy, messages that can't reach your phone will be saved in a database until the phone is reachable again.

For more information, follow this link : <https://github.com/NoProvider2Push/enqueued-proxy>

