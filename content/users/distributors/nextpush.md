---
title: NextPush
---

NextPush is a push provider that runs within a Nextcloud instance for easy setup.

* License: AGPL-3.0
* Sources: <https://github.com/UP-NextPush/android>
* Server: <https://github.com/UP-NextPush/server-app>
* Download for Android: <span class=app-store-logos>{{< figure alt="Get it on IzzyOnDroid" src="/img/IzzyOnDroid.png" link="https://apt.izzysoft.de/fdroid/index/apk/org.unifiedpush.distributor.nextpush" >}}</span>
* Technology: HTTP Server Sent Events

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
