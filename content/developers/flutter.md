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

Add the following code to your pubspec.yaml.
```yaml
  unifiedpush: ^1.0.1
```

## Register for Push

To register for receiving push services you have two options, after initializing:

1. Have the library handle distributor selection
```dart
// Call the library function
UnifiedPush.registerAppWithDialog()
```

2. Handle selection yourself
```dart
// Get a list of distributors that are available
final distributors = await UnifiedPush.getDistributors()
// select one or show a dialog or whatever
// the below line will crash the app if no distributors are available
UnifiedPush.saveDistributor(distributors[0])
UnifiedPush.registerApp()
```

**unregister**
```dart
// inform the library that you would like to unregister from receiving push messages
UnifiedPush.unregisterApp()
```

## Receiving Push Messages

There are 2 ways to initialize UnifiedPush to receive Push Messages:
* [prefered] Using a callback for messages when the app is killed.
* [if you need] Setting a receiver in the application.

#### Receiving Push Messages using a callback

In your application, just initialize UnifiedPush with `initializeWithCallback`:

```dart
    UnifiedPush.initializeWithCallback(
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

#### Receiving Push Messages using a receiver

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

5. Flutter side, initialize UnifiedPush with `initializeWithReceiver`:

```dart
    UnifiedPush.initializeWithReceiver(
        onNewEndpoint, // takes String endpoint in arg
        onRegistrationFailed,
        onRegistrationRefused,
        onUnregistered,
        onMessage, // takes String message in arg
    );
```

## Sending Push Messages
(From the application server)

To send a message to an application you need the "endpoint". You get it in the onNewEndpoint method once it is available. You can then use it to send a message using for example curl. The POST body is the message received by the function onMessage.

```bash
curl -X POST "$endpoint" --data "Any message body that is desired."
```

## Application With Embedded Distributor

On the Android side, you will need to import and declare the embedded distributor. Please refere to [Embedded FCM Distributor](/developers/embedded_fcm/) for more information.

