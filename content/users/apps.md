---
title: Apps using UnifiedPush
---

This is a non-exhaustive list of the first few end-user applications that use UnifiedPush.

## Android

| Name                                                               | Description           | Date           | Platform | Since version                                                                       | Docs¹                                                                                                                      |
| :----------------------------------------------------------------- | :---                  | :------------- | :------- | :------------                                                                       | :---------------                                                                                                           |
| [FluffyChat](https://fluffychat.im/)                               | Matrix chat           | January 2021   | Android  | v0.26.1                                                                             | [FluffyChat push notifications](https://gitlab.com/famedly/fluffychat/-/wikis/Push-Notifications-without-Google-Services)² |
| [Fedilab](https://fedilab.app/)                                    | Mastodon/Fediverse | March 2021     | Android  | [v2.39.0](https://framagit.org/tom79/fedilab/-/releases/2.39.0)                     | [Fedilab push notifications](https://fedilab.app/wiki/features/push-notifications/)²                                       |
| [Tox Push Message App](https://github.com/zoff99/tox_push_msg_app) | Tox chat              | May 2021       | Android  | v1.0.3                                                                              | [generic](../distributors/)                                                                                                |
| [SchildiChat](https://github.com/SchildiChat/SchildiChat-android/) | Matrix chat           | September 2021 | Android  | v1.2.0.sc42                                                                         | [generic](../distributors/)                                                                                                |
| [Fedilab Lite](https://fedilab.app/)                               | Mastodon/Fediverse | October 2021   | Android  | [v2.39.0](https://framagit.org/tom79/fedilab/-/releases/2.39.0)                     | [Fedilab push notifications](https://fedilab.app/wiki/features/push-notifications/)²                                       |
| [FindMyDevice](https://gitlab.com/Nulide/findmydevice/)            | Find your device      | November 2021  | Android  | [v0.2.2](https://gitlab.com/Nulide/findmydevice/-/releases/v0.2.2)                  | [generic](../distributors/)                                                                                                |
| [Element](https://github.com/vector-im/element-android/)           | Matrix chat           | June 2022      | Android  | [v1.4.26](https://github.com/vector-im/element-android/releases/tag/v1.4.26)        | [generic](../distributors/)                                                                                                |
| [Tusky](https://tusky.app/)                                        | Mastodon/Fediverse | July 2022      | Android  | [v19.0](https://github.com/tuskyapp/Tusky/releases/tag/v19.0)                       | [generic](../distributors/)                                                                                                |
| [SmallTalk](https://github.com/ouchadam/small-talk)                | Matrix chat           | August 2022    | Android  | [v0.0.1-alpha04](https://github.com/ouchadam/small-talk/releases/tag/0.0.1-alpha04) | [generic](../distributors)                                                                                                 |
| [Jami](https://jami.net)                                           | Jami                      | March 2023 | Android  | v361 | [generic](../distributors)                                                                                                 |
| [Goguma](https://sr.ht/~emersion/goguma)                           | IRC client            | March 2023 | Android  | [v0.5.0](https://git.sr.ht/~emersion/goguma/refs/v0.5.0) | [generic](../distributors) |
| [Databag](https://github.com/balzack/databag)                      | Messaging Service     | June 2023  | Android  | ? | [generic](../distributors) |

¹ App-specific documentation should not be needed. Compatible apps should just work after [installing a UnifiedPush distributor](../distributors/).

² UnifiedPush is designed to work with any distributor. Some apps' documentation suggest particular ones but you might prefer to follow the generic advice on [installing a UnifiedPush distributor](../distributors/).

The following is a list of applications that have some work in progress regarding UnifiedPush support.

- [NeoChat](https://invent.kde.org/network/neochat/-/merge_requests/458) A Matrix client on Linux, along with [KUnifiedPush](https://invent.kde.org/libraries/kunifiedpush/), its library.
- [Molly](https://github.com/mollyim/mollyim-android) (A [Signal](https://signal.org/) fork) on Android.
