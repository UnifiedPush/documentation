---
geekdocHidden: true
geekdocHiddenTocTree: false
title: gCompat UP-Distributor (Google) - Android
weight: 60
---

gCompat-UP is a distributor that uses Google services. It is mainly design for testing purposes.  This quickstart guide will walk you through the steps to get it up and running on your Android device.
# Details
* License: Apache2
* Sources: [https://codeberg.org/UnifiedPush/fcm-distributor](https://codeberg.org/UnifiedPush/fcm-distributor)
* Server: N/A (Google)

## gCompat UP-Distributor quickstart guide
### Step 1: Enable installation from Unknown Sources
If you’re downloading gCombat-UP via the Google Play Store, you shouldn’t need this step. But if you’re downloading the APK directly, you need to do the following:
1. Open **Settings** on your Android device.
2. Navigate to **Security** or **Apps & Notifications** (depending on your device).
3. Find the option labeled ‘**Install unknown apps**’ or ‘**Unknown sources**’.
4. Enable it for your browser or file manager (e.g., Chrome or Files by Google).

### Step 2: Download gCompat UP-Distributor
Download the latest .apk file from one of the following sources:
* [Google Play Store](https://play.google.com/store/apps/details?id=org.unifiedpush.distributor.fcm&hl=en_GB)
* [Direct download](https://codeberg.org/UnifiedPush/fcm-distributor/releases)
* [IzzyOnDroid](https://apt.izzysoft.de/fdroid/index/apk/org.unifiedpush.distributor.fcm#:~:text=This%20is%20an%20UnifiedPush%20Distributor,need%20to%20specify%20any%20server.)

### Step 3: Install gCompat UP-Distributor (skip step if you used Google Play Store)
1. If you downloaded the APK, locate it in your device’s **Downloads** folder.
2. Tap the APK file to begin installation.
3. Follow the on-screen prompts to complete the installation.
4. Open the **gCompat UP-Distributor** app after installation.

### Step 4: Set up UnifiedPush in your app(s)
1. Open the app you want to use with UnifiedPush ([check this list for compatible apps](https://unifiedpush.org/users/apps/)).
2. Look for the **Push Notification Settings** or **UnifiedPush Settings** in the app.
3. Select **gCompat UP-Distributor** as the UnifiedPush distributer
4. Save the settings, and the app will now use gCompat UP-Distributor to deliver push notifications.

### Step 5: Test notifications
1. Trigger a test notification from the app you chose.
2. Ensure that the notification is delivered to your device successfully.