---
title: Introduction
weight: -10
---

## Definitions TLDR

* The **Distributor** is the application you install on your device to get notifications. It receives notifications and distributes them to the other applications.
* The (Push) **Provider** is the server reachable from the Internet that listens for incoming notifications for you. The Distributor is connected to the Provider to get the notifications.

## Install a Distributor !

If you want to receive notifications from an app using UnifiedPush, you need a **Distributor**. You can find a list on the [distributors page](/users/distributors). You will probably need to find a **Provider** to connect to, or will need to self host it, depending on your choice of distributor.

### Special Case : the embedded FCM distributor

Some applications using UnifiedPush installed from the Play Store automatically use Google's Firebase Cloud Messaging if no UnifiedPush Distributor is detected.

