---
geekdocHidden: true
geekdocHiddenTocTree: false
title: Conversations (XMPP) - Android
weight: 20
---
{{< hint type=important title=News! >}}
Conversations [recently started supporting UnifiedPush](https://gultsch.social/@daniel/109630522775489629) in [v2.12.0](https://codeberg.org/iNPUTmice/Conversations/src/branch/master/CHANGELOG.md)!
The founder of Prosody also [made a module to support UnifiedPush](https://floss.social/@mattj/109666686416465083), compatible with Conversations.
{{< /hint >}}
Conversations is a Jabber/XMPP instant messaging client for Android which can also act as a UnifiedPush distributor.

* License: GPLv3
* Sources: <https://codeberg.org/iNPUTmice/Conversations>
* Server: Your XMPP Server with a Rewrite Proxy
* Technology: XMPP
* Download for Android:

[<img alt="Get it on F-Droid" src="/img/f-droid-badge.png" height=100>](https://f-droid.org/en/packages/eu.siacs.conversations/)

## Set Up Android Client
* Open Conversations Settings
* Scroll down to *UnifiedPush Distributor*
* Select the *XMPP Account* you want to receive notifications through
* You're ready to use UnifiedPush!

[YouTube video](https://www.youtube.com/watch?v=wKTk6XGMp3I) demonstrating this.

**Note**: Conversations requires converting UnifiedPush-style notifications to XMPP messages first, which is done by a service hosted at `up.conversations.im`. This service, called a *rewrite proxy* can also be self-hosted.
**Note 2**: Conversations is NOT an *end user application*. Conversations keeps its background connection open and lets other apps receive notifications through it.


## Self-Host

In addition to a regular XMPP server, you need a **UnifiedPush->XMPP Rewrite Proxy** to turn UnifiedPush messages into XMPP messages.
There are multiple options for rewrite proxies.

### iNPUTmice's Official Rewrite Proxy

[up](https://codeberg.org/iNPUTmice/up) is a proxy written in Java by the developer of Conversations. It's server independent and works with an external XMPP server.

### Prosody mod_unified_push

[mod_unified_push](https://modules.prosody.im/mod_unified_push) is a Prosody module that turns Prosody into a complete push server.
