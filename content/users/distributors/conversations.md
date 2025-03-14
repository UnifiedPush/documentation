---
geekdocHidden: true
geekdocHiddenTocTree: false
title: Conversations (XMPP) - Android
weight: 20
---

[<img alt="Get it on F-Droid" src="/img/f-droid-badge.png" height=100 >](https://f-droid.org/en/packages/eu.siacs.conversations/)
[<img alt="Get it on Google Play" src="/img/google-play-badge.png" height=100>](https://play.google.com/store/apps/details?id=eu.siacs.conversations&pcampaignid=web_share)

Conversations is a popular XMPP client that can serve as a UnifiedPush distributor. This quickstart guide will walk you through the steps to get Conversations working with UnifiedPush.

# Details

* License: GPLv3
* Sources: <https://codeberg.org/iNPUTmice/Conversations>
* Server: Your XMPP Server with a Rewrite Proxy
* Technology: XMPP

## Conversations quickstart guide

### Step 1: Install Conversations

Install the latest version of the application from one of the following sources:

* [Google Play Store](https://play.google.com/store/apps/details?id=eu.siacs.conversations&pcampaignid=web_share)
* [F-Droid](https://f-droid.org/en/packages/eu.siacs.conversations/)

### Step 2: Set up your XMPP account

1. Open the Conversations app.
2. If you already have an XMPP account, enter your credentials (username, password, and server address).
3. If you don’t have an XMPP account, you can create one directly in the app or use a provider like:
    * [jabber.de](https://www.jabber.de/)
    * [xmpp.jp](https://xmpp.jp/)
    * [prosody.net](https://prosody.net/)
4. Complete the setup and log in.

### Step 3: Enable UnifiedPush for your XMPP account

1. Open **Conversations** and go to **Settings**.
2. Navigate to **UnifiedPush Distributor**.
3. Select **XMPP Account**
4. Select your XMPP account
5. Now push notifications for this account will use UnifiedPush

### Step 4: Set up UnifiedPush in your app(s)

1. Open the app you want to use with UnifiedPush ([check this list for compatible apps](/users/apps/)).
2. Look for the **Push Notification Settings** or **UnifiedPush Settings** in the app.
3. Select **Conversation** as the UnifiedPush distributer
4. Save the settings, and the app will now use Conversation to deliver push notifications.

### Step 5: Test notifications

1. Trigger a test notification from the app you chose.
2. Ensure that the notification is delivered to your device successfully.

## Self-host (optional)

In addition to a regular XMPP server, you need a **UnifiedPush->XMPP Rewrite Proxy** to turn UnifiedPush messages into XMPP messages. There are multiple options for rewrite proxies.

### iNPUTmice's Official Rewrite Proxy

[up](https://codeberg.org/iNPUTmice/up) is a proxy written in Java by the developer of Conversations. It's server independent and works with an external XMPP server.

### Prosody mod_unified_push

[mod_unified_push](https://modules.prosody.im/mod_unified_push) is a Prosody module that turns Prosody into a complete push server.
