---
geekdocHidden: true
geekdocHiddenTocTree: false
title: "Push notifications for decentralized services"
weight: -20250131
---

_How mobile push notifications currently bring centralization to decentralized services, and how we can avoid it, even for mainstream configurations._

> Published the 31/01/2025
>
> This post will focus on Android.

We all know _decentralized_ applications: emails, Mastodon (and the Fediverse), Nextcloud and other clouds, Git servers, Messaging services like XMPP or Matrix, Feed reader (RSS), some calendars, etc.

They are _decentralized_ because they don't rely on a single server, own by a single entity. They can be installed by different persons or organizations, on different servers. Mobile applications for these services usually ask the users what server they want to use, before interacting with the service.

_Push notifications_ refer to a mechanism used by servers to inform (mobile) clients of real-time updates. Without push notifications, clients must either periodically request updates from the server, or maintain a connection with their server, which can lead to increased data usage and battery drain.

## How it usually work, how it is recommended by Google

When Android application developers want to add support for push notifications, they usually go for _Firebase Cloud Messaging_ (FCM), the solution provided by Google.

The [guide provided by firebase](<https://firebase.google.com/docs/cloud-messaging/android/client>) explain the different steps for you to support their solution:
- You first need to go on the Firebase Console, create a new project and add your application to this project.

<details><summary><small>You are also <i>strongly</i> recommended to enable analytics for your project.</small></summary>

!["Note from the website: For an optimal experience with FCM, we strongly recommend enabling Google Analytics in your project. Google Analytics is a requirement for FCM's message delivery reporting."](../../../blog/20250131_push_for_decentralized/enable_analytics.png)

_Google strongly recommend enabling their Analytics_

</details>


- Then you will need to download a file (json) containing your firebase project information and add it to your application sources.
- Add _firebase-messaging_ to your application, the library that will register to the Google Services on the device (if present).
- Then find out where you can create a new service account for FCM and generate its keys. Most of the time, __these keys are considered sensitive, you must ensure to keep them secret. So you must not share them.__\*

_\* There might be solutions to generate keys that can be public but it seems easy to mess with this configuration._

When your application server is centralized, you implement the FCM API, and save these keys with your configuration. When you want to inform users about an update, your server will request Google servers with these credentials.

This solution works only for users with Google Services. This is the case for most users but the ones without these services (because Google, or Internet isn't accessible or because users choose to not install them), you may need another solution, a fallback.

## What it means for mobile applications for decentralized and self-hostable services

Developers of decentralized services have responded to this expectation of a centralized architecture with _gateways_:
- The project hosts on a centralized server a service that will "translate" requests from the different servers to Google servers.
- The application server implement their own protocol or follows the standard webpush specifications (RFC8030 + RFC8291 + RFC8292).
- When the server wants to inform the users, it pushes a message with this protocol to the gateway. The gateway knows the Google keys for the application and uses that secret to push to Google servers.

For example:
- Element uses a [sygnal](https://github.com/matrix-org/sygnal) server hosted at <https://matrix.org/>.
- Mastodon uses a [webpush-fcm-relay](https://github.com/mastodon/webpush-fcm-relay) server hosted at <https://app.joinmastodon.org/>.
- Nextcloud applications use a push proxy ([documented here](https://github.com/nextcloud/notifications/blob/master/docs/push-v2.md)) server hosted at <https://push-notifications.nextcloud.com>.

<img alt="A screenshot of the matrix push gateway specifications: the Matrix homeserver sends a message to the Push Gateway that forward to the Push Provider" src="../../../blog/20250131_push_for_decentralized/matrix_push_gateway_specification.png" style="max-height:60rem;" >

_The Push gateway is under the (mobile) app developer responsibility_

__In other words, the applications of decentralized services often respond to this problem by reintroducing a certain centralization.__ And this still doesn't solve problems when Google or the Internet is not accessible, or when the user hasn't installed Google services.

Another often adopted solution is to periodically fetch new events with the server, or to maintain a constant connection to the server. The first solution is good for an application that does not need "real-time" events. And the second can be adapted for the applications that we use intensively, if the use of data and energy for this connection is negligible compared to the basic use of the application. Maintaining a connection can also be very expensive for applications which have not been developed with this use in account. What often happens when the project implements them as a _best effort_ for a small user base.

There is of course the solution of UnifiedPush, that uses webpush specifications, which is decentralized by default and can do authorization controls using the standard VAPID, based an asymmetric encryption.

But as the majority of users rely on Google services, this is understandable that projects target these users first. Some mobile app project have chosen to rely uniquely on UnifiedPush, to simplify things and because users with Google services can install [gCompat-UP](../../../users/distributors/fcm/) to bring UnifiedPush support to these services.

Obviously, we know that everybody won't migrate from a day to the next to UnifiedPush, and we don't want to force everybody to migrate. But users should be free to use the services of their choice.

## Webpush to google services

What is less known, and not (well?) documented by Google, is that __you can directly send webpush requests to FCM servers__.

If your application server support Webpush\* with VAPID, you can get rid of push gateways. And this can be done by supporting UnifiedPush in the same way:

[embedded-fcm-distributor](../../../kdoc/embedded_fcm_distributor/) is a library that will register to Google services for webpush registrations, authenticated with VAPID key. It gives support for UnifiedPush to users with Google Services.

To use it, you follow the UnifiedPush main setup. A quick summarize:

You first implement the push service:

```kotlin
class PushServiceImpl : PushService() {
  override fun onMessage(message: PushMessage, instance: String) {
    processMessage(PushMessage.content)
  }

  override fun onNewEndpoint(endpoint: PushEndpoint, instance: String) {
    sendEndpointToServer(endpoint)
    }

  override fun onUnregistered(instance: String) {
    sendEndpointToServer(null)
  }

  override fun onRegistrationFailed(reason: FailedReason, instance: String) {
    processFail(reason)
  }
```

And subscribe with the server VAPID public key:

```kotlin
  UnifiedPush.tryUseCurrentOrDefaultDistributor(context) { success ->
    if (success) {
        UnifiedPush.register(context, messageForDistributor, vapid)
    }
  }
```

It will call the service `onNewEndpoint`. Details for the main setup are provided in the [library documentation](../../../kdoc/connector).

Note that it is also possible to upload your VAPID keys on the Firebase Console, if you use a centralized application and want to pushes with Webpush. But __being able to register a VAPID pubkey retrieved during execution is not possible with the _firebase-messaging_ library.__

\* The published version of the standard. There are some applications that rely on a draft of the specifications.

## 🌈 Webpush everywhere 🌈

This gives another reason to embrace the standards and implement webpush (and UnifiedPush) !

Mastodon 4.4 will [follow the standard webpush specifications](https://github.com/mastodon/mastodon/pull/33528#issuecomment-2589468275). JMAP is an email standard that support webpush, we can have [an RFC to add webpush support to IMAP](https://datatracker.ietf.org/doc/draft-gougeon-imap-webpush/). A proposal to [add webpush to Matrix specifications](https://github.com/matrix-org/matrix-spec-proposals/pull/4174) is opened.

We are looking for other decentralized, and centralized, services to support it too. Maybe we'll lose these gateways one day.

Regarding iOS, they have made some progress in adopting webpush, but it does not seem possible to push for mobile applications with it yet.

