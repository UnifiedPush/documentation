---
title: Flutter
---

An [example application](https://github.com/UnifiedPush/flutter-connector/tree/main/example) is available to show basic usage of the library.

## Index

{{<toc>}}

## Install Library

Add the following code to your pubspec.yaml.

```yaml
  unifiedpush: ^2.0.0
```

## Register for Push

To register for receiving push services you have two options, after initializing:

1. Have the library handle distributor selection

```dart
// Call the library function
UnifiedPush.registerAppWithDialog();
```

2. Handle selection yourself

```dart
// Check if a distributor is already registered
if (await UnifiedPush.getDistributor() != "") {
  // Re-register in case something broke
  UnifiedPush.registerApp();
} else {
  // Get a list of distributors that are available
  final distributors = await UnifiedPush.getDistributors();
  // select one or show a dialog or whatever
  final distributor = myPickerFunc(distributors);
  // save the distributor
  UnifiedPush.saveDistributor(distributor);
  // register your app to the distributor
  UnifiedPush.registerApp();
}
```

**unregister**

```dart
// inform the library that you would like to unregister from receiving push messages
UnifiedPush.unregisterApp()
```
**Multi-connection app**

You may need multiple connections for your app, you will need to use, as above, the following functions:
- `UnifiedPush.registerAppWithDialog(instance);`
- `UnifiedPush.registerApp(instance);`
- `UnifiedPush.unregisterApp(instance);`

## Receiving Push Messages

There are 2 ways to initialize UnifiedPush to receive Push Messages:

1. [preferred] **Using a callback** for messages when the app is killed:
  * No need to declare code on platform-specific side
  * Foreground and background (callback) functions can be different
  * Callback functions need to be static
2. [if you need] **Setting a receiver** in the application:
  * Same functions whether the app is in background or foreground
  * No function need to be static

If your application needs multiple connections, for instance if it is multi-accounts, initialize **instanciated** functions, else use **single instance**.

{{< tabs "receiving" >}}
{{< tab "Using a Callback" >}}

For a **single instance** initialization, use `initializeWithCallback`:

```dart
    UnifiedPush.initializeWithCallback(
        onNewEndpoint, // takes (String endpoint) in args
        onRegistrationFailed, // takes no arg
        onRegistrationRefused, // takes no arg
        onUnregistered, // takes no arg
        onMessage, // takes (String message) in args
        bgNewEndpoint, // called when new endpoint in background, need to be static, takes (dynamic args) in args
        bgUnregistered, // called when unregistered in background, need to be static, takes (dynamic args) in args
        bgOnMessage // called when receiving a message in background, need to be static, takes (dynamic args) in args
    );
    
    void onNewEndpoint(String endpoint) {}

    void onRegistrationRefused() {

    void onRegistrationFailed() {}

    void onUnregistered() {}

    void onMessage(String message) {}

    static bgOnMessage(dynamic args) {
        final message = args["message"];
    }

    static bgNewEndpoint(dynamic args) {
        final endpoint = args["endpoint"];
    }

    static bgUnregistered(dynamic args) {}
```


If you need **instanciated functions**, use `initializeWithCallbackInstantiated`:

```dart
    UnifiedPush.initializeWithCallbackInstantiated(
        onNewEndpoint, // takes (String endpoint, String instance) in args
        onRegistrationFailed, // takes (String instance) in args
        onRegistrationRefused, // takes (String instance) in args
        onUnregistered, // takes (String instance) in args
        onMessage, // takes (String message, String instance) in args
        bgNewEndpoint, // called when new endpoint in background, need to be static, takes (dynamic args) in args
        bgUnregistered, // called when unregistered in background, need to be static, takes (dynamic args) in args
        bgOnMessage // called when receiving a message in background, need to be static, takes (dynamic args) in args
    );
    
    void onNewEndpoint(String endpoint, String instance) {}

    void onRegistrationRefused(String instance) {

    void onRegistrationFailed(String instance) {}

    void onUnregistered(String instance) {}

    void onMessage(String message, String instance) {}

    static bgOnMessage(dynamic args) {
        final message = args["message"];
        final instance = args["instance"];
    }

    static bgNewEndpoint(dynamic args) {
        final endpoint = args["endpoint"];
        final instance = args["instance"];
    }

    static bgUnregistered(dynamic args) {
        final instance = args["instance"];
    }
```

{{< /tab >}}
{{< tab "Using a Receiver" >}}

1. Set the engine on the android side of your app (typically in `android/app/src/main/kotlin/your/app/id/MainActivity.kt`):

```kotlin
class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
    };

    override fun provideFlutterEngine(context: Context): FlutterEngine? {
        return provideEngine(this)
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        // do nothing, because the engine was been configured in provideEngine
    }

    companion object {
        var engine: FlutterEngine? = null
        fun provideEngine(context: Context): FlutterEngine {
            var eng = engine ?: FlutterEngine(context, emptyArray(), true, false)
            engine = eng
            return eng
        }
    }
}
```

2. Add `implementation 'com.github.UnifiedPush:android-connector:{{VERSION}}'` to the android app build.gradle.

3. Declare the Receiver for UnifiedPush events (android side):

```kotlin
import org.unifiedpush.flutter.connector.UnifiedPushHandler
import org.unifiedpush.android.connector.MessagingReceiver

val receiverHandler = object : UnifiedPushService() {
    override fun getEngine(context: Context): FlutterEngine {
        return provideEngine(context)
    }

    fun provideEngine(context: Context): FlutterEngine {
        var engine = MainActivity.engine
        if (engine == null) {
            engine = MainActivity.provideEngine(context)
            engine.getLocalizationPlugin().sendLocalesToFlutter(
                context.getResources().getConfiguration())
            engine.getDartExecutor().executeDartEntrypoint(
                DartEntrypoint.createDefault())
        }
        return engine
    }
}

class UnifiedPushReceiver : MessagingReceiver(receiverHandler)
```

4. Add the UnifiedPush related actions to the (android side) manifest:

```xml
        <receiver android:exported="true"  android:enabled="true"  android:name=".UnifiedPushReceiver">
            <intent-filter>
                <action android:name="org.unifiedpush.android.connector.MESSAGE"/>
                <action android:name="org.unifiedpush.android.connector.UNREGISTERED"/>
                <action android:name="org.unifiedpush.android.connector.NEW_ENDPOINT"/>
                <action android:name="org.unifiedpush.android.connector.REGISTRATION_FAILED" />
                <action android:name="org.unifiedpush.android.connector.REGISTRATION_REFUSED" />
            </intent-filter>
        </receiver>
```

5. Flutter side, initialize UnifiedPush:

5.a. For a **single instance** initialization, use `initializeWithReceiver`:

```dart
    UnifiedPush.initializeWithReceiver(
        onNewEndpoint: onNewEndpoint, // takes (String endpoint) in args
        onRegistrationFailed: onRegistrationFailed, // takes no arg
        onRegistrationRefused: onRegistrationRefused, // takes no arg
        onUnregistered: onUnregistered, // takes no arg
        onMessage: onMessage, // takes (String message) in args
    );
```

5.b. If you need **instanciated functions**, use `initializeWithReceiverInstantiated`:

```dart
    UnifiedPush.initializeWithReceiverInstantiated(
        onNewEndpoint: onNewEndpoint, // takes (String endpoint, String instance) in args
        onRegistrationFailed: onRegistrationFailed, // takes (String instance) in args
        onRegistrationRefused: onRegistrationRefused, // takes (String instance) in args
        onUnregistered: onUnregistered, // takes (String instance) in args
        onMessage: onMessage, // takes (String message, String instance) in args
    );
```

{{< /tab >}}
{{< /tabs >}}

## Sending Push Messages

(From the application server)

To send a message to an application you need the "endpoint". You get it in the onNewEndpoint method once it is available. You can then use it to send a message using for example curl. The POST body is the message received by the function onMessage.

```bash
curl -X POST "$endpoint" --data "Any message body that is desired."
```

## Application With Embedded Distributor

On the Android side, you will need to import and declare the embedded distributor. Please refer to [Embedded FCM Distributor](/developers/embedded_fcm/) for more information.
