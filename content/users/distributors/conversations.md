---
geekdocHidden: true
geekdocHiddenTocTree: false
title: Conversations
weight: 20
---

Conversations is a Jabber/XMPP client for Android 5.0+ smartphones which can also act as a UnifiedPush distributor.
You can enable this functionality in the settings by choosing which XMPP account should be used to receive push messages.

* License: GPLv3
* Sources: <https://codeberg.org/iNPUTmice/Conversations>
* Server: `up.conversations.im` or your your own XMPP server
* Technology: XMPP
* Download for Android:

[<img alt="Get it on F-Droid" src="/img/f-droid-badge.png" height=100>](https://f-droid.org/en/packages/eu.siacs.conversations/)

## Server Requirements

* Per default, Conversations uses the push server at `up.conversations.im`.
* If you host your own XMPP chat server, it can act as a push server for Conversations by connecting [this component](https://codeberg.org/iNPUTmice/up) to it.
* Prosody can act as a push server by enabling [`mod_unified_push`](https://modules.prosody.im/mod_unified_push.html) community module.
