---
title: Introduction
weight: -10
---

## Definitions TLDR

* The **Distributor** is the application you install on your device to get notifications. It receives notifications and distribute them to the other applications.
* The (Push) **Provider** is the server reachable from the Internet that listen for incoming notifications for you. The Distributor is connected to the Provider to get the notifications.

## Install a Distributor !

If you want to receive notifications from an app using UnifiedPush, you need a **Distributor**. You can find a list on the [distributors page](/users/distributors). You will probably need to find a **Provider** to connect to, or to self host it, it depends on which you install.

### Special Case : the embedded FCM distributor

Some applications using UnifiedPush installed from the Play Store automatically use Google's Firebase Cloud Messaging if no UnifiedPush Distributor is detected.

