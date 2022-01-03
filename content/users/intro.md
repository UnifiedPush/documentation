---
title: Introduction
weight: -10
---

UnifiedPush is a standard for receiving these push notifications.
UnifiedPush allows you to choose between multiple implementations and servers, based on your preferences. The core UnifiedPush tools are all free and open source software.

## Index

{{<toc>}}

## Definitions
* The **Distributor** is the application you install on your device to get notifications. It receives notifications and distributes them to the other applications.
* The (Push) **Provider** is the server reachable from the Internet that listens for incoming notifications for you.
* The **Distributor** is connected to the **Provider** to get the notifications.

## Install a Distributor

### Without self-hosting the server (Easy)

* [Ntfy](/users/distributors/ntfy): You just need to install it.
* [UP-FCM Distributor](/user/distributors/fcm): Idem. Just be aware that it uses Google servers.
* [Gotify](/users/distributors/gotify): You can use an opened to registration server.

### Self-host the server (Difficult)

Self hosting lets you have control of the server through which you receive push notifications. You have several distributor/provider options for self-hosting:

#### [Ntfy](/users/distributors/nextpush)

Ntfy server can be easily be self-hosted. It can be installed with a package, available for most linux distributions, with docker, or using the standalone binary.

#### [NextPush](/users/distributors/nextpush)

NextPush is a push server that can be hosted as a Nextcloud app. This is an easy way to self-host a push provider if you already have a Nextcloud server.

#### [Gotify](/users/distributors/gotify)

Gotify is a server that you can install to send and receive messages, including those of UnifiedPush. It requires additionnal steps to work with unifiedpush.

### Other options

#### [FCM-Distributor](/users/distributors/fcm)

If you have Google services (play store, etc.) on your Android phone, the easiest way is to use FCM-Distributor. However, this means that all your notification data is still being routed through Google.

FCM-Distributor might also be a good option for people whose phone manufacturer has set up [extremely strict battery saving](https://dontkillmyapp.com/).

#### [NoProvider2Push](/users/distributors/np2p)

NoProvider2Push needs a static IP to work, which is reachable with a VPN or public meshing network. It is mostly useful for development purposes and advanced users at this moment.

### Special Case: the embedded FCM distributor

Some applications using UnifiedPush installed from the Play Store automatically use Google's Firebase Cloud Messaging if no UnifiedPush Distributor is detected.
