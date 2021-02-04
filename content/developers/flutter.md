---
title: Flutter
---

An [example application](https://github.com/UnifiedPush/flutter-connector/tree/main/example) is available to show basic usage of the library.

## Index

* [Install Library](#install-library)
* [Register For Push](#register-for-push)
* [Receiving Push Messages](#receiving-push-messages)
* [Sending Push Messages](#sending-push-messages) (from the application server)
* [Using the FCM-added version](#using-the-fcm-added-version)


## Install Library

Add the following code to your pubspec.lock. For the moment, you have to use commit hash.
```pubspec
  unifiedpush:
    dependency: "direct main"
    description:
      path: "."
      ref: main
      resolved-ref: "{{COMMIT_HASH}}"
      url: "https://github.com/UnifiedPush/flutter-connector.git"
    source: git
    version: "0.0.1"
```

## Register for Push

To register for receiving push services you have two options, after initializing:

1. Have the library handle distributor selection
```flutter
// Call the library function
UnifiedPush.registerAppWithDialog()
```

2. Handle selection yourself
```flutter
// Get a list of distributors that are available
final distributors = await UnifiedPush.getDistributors()
// select one or show a dialog or whatever
// the below line will crash the app if no distributors are available
UnifiedPush.saveDistributor(distributors[0])
UnifiedPush.registerApp()
```

**unregister**
```flutter
// inform the library that you would like to unregister from receiving push messages
UnifiedPush.unregisterApp()
```

## Receiving Push Messages

To receive Push Messages you need to initialize UnifiedPush as following:
```flutter
    UnifiedPush.initialize(
        onNewEndpoint, // takes String endpoint in arg
        onRegistrationFailed,
        onRegistrationRefused,
        onUnregistered,
        onMessage, // takes String message in arg
        bgNewEndpoint, // called when new endpoint in background, need to be static, takes String endpoint in arg
        bgUnregistered, // called when unregistered in background, need to be static
        bgOnMessage // called when receiving a message in background, need to be static, takes String message in arg
    );
```

## Sending Push Messages
(From the application server)

To send a message to an application you need the "endpoint". You get it in the onNewEndpoint method once it is available. You can then use it to send a message using for example curl. The POST body is the message received by the function onMessage.
```bash
curl -X POST "$endpoint" --data "Any message body that is desired."
```

## Using the FCM-added version

* Add `getEndpoint` to the UnifiedPush initialization. It have to take `String token` as an arg and returns `String endpoint` of the FCM proxy.
* Add `apply plugin: 'com.google.gms.google-services'` to your android app level build.gradle.
* Add the google-services.json file from firebase to your app directory.
* Change the pubspec.lock to use `flutter-connector_fcm_added` instead of `flutter-connector`

For instance, you can find a difference between fcm_added and main of the example here <https://github.com/UnifiedPush/flutter-connector_fcm_added/commit/6ab2e64636686bcf41f26967a1db6dc7ed44f0fc>.

You, as developper, will need a [FCM Rewrite Proxy](/developers/FCM_Proxy/) for FCM to work.

