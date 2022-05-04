---
geekdocHidden: true
geekdocHiddenTocTree: false
title: NextPush - Android
weight: 20
---

NextPush is a push provider that runs within a Nextcloud instance for easy setup.

* License: AGPL-3.0
* Sources: <https://github.com/UP-NextPush/android>
* Server: <https://github.com/UP-NextPush/server-app>
* Technology: HTTP Server Sent Events
* Download for Android:

[<img alt="Get it on F-Droid" src="/img/f-droid-badge.png" height=100>](https://f-droid.org/en/packages/org.unifiedpush.distributor.nextpush/)

## Server Requirements

* A Nextcloud server
  * The server needs to have a Redis instance connected to it
  * The server's reverse-proxy should be configurable (to handle timeouts)
  * The server needs to have the [NextPush server app](https://github.com/UP-NextPush/server-app) installed. Follow the instructions in the link to learn how to set it up.

## Set Up Client (Android)

* Install this app and the Nextcloud application on your device.
* Connect to a server with the NextPush server-app installed.
* You're ready!

1. Install and sign into your Nextcloud account using the official Nextcloud app.
2. Install the NextPush client and sign into you Nextcloud account.
3. Install and run one of the apps supporting UnifiedPush.
4. Everything should automatically work!
4. If notifications do not work, check out [the troubleshooting page](/users/troubleshooting/).
