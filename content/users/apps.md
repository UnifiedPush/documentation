---
title: Apps using UnifiedPush
---

This is a non-exhaustive list of the first few end-user applications that use UnifiedPush.

{{< tabs "platforms" >}}
{{< tab "Android" >}}

| Name                                                                                                | Description        | Date           | Since version                                                                       | Docs¹                                                                                                                      |
|:----------------------------------------------------------------------------------------------------|:-------------------|:---------------|:------------------------------------------------------------------------------------|:---------------------------------------------------------------------------------------------------------------------------|
| [FluffyChat](https://fluffychat.im/)                                                                | Matrix chat        | January 2021   | v0.26.1                                                                             | [FluffyChat push notifications](https://gitlab.com/famedly/fluffychat/-/wikis/Push-Notifications-without-Google-Services)² |
| [Fedilab](https://fedilab.app/)                                                                     | Mastodon/Fediverse | March 2021     | [v2.39.0](https://framagit.org/tom79/fedilab/-/releases/2.39.0)                     | [Fedilab push notifications](https://fedilab.app/wiki/features/push-notifications/)²                                       |
| [Tox Push Message App](https://github.com/zoff99/tox_push_msg_app)                                  | Tox chat           | May 2021       | v1.0.3                                                                              | [generic](../distributors/)                                                                                                |
| [SchildiChat](https://github.com/SchildiChat/SchildiChat-android/)                                  | Matrix chat        | September 2021 | v1.2.0.sc42                                                                         | [generic](../distributors/)                                                                                                |
| [FindMyDevice](https://gitlab.com/Nulide/findmydevice/)                                             | Find your device   | November 2021  | [v0.2.2](https://gitlab.com/Nulide/findmydevice/-/releases/v0.2.2)                  | [generic](../distributors/)                                                                                                |
| [Element](https://github.com/element-hq/element-android/)                                           | Matrix chat        | June 2022      | [v1.4.26](https://github.com/element-hq/element-android/releases/tag/v1.4.26)       | [generic](../distributors/)                                                                                                |
| [Tusky](https://tusky.app/)                                                                         | Mastodon/Fediverse | July 2022      | [v19.0](https://github.com/tuskyapp/Tusky/releases/tag/v19.0)                       | [generic](../distributors/)                                                                                                |
| [Neon](https://github.com/nextcloud/neon)                                                           | Nextcloud          | July 2022      | Unreleased                                                                          | [generic](../distributors)                                                                                                 |
| [Jami](https://jami.net)                                                                            | Jami               | March 2023     | v361                                                                                | [generic](../distributors)                                                                                                 |
| [Goguma](https://codeberg.org/emersion/goguma)                                                      | IRC client         | March 2023     | [v0.5.0](https://codeberg.org/emersion/goguma/releases/tag/v0.5.0)                            | [generic](../distributors)                                                                                                 |
| [Circles](https://gitlab.futo.org/circles/circles-android)                                          | Social Network (matrix) | June 2023 | v1.0.11                                                                             | [generic](../distributors)                                                                          
| [Databag](https://github.com/balzack/databag)                                                       | Messaging Service  | July 2023      | v1.5.0                                                                              | [generic](../distributors)                                                                                                 |
| [Podverse](https://github.com/podverse/podverse-rn) (beta)                                          | Podcast Manager    | July 2023      | v4.13.1                                                                             | [generic](../distributors)                                                                                                 |
| [Moshidon](https://github.com/LucasGGamerM/moshidon)                                                | Mastodon           | August 2023    | [v2.0.3+fork.98](https://github.com/sk22/megalodon/releases/tag/v2.0.3%2Bfork.98)   | [generic](../distributors)                                                                                                 |
| [Träwelldroid](https://github.com/Traewelldroid/traewelldroid)                                      | Traewelling client | September 2023 | [v2.0.0](https://github.com/Traewelldroid/traewelldroid/releases/tag/v2.0.0)        | [generic](../distributors)                                                                                                 |
| [Pachli](https://pachli.app/)                                                                       | Mastodon           | September 2023 | [v1.0.0](https://github.com/pachli/pachli-android/releases/tag/v1.0)                | [generic](../distributors/)                                                                                                |
| [Molly](https://github.com/mollyim/mollyim-android-unifiedpush)                                     | Signal client      | October 2023   | [v6.35.3-1.up1](https://github.com/mollyim/mollyim-android-unifiedpush/releases/tag/v6.35.3-1.up1)        | [mollysocket](https://github.com/mollyim/mollysocket)                                           |
| [Amethyst](https://github.com/vitorpamplona/amethyst/)                                              | Nostr client       | October 2023   | [v0.80.1](https://github.com/vitorpamplona/amethyst/releases/tag/v0.80.1)           | [generic](../distributors/)                                                                                                |
| [Ltt.rs](https://codeberg.org/iNPUTmice/lttrs-android)                                              | Mail (JMAP) client | December 2023  | [0.4.0](https://codeberg.org/iNPUTmice/lttrs-android/releases/tag/0.4.0)             | [generic](../distributors)                                                                                                 |
| [Mercurygram](https://github.com/drizzt/Telegram-FOSS/tree/Mercurygram)                             | Telegram client    | December 2023  | [v10.3.2.1](https://github.com/drizzt/Telegram-FOSS/releases/tag/v10.3.2.1)         | [generic](../distributors)                                                                                                 |
| [Element-X](https://github.com/element-hq/element-x-android)                                        | Matrix chat        | January 2024   | v0.4.2                                                                              | [generic](../distributors/)                                                                                                |
| [SchildiChat Next](https://github.com/SchildiChat/schildichat-android-next)                         | Matrix chat        | January 2024   | v0.4.2.sc1                                                                          | [generic](../distributors/)                                                                                                |
| [Nagram](https://github.com/NextAlone/Nagram)                                                       | Telegram client    | April 2024     | [10.9.1.1165](https://github.com/NextAlone/Nagram/releases/tag/1165)        | [generic](../distributors/)
| [DAVx⁵](https://www.davx5.com/)                                                                  | CalDAV/CardDAV/WebDAV | September 2024 | [v4.4.2-ose](https://github.com/bitfireAT/davx5-ose/releases/tag/v4.4.2-ose)        | [Nextcloud extension for WebDAV-Push](https://github.com/bitfireAT/nc_ext_dav_push)
| [Momogram](https://github.com/dic1911/Momogram)                                                       | Telegram client    | December 2024     | [v11.4.2-1](https://github.com/dic1911/Momogram/releases/tag/v11.4.2-1)        | [generic](../distributors/)
| [FOSS Warn](https://github.com/nucleus-ffm/foss_warn)                                                | Emergency alerts    | December 2024     | [1.0.0 alpha0](https://github.com/nucleus-ffm/foss_warn/releases/tag/pre-1.0.0-alpha_0) | [FOSS Warn Wiki](https://github.com/nucleus-ffm/foss_warn/wiki/What-is-UnifiedPush-and-how-to-select-a-distributor)
| [Wafrn App](https://wafrn.net) | Social Network (Fediverse + Bluesky) | May 2025 | [v1.3.0](https://github.com/juandjara/wafrn-rn/releases/tag/v1.3.0) | [generic](../distributors) 


¹ App-specific documentation should not be needed. Compatible apps should just work after [installing a UnifiedPush distributor](../distributors/).

² UnifiedPush is designed to work with any distributor. Some apps' documentation suggest particular ones but you might prefer to follow the generic advice on [installing a UnifiedPush distributor](../distributors/).

<details>
<summary>Deprecated applications</summary>

| Name                                                                                                | Description        | Date           | Since version                                                                       | Docs¹                                                                                                                      |
|:----------------------------------------------------------------------------------------------------|:-------------------|:---------------|:------------------------------------------------------------------------------------|:---------------------------------------------------------------------------------------------------------------------------|
| [Fedilab Lite](https://fedilab.app/)                                                                | Mastodon/Fediverse | October 2021   | [v2.39.0](https://framagit.org/tom79/fedilab/-/releases/2.39.0)                     | [Fedilab push notifications](https://fedilab.app/wiki/features/push-notifications/)²                                       |
| [SmallTalk](https://github.com/ouchadam/small-talk)                                                 | Matrix chat        | August 2022    | [v0.0.1-alpha04](https://github.com/ouchadam/small-talk/releases/tag/0.0.1-alpha04) | [generic](../distributors)                                                                                                 |
| [Megalodon](https://github.com/sk22/megalodon)                                                      | Mastodon           | August 2023    | [v2.0.3+fork.98](https://github.com/sk22/megalodon/releases/tag/v2.0.3%2Bfork.98)   | [generic](../distributors)                                                                                                 |

</details>

{{< /tab >}}
{{< tab "Linux" >}}

| Name                                                                                                | Description        | Date           | Since version | Docs¹                       |
|:----------------------------------------------------------------------------------------------------|:-------------------|:---------------|:--------------|:----------------------------|
| [Tokodon](https://apps.kde.org/tokodon/)                                                            | Mastodon/Fediverse |                |               | [generic](../distributors/) |
| [NeoChat](https://apps.kde.org/neochat/)                                                            | Matrix chat        | January 2024   |               | [generic](../distributors/) |

¹ App-specific documentation should not be needed. Compatible apps should just work after [installing a UnifiedPush distributor](../distributors/).

² UnifiedPush is designed to work with any distributor. Some apps' documentation suggest particular ones but you might prefer to follow the generic advice on [installing a UnifiedPush distributor](../distributors/).

{{< /tab >}}
{{< /tabs >}}
