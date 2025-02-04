---
geekdocHidden: true
geekdocHiddenTocTree: false
title: NextPush - Android
weight: 20
---

NextPush is a push server that runs within a Nextcloud instance for easy setup.

* License: AGPL-3.0
* Sources: <https://codeberg.org/NextPush/nextpush-android>
* Server: <https://codeberg.org/NextPush/uppush>
* Technology: HTTP Server Sent Events
* Download for Android:

[<img alt="Get it on F-Droid" src="/img/f-droid-badge.png" height=100>](https://f-droid.org/en/packages/org.unifiedpush.distributor.nextpush/)
[<img alt="Get it on IzzyOnDroid" src="/img/IzzyOnDroid-badge.png" height=100 >](https://apt.izzysoft.de/fdroid/index/apk/org.unifiedpush.distributor.nextpush)
[<img alt="Get it on Codeberg" src="/img/codeberg-badge.png" height=100>](https://codeberg.org/NextPush/nextpush-android/releases)

## Server Requirements

* A Nextcloud server
  * The server needs to have a Redis instance connected to it
  * The server's reverse-proxy should be configurable (to handle timeouts)
  * The server needs to have the [NextPush server app](https://codeberg.org/NextPush/uppush) installed. Follow the instructions in the link to learn how to set it up.

## Set Up Distributor (Android Client)

1. Install and sign into your Nextcloud account using the official Nextcloud Application.
2. Install the NextPush client and sign into your Nextcloud account.
3. Install one application supporting UnifiedPush, or UP-Example. Login into the application if you need to, for instance with your mastodon account or with your matrix account.
4. The application will automatically detect NextPush and use it to send notifications.

