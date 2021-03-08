---
title: Introduction
weight: -10
---

Reading [the definitions](/spec/definitions/) may help you to understand this part.

The UnifiedPush libraries, also named **Connector** are the libraries that connect to the distributor. They follow [the specifications](/spec/android/) and are able to list available distributors, choose a distributor, register the applicaton to that distributor, receiving new endpoint, receiving messages, being notified when unregistered.

If you want to let users choose how to receive notifications by using their distributor but you want to use Firebase Cloud Messaging when the users don't have any distributor, you can use add the **embedded FCM distributor**. This version is not compatible with F-Droid rules but the difference between addming embedded FCM and not adding it is minimal, and maintaining a fork for F-Droid (or a branch) is really easy.

