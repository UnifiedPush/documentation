---
title: Troubleshooting your setup
geekdocCollapseSection: true
---

This page helps you resolve problems if an app is not working with UnifiedPush. It is aimed at general users who might be trying to use UnifiedPush for the first time.

*Using Matrix client Element with matrix.org and ntfy.sh? Try [mpeter50's Matrix-Ntfy debugging advices for 2024 Q2](https://gist.github.com/mpeter50/9220dac1056c9a66c313d049838c1ab2).*

*Running your own UnifiedPush server? See [Troubleshooting Self-Hosted UnifiedPush and Matrix Servers](/users/troubleshooting/self-hosted-with-matrix/).*

## Understand UnifiedPush

First check these requirements and expectations.

You need several components to use UnifiedPush. Learn more about these in the [UnifiedPush documentation](/).

- **Your App**, for example a messaging app (on your device)
- ... listening to a UnifiedPush [**Distributor**](/users/distributors/) (also on your device)
- ... listening to a UnifiedPush **Push Server** (somewhere else)
- ... listening to Your App's **App Server** (such as a messaging server).

You need to choose a Distributor and Push Server that work together. On the other hand, Your Apps don't affect this choice, because any UnifiedPush-compatible App should work with any Distributor and Push Server.

Once the Distributor and Push Server are working, Your App should (quietly) detect and use it. Don't expect Your App to need any UnifiedPush configuration, except perhaps if it detects more than one push provider (or none).

In general, all UnifiedPush configuration (such as details of its Server) is done in the distributor, not in Your App.

## Check Your App Supports UnifiedPush

Check that your specific app version and variant claims to support UnifiedPush.

- See some [Apps using UnifiedPush](/users/apps/).
- **Some apps come in different variants**, such as a Google Play store variant and an [F-Droid](https://f-droid.org/) variant, and they may support different push methods. Check that the variant you are using is documented as supporting UnifiedPush. In general it is more likely in a variant described with terms like "F-Droid" or "deGoogled" or "libre".
- **An app can support multiple push methods**, and if it detects more than one it might ask you to choose or might choose for you. If this seems a possible cause of it failing to use UnifiedPush, try force-stopping and then restarting the app, which may make it re-check or re-ask the question.

## The Distributor

In *most cases* you need to choose, install and configure a [UnifiedPush distributor](/users/distributors/), which is available as an app. Follow its instructions carefully. It will need special permissions as it has to stay running in the background.

An exception is if *Your App* has a UnifiedPush distributor built in. (The XMPP client [Conversations](/users/distributors/conversations/) is one.) In that case you do not need a separate distributor (you only need one on each device). You  can still check this one is working, in the same way as if it were separate.

To check if you already have a UnifiedPush distributor installed, you can:

- use the UP-Example app (see below): if the `REGISTER` function succeeds, then a distributor is installed;
- search your installed apps for ones named in the [UnifiedPush distributor](/users/distributors/) documentation.

## The Push Server and Rate Limits

Consider who provides the Push Server for you. It may have limitations, such as rate limits, especially if it's provided to you free-of-charge. This is one case where a simple test may not show a problem, but real push notifications may not arrive.

- see: [ntfy.sh limitations](https://docs.ntfy.sh/publish/#limitations)

## Troubleshooting with the UP-Example App (Android)

You can test the Distributor and Push Server using the simple [UP-Example](https://f-droid.org/en/packages/org.unifiedpush.example/) app. Install it from F-Droid.

Click the `REGISTER` button and then the `TEST` button. You should immediately receive an example notification.

- If it won't register, or you don't receive a notification, then there is something wrong with your Distributor or Push Server.
- If you do receive this test notification, then the problem may be in Your App. See "Use Notification Troubleshooting Tools" below.

## Troubleshooting with a Distributor App

Your Distributor app may display all active UnifiedPush registrations made through it. At least ['ntfy'](/users/distributors/ntfy/ "ntfy as a U-P distributor") and [NextPush](/users/distributors/nextpush/) do. When you click the `REGISTER` button in [UP-Example](https://f-droid.org/en/packages/org.unifiedpush.example/), an entry appears immediately in this list with `org.unifiedpush.example` as the app identifier. When you unregister, it should disappear. (In my quick test it doesn't disappear from NextPush; a bug I assume.) You should see one entry for each app that makes a UnifiedPush registration.

## Troubleshooting with Other Apps

You can find notification troubleshooting tools and information in some apps. It might be worth installing one of them in order to use these tools.

Some Matrix apps including Element, Schildichat and FUTO Circles (at least their Android versions) contain a useful, active, troubleshooting tool in "Settings -> Notifications -> Troubleshoot Notifications", which performs several checks and displays the results. Note the reported "Gateway" and "Endpoint" URLs.

Check also "Settings -> Notifications -> Notification Targets" in Element or SchildiChat, or "Settings -> Notifications -> Devices" in FluffyChat. There should be one entry for each app that registers for matrix notifications, and when that app is using UnifiedPush you should see a URL that begins with your Push Server's URL.

In the "Notification Targets" screen in Element or SchildiChat, two relevant URLs are shown, `push_key` and `Url`, and both should begin with your push server's URL. If `push_key` shows your server but `Url` shows some other server (perhaps linked to Your App, such as `up.schildi.chat`) then push notifications are being routed through that other server before they reach your Push Server, which might or might not be what you want.
