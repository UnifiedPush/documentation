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

## Requirements

* A Nextcloud server
  * You should be able to install apps on the Nextcloud server.
  * The server needs to have a Redis instance connected to it
  * The server's reverse-proxy should be configurable (to handle timeouts)

## Set Up

* Install this app and the Nextcloud application on your device.
* Connect to a server with the NextPush server-app installed.
* You're ready!

## Self Hosting

You can find more information on how to host the NextPush server app alongside your Nextcloud server on [its repository](https://github.com/UP-NextPush/server-app#readme).
