---
geekdocHidden: true
geekdocHiddenTocTree: false
title: Sunup - Android
weight: 10
---
[<img alt="Get it on F-Droid" src="/img/f-droid-badge.png" height=100>](https://f-droid.org/en/packages/org.unifiedpush.distributor.sunup/)
[<img alt="Get it on IzzyOnDroid" src="/img/IzzyOnDroid-badge.png" height=100 >](https://apt.izzysoft.de/fdroid/index/apk/org.unifiedpush.distributor.sunup)

We created Sunup as a quick and easy way to use UnifiedPush that doesn’t require signing up for an account. This quickstart guide will walk you through the steps to get it up and running on your Android device.

# Details
* License: Apache2
* Server sources: [https://github.com/mozilla-services/autopush-rs](https://github.com/mozilla-services/autopush-rs)
* Android sources: ~[https://codeberg.org/Sunup/android](https://codeberg.org/Sunup/android)
* Technology: WebSockets

## Sunup quickstart guide
### Step 1: Download Sunup
Download the latest .apk file from one of the following sources:
* [F-Droid](https://f-droid.org/en/packages/org.unifiedpush.distributor.sunup/)
* [IzzyOnDroid](https://apt.izzysoft.de/fdroid/index/apk/org.unifiedpush.distributor.sunup)

### Step 2: Install Sunup
1. Find the downloaded .apk file in your device’s **Downloads** folder (or other folder you saved it to).
2. Tap on the file to begin the installation process.
3. Follow the on-screen prompts to complete the installation.

### Step 3: Configure Sunup
1. Open the **Sunup** app after installation.
2. Grant the necessary permissions (e.g., network access and battery optimization exemptions) to ensure it runs properly in the background.

### Step 4: Set up UnifiedPush in your app(s)
1. Open the app you want to use with UnifiedPush ([check this list for compatible apps](https://unifiedpush.org/users/apps/)).
2. Look for the **Push Notification Settings** or **UnifiedPush Settings** in the app.
3. Select **Sunup** as the UnifiedPush distributer
4. Save the settings, and the app will now use Sunup to deliver push notifications.

### Step 5: Test notifications
1. Trigger a test notification from the app you chose.
2. Ensure that the notification is delivered to your device successfully.
3. The counter next to the app in Sunup will also go up by one every time a notification is sent.  
4. If notifications are not working, check Sunup’s settings and ensure it has the necessary permissions to run in the background.


## Self Hosting

If you want to self host the server, you can find the steps here: <https://codeberg.org/Sunup/android#self-host>

## Funding

This project has been funded by [COVESA](https://covesa.global).

[<img src="../../../img/COVESA_tag.jpg" alt="COVESA Logo" width="20%" />](https://covesa.global)
