---
title: Introduction
weight: -10
---

## What is UnifiedPush?

**What are push notifications?** Your mobile device often needs to receive updates from many messaging, and sometimes other apps that provide real-time updates. Without push notifications, each app would need to contact its own server to get updates. This wastes a lot of battery power. So, push notifications were created; they allow you to receive updates from multiple apps using one network connection by routing everything through a single server. 

UnifiedPush is a standard for receiving these push notifications.
UnifiedPush allows you to choose between multiple implementations and servers, based on your preferences. The core UnifiedPush tools are all free and open source software.

### Definitions
* The **Distributor** is the application you install on your device to get notifications. It receives notifications and distributes them to the other applications.
* The (Push) **Provider** is the server reachable from the Internet that listens for incoming notifications for you.
* The **Distributor** is connected to the **Provider** to get the notifications.

## Install a Distributor

### Easy - Use UnifiedPush hosted server

1. Install [the Gotify-UP app](../distributors/gotify)   
    Note: `Gotify-UP` is different from `Gotify` as the latter doesn't support UnifiedPush.
2. Visit <https://gotify1.unifiedpush.org> and click on `Register`. Sign up with a username and secure password.
3. Open the Gotify-UP app on your device, and login with those credentials.
4. Now, you should be able to open any [apps supporting UnifiedPush](../apps), and should be able to receive push notifications!
  * Note: if an app asks you which push distributor you want, you can now pick Gotify (though it probably shouldn't ask you).

### Difficult - Self Host the server

The lets you have control of the server through which you receive push notifications. You have several distributor/provider options for self-hosting:

#### [NextPush](../distributors/nextpush)

NextPush is a push server that can be hosted as a Nextcloud app. This is an easy way to self-host a push provider if you already have a Nextcloud server.

#### [Gotify](../distributors/gotify)

Gotify is a simple server that you can install to send and receive messages, including those of UnifiedPush.

### Other options

#### [FCM-Distributor](../distributors/fcm)

If you have Google services (play store, etc.) on your Android phone, the easiest way is to use FCM-Distributor. However, this means that all your notification data is still being routed through Google.

FCM-Distributor might also be a good option for people whose phone manufacturer has set up [extremely strict battery saving](https://dontkillmyapp.com/).

#### [NoProvider2Push](../distributors/np2p)

NoProvider2Push needs a static IP to work, which is reachable with a VPN or public meshing network. It is mostly useful for development purposes and advanced users at this moment.

### Special Case: the embedded FCM distributor

Some applications using UnifiedPush installed from the Play Store automatically use Google's Firebase Cloud Messaging if no UnifiedPush Distributor is detected.
