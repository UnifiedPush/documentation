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

Add the following code to your pubspec.yaml. At the moment you still have to add it as a git dependency.
```pubspec
  unifiedpush:
    git:
      url: https://github.com/UnifiedPush/flutter-connector.git
      ref: main
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

There is 2 ways to initialize UnifiedPush to receive Push Messages:
* [prefered] Using a callback for messages when the app is killed.
* [if you need] Setting a receiver in the application.

#### Receiving Push Messages using a callback

In your application, just initialize UnifiedPush with `initializeWithCallback`:

```flutter
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

```
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

```flutter
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

## Using the FCM-added version

* Add `getEndpoint` to the UnifiedPush initialization. It have to take `String token` as an arg and returns `String endpoint` of the FCM proxy.
* Add `apply plugin: 'com.google.gms.google-services'` to your android app level build.gradle.
* Add the google-services.json file from firebase to your app directory.
* Change the pubspec.lock to use `flutter-connector_fcm_added` instead of `flutter-connector`

For instance, you can find a difference between fcm_added and main of the example here <https://github.com/UnifiedPush/flutter-connector_fcm_added/commit/6ab2e64636686bcf41f26967a1db6dc7ed44f0fc>.

You, as developper, will need a [FCM Rewrite Proxy](/developers/FCM_Proxy/) for FCM to work.
