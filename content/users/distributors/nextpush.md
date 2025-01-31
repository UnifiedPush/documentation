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
* Sources: [https://codeberg.org/NextPush/nextpush-android](https://codeberg.org/NextPush/nextpush-android)
* Server: [https://codeberg.org/NextPush/uppush](https://codeberg.org/NextPush/uppush)
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

### Step 2: Set up NextPush on your Android device
1. Download the Nextcloud Talk app from the [Google Play Store](https://play.google.com/store/apps/details?id=com.nextcloud.talk2) or [F-Droid](https://f-droid.org/en/packages/com.nextcloud.talk2/).
2. Log in to Your Nextcloud Account:
   * Open the NextPush app and log in using your Nextcloud credentials.
   * Enter your Nextcloud server URL (e.g., https://nextcloud.example.com).
3. Enable UnifiedPush:
   * In the NextPush app, go to Settings -> Notifications.
   * Enable UnifiedPush.
   * NextPush will generate a UnifiedPush endpoint URL. Take note of this URL.

### Step 3: Configure apps to use NextPush as a distributor
1. Open the app you want to use with UnifiedPush ([check this list for compatible apps](https://unifiedpush.org/users/apps/)).
2. Look for the **Push Notification Settings** or **UnifiedPush Settings** in the app.
3. Select **NextPush** as the UnifiedPush distributer
4. Save the settings, and the app will now use NextPush to deliver push notifications.

### Step 4: Test notifications
1. Trigger a test notification from the app you chose.
2. Ensure that the notification is delivered to your device successfully.
3. If notifications are not working, check NextPush settings and ensure it has a valid **Push Server** configured.