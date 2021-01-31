---
title: FCM (Google)
weight: 10
---

This is Google's default push provider for Android.

Usually, apps using UnifiedPush installed from the Play Store automatically use Google's Firebase Cloud Messaging if no UnifiedPush distributor is detected. If your Application doesn't have the FCM version of the library - due to being installed from F-Droid or the developer not implementing it - you can use the FCM distributor that forwards UnifiedPush to FCM.

You can find the FCM distributor app on the F-Droid repo at <https://repo.unifiedpush.org/>.
