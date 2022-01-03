---
title: Introduction
weight: -10
---

This documentation is for application developers who want to use the UnifiedPush library.

If you want to write a new distributor, please refer to the [definitions](/spec/definitions/) and the [specifications](/spec/android/). You may also want to look at the code of [NoProvider2Push](/users/distributors/np2p/), which is mostly only UnifiedPush related code.

Reading [the definitions](/spec/definitions/) may help you to understand this part.

The UnifiedPush libraries, also named **Connector** are the libraries that connect to the distributor. They follow [the specifications](/spec/android/) and are able to list available distributors, choose a distributor, register the application to that distributor, receiving new endpoint, receiving messages, being notified when unregistered.

If you want to let users choose how to receive notifications by using their distributor but you want to use Firebase Cloud Messaging when the users don't have any distributor, you can use add the **embedded FCM distributor**. This version is not compatible with F-Droid rules but the difference between adding embedded FCM and not adding it is minimal, and doing a flavor with FCM is trivial.
