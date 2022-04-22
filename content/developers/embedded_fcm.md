---
title: Embedded FCM Distributor
---

If you want your app to fallback to FCM on Android if: 
  1. Your user doesn't have any UnifiedPush Distributors and
  2. They have Google Services enabled

This is for you. You can embed an FCM Distributor, and if the user doesn't have another distributor, this one will be used. These libraries basically act like UnifiedPush Distributors, but are internal to the app and pass notifications through FCM.

There are 2 libraries doing it: one using the Google Firebase library and another entirely FOSS[\*](https://en.wikipedia.org/wiki/FOSS "Free and open-source software") that doesn't.

## About

1. The [Android Embedded FCM Distributor](https://github.com/UnifiedPush/android-embedded_fcm_distributor) is the original embedded distributor. It uses the official Google library for FCM support. However, it is proprietary thus cannot be included on app-stores like F-Droid.
1. The [Android FOSS Embedded FCM Distributor](https://github.com/UnifiedPush/android-foss_embedded_fcm_distributor) is a new library. It reimplements the same API that the Google library uses. Since it's open source, it can be used on FOSS app stores like F-Droid.

## Usage

You will need to add some code on your android project and host a FCM Rewrite proxy. For Flutter projects, do the following in the `android` directory.

### Android

{{< tabs "Android" >}}
{{< tab "FOSS lib." >}}

* Add the following implementation to your app level build.gradle.
```
    implementation('com.github.UnifiedPush:android-foss_embedded_fcm_distributor:1.0.0-beta1')
```
* Add the receiver to your code:

```kotlin
class EmbeddedDistributor: EmbeddedDistributorReceiver() {

    override val googleProjectNumber = "123456" // This value comes from the google-services.json

    override fun getEndpoint(context: Context, fcmToken: String, instance: String): String {
        // This returns the endpoint of your FCM Rewrite-Proxy
        return "https://<your.domain.tld>/FCM?v2&instance=$instance&token=$token"
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

{{< /tab >}}
{{< tab "With google lib." >}}

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
        return "https://<your.domain.tld>/FCM?v2&instance=$instance&token=$token"
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

{{< /tab >}}
{{< /tabs >}}
### FCM Rewrite Proxy

As a developer, if you're using the FCM embedded distributor, you will need a rewrite proxy for FCM-fallback for users who don't have a UnifiedPush Distributor. It is close to the usually needed gateway to FCM or [trusted server](https://firebase.google.com/docs/cloud-messaging/server)

We recommend using the following as the gateway.

[UnifiedPush Common-Proxies](https://github.com/UnifiedPush/common-proxies) is a program can be installed to run as a rewrite proxy for FCM.

Traffic from /FCM on any reverse proxy (for TLS) can be proxied to it. The following is an example for Nginx.

```nginx
location  /FCM {
        proxy_pass            http://127.0.0.1:5000;
}
```
