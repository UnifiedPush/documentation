---
title: FAQ
weight: -9
---

## Q: What are push notifications?
Push notifications are short messages sent by apps to your device, often when the app isn’t open. They are usually used to show a notification banner to inform you about updates, messages, or important events.
These push notifications are sent from your application server to your push server. Without these push messages, each app would need to have their own background service running just to get updates from their server.
## Q: How do I get started using UnifiedPush for push notifications?
We provide a number of quickstart guides, written specifically to help you get up and running with UnifiedPush quickly and easily:
* [Sunup - Quickstart guide](https://unifiedpush.org/users/distributors/sunup/)
* [ntfy - Quickstart guide](https://unifiedpush.org/users/distributors/ntfy/)
* [Conversations \(XMPP\) - Quickstart guide](https://unifiedpush.org/users/distributors/conversations/)
* [NextPush - Quickstart guide](https://unifiedpush.org/users/distributors/nextpush/)
* [gCombat UP-Distributor - Quickstart guide](https://unifiedpush.org/users/distributors/fcm/)

## Q: Can I self-host a UnifiedPush push service?
Yes! You can self-host your own push service using ntfy, NextPush, or others to have full control over your notifications and data. Check the documentation for your chosen distributor for setup instructions.
## Q: Which apps does UnifiedPush work with?
Check out the [UnifiedPush application list](https://unifiedpush.org/users/apps) for a list of supported apps. If the app you’re looking for doesn’t support UnifiedPush, contact the developer to encourage them to add support. If an app has support but isn’t on our list, [please let us know](https://matrix.to/#/%23unifiedpush:matrix.org).
## Q: How does UnifiedPush work?
Your application server sends push messages to the mobile application through a distributor (e.g. ntfy or NextPush). The distributor tells the mobile application the configuration it needs to know to do it.
## Q: Is UnifiedPush battery-efficient?
Yes, UnifiedPush is designed to be lightweight and battery-efficient. It avoids the need for apps to run background services, reducing battery usage compared to traditional methods.
## Q: I’m an app developer who wants my users to get push notifications without Google, what should I do?
You should use the UnifiedPush [connector library](https://unifiedpush.org/developers/) for your framework. If it doesn’t already exist for your framework/language, contributions are welcome.
## Q: Will UnifiedPush ever work on iOS?
iOS doesn’t support running services in the background, so running a UnifiedPush distributor won’t be possible without jailbreaking or Apple’s approval for the foreseeable future. If someone has a solution, please [share that in the chat](https://matrix.to/#/%23unifiedpush:matrix.org).
## Q: Can we use a specific method (referred to as "transport X") to deliver notifications to the device?
Yes! UnifiedPush doesn’t enforce a specific method (e.g., HTTP, WebSockets, etc.) for delivering notifications between the push server and the distributor. As long as you implement the UnifiedPush distributor API, your service will work with any app that supports UnifiedPush.
## Q: Can I use multiple push servers with UnifiedPush?
Yes, you can configure different apps to use different push servers based on your preferences or needs. UnifiedPush is flexible and allows you to mix and match push servers.
## Q: Is UnifiedPush secure?
UnifiedPush requires end-to-end encryption but some application fake them at this moment. It is not distributor specific and is related to [RFC8291](https://www.rfc-editor.org/rfc/rfc8291), not OMEMO.
## Q: What is the difference between UnifiedPush and OpenPush?
UnifiedPush was born in the OpenPush chat. There are some similar core ideas as well; but operationally, the projects are not related. The goals of the projects are the same, except UnifiedPush allows for various different distributors rather than one.
## Q: Can I contribute to UnifiedPush?
Absolutely! UnifiedPush is an open-source project, and contributions are welcome. You can help by improving documentation, developing libraries, or adding support for new platforms.
## Q: Should I use UnifiedPush, Unified Push, Unifiedpush or unified push? Is it related to the Aerogear UnifiedPush server or the Unified Push Alliance (UPA)?
This is UnifiedPush. If there is any possibility of confusion, use UnifiedPush.org. UnifiedPush.org is not related to Aerogear or the UnifiedPush Alliance in any way.
## Any other questions ?
Please reach us on matrix : [https://matrix.to/\#/\#unifiedpush:matrix.org](https://matrix.to/#/%23unifiedpush:matrix.org)

