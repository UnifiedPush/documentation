---
title: Embedded FCM Distributor
---

You may want to embedded a FCM distributor to make notifications invisible for many users. Embedding a FCM Distributor is a solution : if the user doesn't have another distributor installed, this one will be used.

## Installation

You will need to add some code on your android project and host a FCM Rewrite proxy.

### Android

* Add `classpath 'com.google.gms:google-services:4.3.8'` to your project level build.gradle.
* Add `id 'com.google.gms.google-services'` and `implementation 'com.github.UnifiedPush:android-embedded_fcm_distributor:{VERSION}'` to your app level build.gradle.
* Add the google-services.json file from firebase to your app directory.
* Add the receiver to your code:

```kotlin

val handlerFCM = object: GetEndpointHandler {
    override fun getEndpoint(context: Context?, token: String, instance: String): String {
        // This returns the endpoint of your FCM Rewrite-Proxy
        return "https://<your.domain.tld>/FCM?instance=$instance&token=$token"
    }
}

class EmbeddedDistrib: EmbeddedDistributorReceiver(handlerFCM) {}
```

* Declare it on your Manifest:

```xml
        <receiver android:enabled="true"  android:name=".EmbeddedDistrib" android:exported="false">
            <intent-filter>
                <action android:name="org.unifiedpush.android.distributor.REGISTER"/>
                <action android:name="org.unifiedpush.android.distributor.UNREGISTER"/>
            </intent-filter>
        </receiver>
```

### FCM Rewrite Proxy

As a developer, if you're using the FCM added version of the libraries, you will need a rewrite proxy for FCM-fallback for users who don't have a UnifiedPush Distributor. It is close to the usually needed gateway to FCM or [trusted server](https://firebase.google.com/docs/cloud-messaging/server)

The rewrite proxy can be done in many ways, here are some.

#### Nginx

```nginx
location /FCM {
    access_by_lua_block{
        local json=require("cjson")
        ngx.req.read_body()
        local args = ngx.req.get_uri_args()
        local token = args["token"]
        local instance = args["instance"]
        local req = ngx.req.get_body_data()
        local newreq =  { ["to"] = token, ["data"] = { ["body"] = req, ["instance"] = instance } }
        local body = json.encode(newreq)
        ngx.req.set_body_data(body)
    }

    proxy_set_header		Authorization key=<YOUR FCM KEY>;
    proxy_set_header		Content-Type application/json;
    proxy_pass			https://fcm.googleapis.com/fcm/send;
    proxy_set_header            Host fcm.googleapis.com;

    # Force https
    if ($scheme = http) {
        rewrite ^ https://$server_name$request_uri? permanent;
     }
}

```

#### Go

[Golang Rewrite Proxy](https://github.com/karmanyaahm/golang-unified-push-rewrite-proxy) is a program can be installed to run as a rewrite proxy for FCM.

Traffic from /FCM on any reverse proxy (for TLS) can be proxied to it. The following is an example for Nginx.

```nginx
location  /FCM {
        proxy_pass            http://127.0.0.1:5000;
}
```
