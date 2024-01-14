---
title: FAQ
weight: -9
---

### What are push notifications?

Your mobile device often needs to receive updates from many messaging, and sometimes other apps that provide real-time updates. Without push notifications, each app would need to contact its own server to get updates. These background services waste battery power and memory. So, push notifications were created; they allow you to receive updates from multiple apps using one optimized network connection by routing everything through a single server.

### I'm just a user who wants push notifications for apps using UnifiedPush, what should I do?

You should visit the [user introduction](/users/distributors) page to learn what UnifiedPush is and get instructions to use it.

### Which apps does UnifiedPush work with?

Apps need to support the UnifiedPush protocol before they can use self-hosted push notifications. See [the application list](/users/apps). If an app isn't in there, feel free to ask in the UnifiedPush Matrix (bridged on Libera Chat IRC) or ask the application's dev team.

### Basic description of how UnifiedPush works

![Diagram of the structure used by UnifiedPush](/img/diagram.png)

### I'm an app developer who wants my users to get push notifications without Google, what should I do?

You should use the UnifiedPush [connector library](/developers/) for your framework. If it doesn't already exist for your framework/language, contributions are welcome.

### Will UnifiedPush ever work on iOS?

iOS doesn't support running services in the background, so running a UnifiedPush distributor won't be possible without jailbreaking or Apple's approval for the foreseeable future. If someone has a solution, share that in the chat.

### Can we use transport X to deliver notifications to the device?

Yes! UnifiedPush doesn't define a transport between the *push server* and the *push distributor*. Just implement the UnifiedPush distributor API, and your service will be compatible with any existing app that uses UnifiedPush!

### What is the difference between UnifiedPush and OpenPush?

UnifiedPush was born in the OpenPush chat. There are some similar core ideas as well; but operationally, the projects are not related. The goals of the projects are the same, except UnifiedPush allows for various different distributors rather than one.

### Should I use UnifiedPush, Unified Push, Unifiedpush or unified push? Is it related to the Aerogear UnifiedPush server or the Unified Push Alliance (UPA)?

This is UnifiedPush. If there is any possibility of confusion, use UnifiedPush.org. UnifiedPush.org is not related to Aerogear or the UnifiedPush Alliance in any way.

### Any other question ?

Please reach us on matrix : <https://matrix.to/#/#unifiedpush:matrix.org>
