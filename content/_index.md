---
title: UnifiedPush
---

UnifiedPush is a decentralized push notification system that lets you choose the service you want to use. It’s designed to be privacy-friendly, flexible, and open — making it perfect if you want control over your push notifications.

## Quickstart guides:

* [Sunup](/users/distributors/sunup/): A quick and easy way to use UnifiedPush without signing up for an account.
* [ntfy](/users/distributors/ntfy/): A lightweight, open-source push notification service that can be used as a UnifiedPush distributor.
* [Conversations \(XMPP\)](/users/distributors/conversations/): A popular XMPP client that can both distribute and receive UnifiedPush notifications.
* [NextPush](/users/distributors/nextpush/): A push notification service designed for Nextcloud.
* [gCombat-UP](/users/distributors/fcm/): A UnifiedPush distributor that uses Google Services, mainly used for development.

## Key benefits of UnifiedPush:

* **Open standard:** Interoperable and resilient.
* **Decentralized:** Not tied to any single company or service, reducing reliance on gatekeepers.
* **Privacy first:** Push notifications are encrypted.
* **Self-hostable:** Run your own notification server for as much control as you need.
* **User Control:** The user chooses the service they use, not the developers.

## Key features:

* **No privileged services needed:** Use lightweight services and follow least privilege policy. Works on de-Googled Android devices and custom ROMs.
* **Multiple distributors:** Choose from a [list of distributors](/users/distributors/).
* **Easy integration:** Developers can add UnifiedPush support to their apps with minimal effort.

## How it works

### **Step 1: App Sends Notification:**

An app (e.g., a messaging app) sends a short message to your UnifiedPush distributor (e.g. ntfy, NextPush).

### **Step 2. Distributor Delivers Notification:**

The distributor receives the message and forwards it to the targetted application.

### **Step 3. Device Receives Notification:**

The application wakes up and processes the received data, it usually uses the content to show a notification\* on the user interface.

\* This is why it is called a _push notification_.

## Communication

You can reach us on our main chat room on Matrix at [#unifiedpush:matrix.org](https://matrix.to/#/#unifiedpush:matrix.org)

## Funding

This project is funded through [NGI Zero Core](https://nlnet.nl/core), a fund established by [NLnet](https://nlnet.nl) with financial support from the European Commission's [Next Generation Internet](https://ngi.eu) program. Learn more at the [NLnet project page](https://nlnet.nl/project/UnifiedPush).

[<img src="./img/nlnet_banner.png" alt="NLnet foundation logo" width="20%" />](https://nlnet.nl)
[<img src="./img/NGI0_tag.svg" alt="NGI Zero Logo" width="20%" />](https://nlnet.nl/core)

This project has been funded by [COVESA](https://covesa.global).

[<img src="./img/COVESA_tag.jpg" alt="COVESA Logo" width="20%" />](https://covesa.global)
