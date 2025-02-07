---
title: Flutter
---

An [example application](https://codeberg.org/UnifiedPush/flutter-connector/src/branch/main/example) is available to show basic usage of the library.

## Index

{{<toc>}}

## Install Library

Add the following code to your pubspec.yaml.

```yaml
  unifiedpush: ^6.0.0-rc2
```

## Initialize the receiver

When you initialize your application, register the different functions that will handle the incoming events with [UnifiedPush.initialize]:

```dart
UnifiedPush.initialize(
  onNewEndpoint: onNewEndpoint,
  onRegistrationFailed: onRegistrationFailed,
  onUnregistered: onUnregistered,
  onMessage: onMessage,
).then((registered) => { if (registered) UnifiedPush.register(instance) });

void onNewEndpoint(PushEndpoint endpoint, String instance) {
  // You should send the endpoint to your application server
  // and sync for missing notifications.
}

void onRegistrationFailed(FailedReason reason, String instance) {}

void onUnregistered(String instance) {}

void onMessage(PushMessage message, String instance) {}
```


## Register for push messages

When you try to register for the first time, you will probably want to use the user default distributor:

```dart
UnifiedPush.tryUseCurrentOrDefaultDistributor().then((success) {
  debugPrint("Current or Default found=$success");
  if (success) {
    UnifiedPush.registerApp(
        instance,                        // Optionnal String, to get multiple endpoints (one per instance)
        features = []                    // Optionnal String Array with required features, if a platform needs it
        vapid = vapid                    // Optionnal String with the server public VAPID key
    );
  } else {
    getUserChoice();                     // You UI function to has the distributor to use
  }
});
```

If using the current distrbutor doesn't succeed, or when you want to let the user chose a non-default distrbutor, you can implement your own logic:

```dart
void getUserChoice() {
  // Get a list of distributors that are available
  final distributors = await UnifiedPush.getDistributors(
      []                               // Optionnal String Array with required features
  );
  // select one or show a dialog or whatever
  final distributor = myPickerFunc(distributors);
  // save the distributor
  UnifiedPush.saveDistributor(distributor);
  // register your app to the distributor
  UnifiedPush.registerApp(
      instance,                        // Optionnal String, to get multiple endpoints (one per instance)
      features = []                    // Optionnal String Array with required features, if a platform needs it
      vapid = vapid                    // Optionnal String with the server public VAPID key
  );
}
```

If you want, [unifiedpush_ui](https://pub.dev/packages/unifiedpush_ui) provides a dialog to pick the user choice.

## Unregister

A registration can be canceled with `UnifiedPush.unregister`.

## Embed a distributor

On Android, this is possible to embed a distributor that will register to the Google play services directly. For more information refer to <https://unifiedpush.org/kdoc/embedded_fcm_distributor/>.

## Send push messages

You can then send web push messages to your applications. The messages need to be encrypted. The required information them are retrieved onNewEndpoint: [PushEndpoint.pubKeySet]

## Example

An example app can be found on the [repository](https://codeberg.org/UnifiedPush/flutter-connector/src/branch/main/example).
## Initialize the receiver

When you initialize your application, register the different functions that will handle the incoming events with [UnifiedPush.initialize]:

```dart
UnifiedPush.initialize(
  onNewEndpoint: onNewEndpoint,
  onRegistrationFailed: onRegistrationFailed,
  onUnregistered: onUnregistered,
  onMessage: onMessage,
).then((registered) => { if (registered) UnifiedPush.register(instance) });

void onNewEndpoint(PushEndpoint endpoint, String instance) {
  // You should send the endpoint to your application server
  // and sync for missing notifications.
}

void onRegistrationFailed(FailedReason reason, String instance) {}

void onUnregistered(String instance) {}

void onMessage(PushMessage message, String instance) {}
```


## Register for push messages

When you try to register for the first time, you will probably want to use the user default distributor:

```dart
UnifiedPush.tryUseCurrentOrDefaultDistributor().then((success) {
  debugPrint("Current or Default found=$success");
  if (success) {
    UnifiedPush.registerApp(
        instance,                        // Optionnal String, to get multiple endpoints (one per instance)
        features = []                    // Optionnal String Array with required features, if a platform needs it
        vapid = vapid                    // Optionnal String with the server public VAPID key
    );
  } else {
    getUserChoice();                     // You UI function to has the distributor to use
  }
});
```

If using the current distrbutor doesn't succeed, or when you want to let the user chose a non-default distrbutor, you can implement your own logic:

```dart
void getUserChoice() {
  // Get a list of distributors that are available
  final distributors = await UnifiedPush.getDistributors(
      []                               // Optionnal String Array with required features
  );
  // select one or show a dialog or whatever
  final distributor = myPickerFunc(distributors);
  // save the distributor
  UnifiedPush.saveDistributor(distributor);
  // register your app to the distributor
  UnifiedPush.registerApp(
      instance,                        // Optionnal String, to get multiple endpoints (one per instance)
      features = []                    // Optionnal String Array with required features, if a platform needs it
      vapid = vapid                    // Optionnal String with the server public VAPID key
  );
}
```

If you want, [unifiedpush_ui](https://pub.dev/packages/unifiedpush_ui) provides a dialog to pick the user choice.

{{< expand "Use unifiedpush_ui's dialog" >}}

If there is no distributor, it will inform the user they need one.

If there is a single distributor, it will register to it.

If there are many distributors, it will open a dialog to ask the user which one to use.

Once a distributor is saved, calling this method will register again to the saved distributor.

```dart
import 'package:unifiedpush/unifiedpush.dart';
import 'package:unifiedpush_ui/unifiedpush_ui.dart';
/* ... */

class UPFunctions extends UnifiedPushFunctions {
  final List<String> features = [];                // Optional, if one platform need one
  @override
  Future<String?> getDistributor() async {
    return await UnifiedPush.getDistributor();
  }

  @override
  Future<List<String>> getDistributors() async {
    return await UnifiedPush.getDistributors(features);
  }

  @override
  Future<void> registerApp(String instance) async {
    await UnifiedPush.registerApp(instance, features);
  }

  @override
  Future<void> saveDistributor(String distributor) async {
    await UnifiedPush.saveDistributor(distributor);
  }
}

// Call the library function
UnifiedPushUi(
    context,
    [instance],             // Optionnal String, to get multiple endpoints (one per instance)
    UPFunctions()
).registerAppWithDialog();
```

{{< /expand >}}
## Unregister

A registration can be canceled with `UnifiedPush.unregister`.

## Embed a distributor

On Android, this is possible to embed a distributor that will register to the Google play services directly. For more information refer to <https://unifiedpush.org/kdoc/embedded_fcm_distributor/>.

## Send push messages

You can then send web push messages to your applications. The messages need to be encrypted. The required information them are retrieved onNewEndpoint: [PushEndpoint.pubKeySet]

