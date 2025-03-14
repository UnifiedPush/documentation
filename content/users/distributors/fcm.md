---
geekdocHidden: true
geekdocHiddenTocTree: false
title: gCompat-UP (Google) - Android
weight: 60
---

gCompat-UP is a distributor that uses Google services. It is mainly design for testing purposes.

[<img alt="Get it on IzzyOnDroid" src="/img/IzzyOnDroid-badge.png" height=100 >](https://apt.izzysoft.de/fdroid/index/apk/org.unifiedpush.distributor.fcm)
[<img alt="Get it on Google Play" src="/img/google-play-badge.png" height=100>](https://play.google.com/store/apps/details?id=org.unifiedpush.distributor.fcm)
[<img alt="Get it on Codeberg" src="/img/codeberg-badge.png" height=100>](https://codeberg.org/UnifiedPush/fcm-distributor/releases)

# Details

* License: Apache2
* Sources: <https://codeberg.org/UnifiedPush/fcm-distributor>
* Server: N/A (Google)

## gCompat-UP quickstart guide

### Step 1: Install gCompat-UP

Install the latest version of the application from one of the following sources:

* [Google Play Store](https://play.google.com/store/apps/details?id=org.unifiedpush.distributor.fcm&hl=en_GB)
* [Direct download](https://codeberg.org/UnifiedPush/fcm-distributor/releases)
* [IzzyOnDroid](https://apt.izzysoft.de/fdroid/index/apk/org.unifiedpush.distributor.fcm#:~:text=This%20is%20an%20UnifiedPush%20Distributor,need%20to%20specify%20any%20server.)

### Step 2: Configure gCompat-UP

1. Open the **gCompat-UP** app after installation.
2. Grant the necessary permissions (e.g., notifications and battery optimization exemptions) to ensure it runs properly in the background.


### Step 3: Set up UnifiedPush in your app(s)

1. Open the app you want to use with UnifiedPush ([check this list for compatible apps](/users/apps/)).
2. Look for the **Push Notification Settings** or **UnifiedPush Settings** in the app.
3. Select **gCompat-UP** as the UnifiedPush distributer
4. Save the settings, and the app will now use gCompat-UP to deliver push notifications.

### Step 4: Test notifications

1. Trigger a test notification from the app you chose.
2. Ensure that the notification is delivered to your device successfully.
3. The counter next to the app in gCompat-UP will also go up by one every time a notification is sent.  
4. If notifications are not working, check gCompat-UP’s settings and ensure it has the necessary permissions to run in the background.
