---
title: UnifiedPush
---
UnifiedPush is specifications and tools that let the user choose how push notifications are delivered. All in a free and open source way.

## Getting Started

### I'm a user who wants push notifications for apps using UnifiedPush, what should I do?

The application that gives notifications is called a Distributor. If you don't care about using Google's FCM, look at the download links of [fcm-distributor](/users/distributors/fcm).

### But I don't want to rely on Google

Currently, the simplest way is to connect to a [Gotify](/users/distributors/gotify) server and install the associated distributor.

### Which apps does UnifiedPush work with?

Apps need to support the UnifiedPush protocol before they can use self-hosted push notifications. See [the application list](users/apps). If an app isn't in there, feel free to ask in the UnifiedPush Matrix (bridged on Freenode IRC) or ask the application's dev team.

### Basic description of how UnifiedPush works

![Diagram of the structure used by UnifiedPush](/img/diagram.png)

### I'm an app developer who wants my users to get push notifications without Google, what should I do?

You should use the UnifiedPush [connector library](/developers/) for your framework. If it doesn't already exist for your framework/language, contributions are welcome.

### What options do I have for distributors?

The [distributors page](/users/distributors/) has a recap of all the options.

### Will UnifiedPush ever work on iOS?

iOS doesn't support running services in the background, so running a UnifiedPush distributor won't be possible without jailbreaking or Apple's approval for the foreseeable future. If someone has a solution, share that in the chat.

### Can we use transport X to deliver notifications to the device?

Yes! UnifiedPush doesn't define a transport between the *provider* and the *distributor*. Just implement the UnifiedPush distributor API, and your service will be compatible with any existing app that uses UnifiedPush!

### What is the difference between UnifiedPush and OpenPush?

UnifiedPush was born in the OpenPush chat. There are some similar core ideas as well; but operationally, the projects are not related. The goals of the projects are the same, except UnifiedPush allows for various different distributors rather than one.

