---
title: Embedded FCM Distributor
---

You may want to make it so that UnifiedPush is invisible for users who aren't specifically trying to avoid FCM. Embedding an FCM Distributor is a solution: if the user doesn't have another distributor installed, this one will be used.

## Installation

You will need to add some code on your android project and host a FCM Rewrite proxy.

### Android

* Add `classpath 'com.google.gms:google-services:4.3.8'` to your project level build.gradle.
* Add `id 'com.google.gms.google-services'` and the following implementation to your app level build.gradle.
```
    implementation('com.github.UnifiedPush:android-embedded_fcm_distributor:2.0.0') {
        exclude group: 'com.google.firebase', module: 'firebase-core'
        exclude group: 'com.google.firebase', module: 'firebase-analytics'
        exclude group: 'com.google.firebase', module: 'firebase-measurement-connector'
    }
```
* Add the google-services.json file from firebase to your app directory.
* Add the receiver to your code:

```kotlin
class EmbeddedDistributor: EmbeddedDistributorReceiver() {
    override fun getEndpoint(context: Context, fcmToken: String, instance: String): String {
        // This returns the endpoint of your FCM Rewrite-Proxy
        return "https://<your.domain.tld>/?v2&instance=$instance&token=$token"
    }
}
```

* Declare it on your Manifest:

```xml
        <receiver android:enabled="true"  android:name=".EmbeddedDistributor" android:exported="false">
            <intent-filter>
                <action android:name="org.unifiedpush.android.distributor.feature.BYTES_MESSAGE"/>
                <action android:name="org.unifiedpush.android.distributor.REGISTER"/>
                <action android:name="org.unifiedpush.android.distributor.UNREGISTER"/>
            </intent-filter>
        </receiver>
```

### FCM Rewrite Proxy

As a developer, if you're using the FCM embedded distributor, you will need a rewrite proxy for FCM-fallback for users who don't have a UnifiedPush Distributor. It is close to the usually needed gateway to FCM or [trusted server](https://firebase.google.com/docs/cloud-messaging/server)

We recommend using the following as the gateway.

[UnifiedPush Common-Proxies](https://github.com/UnifiedPush/common-proxies) is a program can be installed to run as a rewrite proxy for FCM.

Traffic from /FCM on any reverse proxy (for TLS) can be proxied to it. The following is an example for Nginx.

```nginx
location  / {
        proxy_pass            http://127.0.0.1:5000;
}
```
