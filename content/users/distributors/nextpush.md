---
geekdocHidden: true
geekdocHiddenTocTree: false
title: NextPush - Android
weight: 20
---

[<img alt="Get it on F-Droid" src="/img/f-droid-badge.png" height=100>](https://f-droid.org/en/packages/org.unifiedpush.distributor.nextpush/)
[<img alt="Get it on IzzyOnDroid" src="/img/IzzyOnDroid-badge.png" height=100 >](https://apt.izzysoft.de/fdroid/index/apk/org.unifiedpush.distributor.nextpush)
[<img alt="Get it on Codeberg" src="/img/codeberg-badge.png" height=100>](https://codeberg.org/NextPush/nextpush-android/releases)

NextPush is a push notification service designed for Nextcloud, allowing you to receive notifications from your Nextcloud server.

# Details

* License: AGPL-3.0
* Sources: <https://codeberg.org/NextPush/nextpush-android>
* Server: <https://codeberg.org/NextPush/uppush>
* Technology: HTTP Server Sent Events

## NextPush quickstart guide

### Step 1: Install NextPush on your Nextcloud server

1. Log in to Your Nextcloud Admin Account:
   * Access your Nextcloud instance as an administrator.
2. Go to the App Store:
   * Navigate to Apps in the Nextcloud menu.
3. Download the [UnifiedPush provider app](https://apps.nextcloud.com/apps/uppush).
4. Install NextPush:
   * Click Download and Enable to install the NextPush app.
5. Configure NextPush as a UnifiedPush Distributor:
   * Go to Settings > Administration > NextPush.
   * Enable the UnifiedPush Distributor option.
   * Save the settings.

### Step 2: Install NextPush on your Android device

Install the latest version of the application from one of the following sources:

* [F-Droid](https://f-droid.org/en/packages/org.unifiedpush.distributor.nextpush/)
* [IzzyOnDroid](https://apt.izzysoft.de/fdroid/index/apk/org.unifiedpush.distributor.nextpush)
* [Direct download](https://codeberg.org/NextPush/nextpush-android/releases)

### Step 3: Configure NextPush

1. Open the **NextPush** app after installation.
2. Login to your Nextcloud account:
    * If you have **Nextcloud File** appliation installed, you can login with the Nextcloud File application, or with a manual login
    * To login manually, tap "Manual login" and inform your server URL, your username and an application password. To create an application password, on your nextcloud website, go to Settings > Security > Add an "App name" and "Create new app password".
2. Grant the necessary permissions (e.g., notifications and battery optimization exemptions) to ensure it runs properly in the background.

### Step 3: Set up UnifiedPush in your app(s)

1. Open the app you want to use with UnifiedPush ([check this list for compatible apps](/users/apps/)).
2. Look for the **Push Notification Settings** or **UnifiedPush Settings** in the app.
3. Select **NextPush** as the UnifiedPush distributer
4. Save the settings, and the app will now use NextPush to deliver push notifications.

### Step 4: Test notifications

1. Trigger a test notification from the app you chose.
2. Ensure that the notification is delivered to your device successfully.
3. The counter next to the app in NextPush will also go up by one every time a notification is sent.  
4. If notifications are not working, check NextPush’s settings and ensure it has the necessary permissions to run in the background.
