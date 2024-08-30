---
title: Embedded FCM Distributor
---

If you want your app to fallback to FCM on Android if: 
  1. Your user doesn't have any UnifiedPush Distributors and
  2. They have Google Services enabled

This is for you. You can embed an FCM Distributor, and if the user doesn't have another distributor, this one will be used. These libraries basically act like UnifiedPush Distributors, but are internal to the app and pass notifications through FCM.

There are 2 libraries doing it: one using the Google Firebase library and another (beta) entirely FOSS[\*](https://en.wikipedia.org/wiki/FOSS "Free and open-source software") that doesn't.

## About

1. The [Android Embedded FCM Distributor](https://codeberg.org/UnifiedPush/android-embedded_fcm_distributor) is the original embedded distributor. It uses the official Google library for FCM support. However, it is proprietary thus cannot be included on app-stores like F-Droid.
1. The [Android FOSS Embedded FCM Distributor](https://codeberg.org/UnifiedPush/android-foss_embedded_fcm_distributor) is a new library. It reimplements the same API that the Google library uses. Since it's open source, it can be used on FOSS app stores like F-Droid.

## Usage

You will need to add some code on your android project and host a FCM Rewrite proxy. For Flutter projects, do the following in the `android` directory.

### Android

{{< tabs "Android" >}}
{{< tab "With google lib." >}}

* Add `classpath 'com.google.gms:google-services:4.4.2'` to your project level build.gradle.
* Add `id 'com.google.gms.google-services'` and the following implementation to your app level build.gradle.

```groovy
    implementation('org.unifiedpush.android:embedded_fcm_distributor:2.5.0') {
        exclude group: 'com.google.firebase', module: 'firebase-core'
        exclude group: 'com.google.firebase', module: 'firebase-analytics'
        exclude group: 'com.google.firebase', module: 'firebase-measurement-connector'
    }
```

* Apply google-services plugin for your fcm flavor in your app level build.gradle. (You may need to edit the pattern)

```groovy
def getCurrentFlavor() {
    Gradle gradle = getGradle()
    String  tskReqStr = gradle.getStartParameter().getTaskRequests().toString()
    String flavor

    Pattern pattern

    if( tskReqStr.contains( "assemble" ) )
        pattern = Pattern.compile("assemble(\\w+)")
    else
        pattern = Pattern.compile("generate(\\w+)")

    Matcher matcher = pattern.matcher( tskReqStr )

    if( matcher.find() ) {
        flavor = matcher.group(1).toLowerCase()
    }
    else
    {
        println "NO MATCH FOUND"
        return ""
    }

    pattern = Pattern.compile("^fcm.*");
    matcher = pattern.matcher(flavor);

    if( matcher.matches() ) {
        return "fcm"
    } else {
        return "main"
    }
}

println("Flavor: ${getCurrentFlavor()}")
if ( getCurrentFlavor() == "fcm" ){
    apply plugin: 'com.google.gms.google-services'
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
{{< tab "(beta) FOSS lib." >}}

* Add the following implementation to your app level build.gradle.
```groovy
    implementation('org.unifiedpush.android:foss-embedded-fcm-distributor:1.0.0')
```
* Add the receiver to your code:

```kotlin
package YOUR.PACKAGE.ID

import android.content.Context
import org.unifiedpush.android.foss_embedded_fcm_distributor.EmbeddedDistributorReceiver

class EmbeddedDistributor: EmbeddedDistributorReceiver() {

    override val googleProjectNumber = "123456789012" // This value comes from the google-services.json

    override fun getEndpoint(context: Context, token: String, instance: String): String {
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

[UnifiedPush Common-Proxies](https://codeberg.org/UnifiedPush/common-proxies) is a program can be installed to run as a rewrite proxy for FCM. If you don't have a server to host this on, ask in the UnifiedPush chat, we can help out.

Traffic from /FCM on any reverse proxy (for TLS) can be proxied to it. The following is an example for Nginx.

```nginx
location  /FCM {
        proxy_pass            http://127.0.0.1:5000;
}
```

## Firebase setup

- Go to https://console.firebase.google.com/

### Create a new project

If you already have a Firebase project, skip this section and just open your project settings.

- Click on 'plus' *Add project* ![See adjacent text](/big_img/fcm_setup/create_proj_1.png)
- Set a name for your project, continue and configure the rest of the project. ![See adjacent text](/big_img/fcm_setup/create_proj_2.png)
- Click on the gear icon and open project settings ![See adjacent text](/big_img/fcm_setup/open_settings_1.png)

### Configure Cloud Messaging

1. Click on the *Cloud Messaging* tab ![See adjacent text](/big_img/fcm_setup/gen_settings_no_app.png)
1. If you already see a server key under *Cloud Messaging API (Legacy)*, then go to step 6.
1. Else, open the menu of this section, and click on *Manage API in Google Cloud Console* ![See adjacent text](/big_img/fcm_setup/cloud_messaging_1.png)
1. In the Cloud Console page that opened, click on *Enable* ![See adjacent text](/big_img/fcm_setup/cloud_messaging_2.png)
1. Go back to the Firebase Cloud Messaging page, and reload it. You should now see a server key. ![See adjacent text](/big_img/fcm_setup/cloud_messaging_3.png)
6. This server key will be used to configure Common Proxies.

### Configure Android app

If you have already added an Android application to your project, skip this section.

1. Click on the Android logo under *Your apps* ![See adjacent text](/big_img/fcm_setup/gen_settings_no_app.png)
1. Enter your Android application's package name. ![See adjacent text](/big_img/fcm_setup/create_app_1.png)
1. Press 'Next', 'Next', 'Continue' and go back to your settings console.

### Setting up your app on Android (FOSS FCM lib)

- Under the menu *Your project*, copy the *Project number*. It is a 12 digit number, for instance `123456789012`.
- Use this value for the [EmbeddedDistributor.googleProjectNumber](#android)

### Setting up your app on Android (Google FCM lib)

- Under the menu *Your apps*, download *google-services.json*.
- Place it at app/google-services.json in your Android project
- If you're using Flutter, place it at android/app/google-services.json 

