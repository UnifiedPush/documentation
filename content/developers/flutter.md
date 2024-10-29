---
title: Flutter
---

An [example application](https://codeberg.org/UnifiedPush/flutter-connector/src/branch/main/example) is available to show basic usage of the library.

## Index

{{<toc>}}

## Install Library

Add the following code to your pubspec.yaml.

```yaml
  unifiedpush: ^5.0.0
```

## Initialize the receiver

You can ignore instances if you don't need to handle multiple connections.

```dart
    UnifiedPush.initialize(
      onNewEndpoint: onNewEndpoint,
      onRegistrationFailed: onRegistrationFailed,
      onUnregistered: onUnregistered,
      onMessage: onMessage,
    );

    void onNewEndpoint(String endpoint, String instance) {
        // You should send the endpoint to your application server
        // and sync for missing notifications.
    }

    void onRegistrationFailed(String instance) {}

    void onUnregistered(String instance) {}

    void onMessage(Uint8List message, String instance) {}
```

{{< expand "If you need, for any reason, to work with a single isolate" >}}

1. Set the engine on the android side of your app (typically in `android/app/src/main/kotlin/your/app/id/MainActivity.kt`):

```kotlin
import android.content.Context
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity : FlutterActivity() {
    override fun provideFlutterEngine(context: Context): FlutterEngine? {
        return provideEngine(this)
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
    // do nothing, because the engine was been configured in provideEngine
    }

    companion object {
        var engine: FlutterEngine? = null
        fun provideEngine(context: Context): FlutterEngine {
            val eng = engine ?: FlutterEngine(context, emptyArray(), true, false)
            engine = eng
            return eng
        }
    }
}
```

2. Declare the Receiver for UnifiedPush events (android side):

```kotlin
import android.content.Context
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.dart.DartExecutor
import org.unifiedpush.flutter.connector.UnifiedPushReceiver

class UnifiedPushReceiver : UnifiedPushReceiver() {
    override fun getEngine(context: Context): FlutterEngine {
        var engine = MainActivity.engine
        if (engine == null) {
            engine = MainActivity.provideEngine(context)
            engine.localizationPlugin.sendLocalesToFlutter(
                context.resources.configuration
            )
            engine.dartExecutor.executeDartEntrypoint(
                DartExecutor.DartEntrypoint.createDefault()
            )
        }
        return engine
    }
}
```

3. Add the UnifiedPush related actions to the (android side) manifest, and disabled built-in receiver:

```xml
        <receiver android:name="org.unifiedpush.flutter.connector.UnifiedPushReceiver"
            tools:replace="android:enabled"
            android:enabled="false">
        </receiver>
        <receiver android:exported="false"  android:enabled="true"  android:name=".UnifiedPushReceiver">
            <intent-filter>
                <action android:name="org.unifiedpush.flutter.connector.MESSAGE"/>
                <action android:name="org.unifiedpush.flutter.connector.UNREGISTERED"/>
                <action android:name="org.unifiedpush.flutter.connector.NEW_ENDPOINT"/>
                <action android:name="org.unifiedpush.flutter.connector.REGISTRATION_FAILED" />
            </intent-filter>
        </receiver>
```

{{< /expand >}}

## Register for Push

To register for receiving push services you have **two options**, after initializing:

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
  final List<String> features = [/*list of features*/];
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

{{< expand "Handle the selection yourself" >}}

```dart
// Check if a distributor is already registered
if (await UnifiedPush.getDistributor() != "") {
  // Re-register in case something broke
  UnifiedPush.registerApp(
        instance,                        // Optionnal String, to get multiple endpoints (one per instance)
        [featureAndroidBytesMessage]     // Optionnal String Array with required features
  );
} else {
  // Get a list of distributors that are available
  final distributors = await UnifiedPush.getDistributors(
        [featureAndroidBytesMessage]     // Optionnal String Array with required features
  );
  // select one or show a dialog or whatever
  final distributor = myPickerFunc(distributors);
  // save the distributor
  UnifiedPush.saveDistributor(distributor);
  // register your app to the distributor
  UnifiedPush.registerApp(
        instance,                        // Optionnal String, to get multiple endpoints (one per instance)
        [featureAndroidBytesMessage]     // Optionnal String Array with required features
  );
}
```

{{< /expand >}}
## Unregister

```dart
// inform the library that you would like to unregister from receiving push messages
UnifiedPush.unregister(
        instance                         // Optionnal String, to get multiple endpoints (one per instance)
);
// You won't receive onUnregistered for this instance
```

## Sending Push Messages

(From the application server)

To send a message to an application you need the "endpoint". You get it in the onNewEndpoint method once it is available. You can then use it to send a message using for example curl. The POST body is the message received by the function onMessage.

```bash
curl -X POST "$endpoint" --data "Any message body that is desired."
```

## Application With Embedded Distributor

On the Android side, you will need to import and declare the embedded distributor. Please refer to [Embedded FCM Distributor](/developers/embedded_fcm/) for more information.
