---
title: Apps using UnifiedPush
weight: 10
---

This is a non-exhaustive list of the first few end-user applications that use UnifiedPush.

## Android

| Name                                                               | Date           | Platform | Since version | Docs¹ |
| :----------------------------------------------------------------- | :------------- | :------- | :------------ | :--------------- |
| [FluffyChat](https://fluffychat.im/)                               | January 2021   | Android  | v0.26.1       | [FluffyChat push notifications](https://gitlab.com/famedly/fluffychat/-/wikis/Push-Notifications-without-Google-Services)² |
| [Fedilab](https://fedilab.app/)                                    | March 2021     | Android  | [v2.39.0](https://framagit.org/tom79/fedilab/-/releases/2.39.0)  | [Fedilab push notifications](https://fedilab.app/wiki/features/push-notifications/)² |
| [Tox Push Message App](https://github.com/zoff99/tox_push_msg_app) | May 2021       | Android  | v1.0.3        | [generic](../intro/) |
| [SchildiChat](https://github.com/SchildiChat/SchildiChat-android/) | September 2021 | Android  | v1.2.0.sc42   | [generic](../intro/) |
| [Fedilab Lite](https://fedilab.app/)                               | October 2021   | Android  | [v2.39.0](https://framagit.org/tom79/fedilab/-/releases/2.39.0)  | [Fedilab push notifications](https://fedilab.app/wiki/features/push-notifications/)² |
| [FindMyDevice](https://gitlab.com/Nulide/findmydevice/)             | November 2021   | Android  | [v0.2.2](https://gitlab.com/Nulide/findmydevice/-/releases/v0.2.2) | [generic](../intro/) |

¹ App-specific docs should not be needed. Compatible apps should Just Work after [installing UnifiedPush](../intro/).

² UnifiedPush is designed to work with your choice of distributor app on your phone, and your choice of push server. Some apps' docs suggest particular ones, such as Gotify. You might prefer to follow the generic advice on [installing UnifiedPush](../intro/).

The following is a list of applications that have some work in progress regarding UnifiedPush support.

- [Element Android](https://github.com/vector-im/element-android)
  - [issue #2743](https://github.com/vector-im/element-android/issues/2743) "Use UnifiedPush for push notifications"
  - [pull #3448](https://github.com/vector-im/element-android/pull/3448) "Unifiedpush"
- [Nheko](https://nheko.im/nheko-reborn/nheko) on Linux
  - [@vurpo:hacklab.fi mentioned in #unifiedpush:matrix.org](https://matrix.to/#/!vwmBiTqilorqNCbGab:matrix.org/$bT-gCEw5VTM3icJca-xnK_Ji5J0RBVfc_lu3KNhVSmc?via=libera.chat&via=matrix.org&via=tchncs.de)
