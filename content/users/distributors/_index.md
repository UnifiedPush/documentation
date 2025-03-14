---
title: Distributors
weight: -10

aliases : ["intro"]
---

{{< toc-tree >}}

---

In order to use UnifiedPush, you need to choose a distributor to use. A distributor is the app that serves as the middle-man that receives the app notification and pushes it to your phone. Think of it as a privacy-friendly postman for your notifications.

Central to the distributor is the **push server**, which is the backend system that receives notifications from an app and sends it to the distributor. It’s the starting point for delivering notifications to your device, and you often have a choice of using the distributor's default push server, or hosting your own.

## Default push server

The quickest and easiest way to do this is to use one of these distributors, and using their default push server:

* [Sunup - Quickstart guide](/users/distributors/sunup/)
* [ntfy - Quickstart guide](/users/distributors/ntfy/)
* [gCombat UP-Distributor - Quickstart guide](/users/distributors/fcm/)

## Self-hosted push server

Alternatively, you can host your own push server, giving you full control and ownership over the push notifications. The downside is the complexity and time in getting up and running, so it depends on how important complete control is to you.

Here are the options available for self-hosting your own push server:

* [ntfy:](/users/distributors/ntfy/) The ntfy server can easily be [self-hosted](https://docs.ntfy.sh/install/). It can be installed with a package, available for most Linux distributions, with Docker, or using the standalone binary.
* [NextPush:](/users/distributors/nextpush/) NextPush is a push server that can be hosted as a Nextcloud app. This is an easy way to self-host a push server if you already have a Nextcloud server.
* [Conversations \(XMPP\):](/users/distributors/conversations/) Conversations is an XMPP instant messaging client for Android, with the ability to deliver UnifiedPush notifications using an existing XMPP account, on any server. This requires converting push notifications to XMPP messages first, which is done by a service hosted at up.conversations.im. The service at up.conversations.im can also be self-hosted. It is called a rewrite proxy in UnifiedPush parlance.
* [Sunup:](/users/distributors/sunup/) Sunup uses Mozilla’s autopush-rs server. It can be self-hosted with or without docker. Steps are summarized on Sunup Readme. The project doesn’t contain built-in gateway (eg. for matrix).
