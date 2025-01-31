---
title: Android
aliases : ["/developers/intro/", "/developers/embedded_fcm/"]
---

This documentation is about adding UnifiedPush support to your application. If you wish to write a new distributor, please refer to the [definitions](/developers/spec/definitions/) and the [specifications](/developers/spec/android/). You may also want to look at the code of [NexPush](/users/distributors/nextpush/).

# Set up UnifiedPush on an Android application

Add [UnifiedPush](https://unifiedpush.org) support to your application. You can also use other libraries to get a customizable dialog to ask the users what distributor they would like to use, or to get a fallback to Google's FCM if available.

To receive notifications with UnifiedPush, users must have a dedicated application, a distributor, installed on their system.

## Core Library

Use the [connector](/kdoc/connector "Module documentation") library to subscribe and receive push notifications with UnifiedPush.

## Customizable Dialog

One of the main purpose of UnifiedPush is to let the users chose the way they receive their notifications. If many distributors are installed on the system, you will need to ask the users what they prefere to use. The [connector-ui](/kdoc/connector_ui "Module documentation") library offers a dialog that ask what distributor to use before registering your application.

## Embedded FCM Distributor

If the users don't have any UnifiedPush Distributor installed and they have Google Services enabled, you may want to fallback to Google's FCM.

You can embed an FCM Distributor, and if the user doesn’t have another distributor, this one will be used. [embedded_fcm_distributor](/kdoc/embedded_fcm_distributor "Module documentation") library basically act like an UnifiedPush Distributor, but is internal to the app and passes notifications through FCM. It doesn't contain proprietary code.

## Example implementation

An [example application](https://codeberg.org/UnifiedPush/android-example) is available to show basic usage of the libraries.

