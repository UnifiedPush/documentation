---
title: Introduction
weight: -10
---

## Definitions TLDR

* A Push Provider, or just Provider, is usually the server that collects these push notifications.
* A Distributor is the app on your device which connects to the Push Provider and forwards the notification contents to the individual apps on your device.

## Setup your own Distributor

As a user of applications implementing UnifiedPush, the first time you're setting up UnifiedPush on your device, you need to do the following.

* Set up a distributor-provider pair. A list of those is available on the [distributors page](/users/distributors/). 

* Unless, the provider is natively compatible with UnifiedPush, it will also need a rewrite proxy that translates UnifiedPush compatible requests to those compatible with the provider. The details about this will be on the distributor page.

## Use FCM as a distributor

Usually, apps using UnifiedPush installed from the Play Store automatically use Google's Firebase Cloud Messaging if no UnifiedPush distributor is detected. If your Application doesn't have the FCM version of the library - due to being installed from F-Droid or the developer not implementing it - you can use the FCM distributor that forwards UnifiedPush to FCM.

You can find the [FCM app here](/users/distributors/fcm).
