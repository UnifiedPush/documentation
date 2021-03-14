---
title: Home
---

UnifiedPush is specifications and tools that let the user choose how push notifications are delivered. All in a free and open source way.

## Getting Started

### I'm a user who wants push notifications for apps using UP, what should I do?

The applications that gives notifications is called a Distributor. If you don't care about using Google's FCM, look at the download links of [fcm-distributor](/users/distributors/fcm). 

### But I don't want to rely on Google

Currently, the simplest way is to host your own [Gotify](/users/distributors/gotify) server and install the associated distributor.

### I'm an app developer who wants my users to get push notifications without Google, what should I do?
You should use the UnifedPush [connector library](/developers/) for your framework. If it doesn't already exist for your framework/language, contributions are welcome.

### What options do I have for distributors?
The [distributors page](/users/distributors/) has a recap of all the options.

### Does/will app X support UnifiedPush?
See [the application list](users/apps). If an app isn't in there, feel free to ask in the UnifiedPush Matrix (bridged on Freenode IRC) or ask the application's dev team.

### Will UP ever work on iOS?
IOS doesn't support running services in the background, so running a UnifiedPush distributor won't be possible without jailbreaking or Apple's approval for the foreseeable future. If someone has a solution, share that in the chat.

### Can we use transport X to deliver notifications to the device?
Yes! UnifiedPush doesn't define a transport between the *provider* and the *distributor*. Just implement the UnifiedPush distributor API, and your service will be compatible with any existing app that uses UnifiedPush!


