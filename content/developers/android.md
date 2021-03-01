---
title: Android
---

An [example application](https://github.com/UnifiedPush/android-example) is available to show basic usage of the library.

## Index

* [Install Library](#install-library)
* [Register For Push](#register-for-push)
* [Receiving Push Messages](#receiving-push-messages)
* [Sending Push Messages](#sending-push-messages) (from the application server)
* [Using the FCM-added version](#using-the-fcm-added-version)


## Install Library

Add the following two code snippeds to your corresponding build files to include the library in your project.

Add the jitpack repo to the **project level** build.gradle:
```gradle
allprojects {
    repositories {
        // ...
        maven { url 'https://jitpack.io' }
    }
}
```

Add the dependency to the **app** build.gradle. Replace {VERSION} with the release you wish to use
```gradle
dependencies {
    // ...
    implementation 'com.github.UnifiedPush:android-connector:{VERSION}'
}
```

## Register for Push

To register for receiving push services you have two options:

1. Have the library handle distributor selection
```kotlin
// Call the library function
registerAppWithDialog(context)
```

2. Handle selection yourself
```kotlin
// Get a list of distributors that are available
val distributors = getDistributors(context)
// select one or show a dialog or whatever
// the below line will crash the app if no distributors are available
saveDistributor(context, distributors[0])
registerApp(context)
```

**unregister**
```kotlin
// inform the library that you would like to unregister from receiving push messages
unregisterApp(context)
```

**Multi-connection app**
You may need multiple connections for your app, you will need to use, as above, the following functions:
* `registerAppWithDialog(context, instance)`
* `registerApp(context, instance)`
* `unregisterApp(context, instance)`

## Receiving Push Messages

To receive Push Messages you should extend the class _MessagingReceiver_ and implement the 5 following methods:

Kotlin
```kotlin
val handler = object: MessagingReceiverHandler{
    override fun onMessage(context: Context?, message: String, instance: String) {
        // Called when a new message is received. The String contains the full POST body of the push message
    }

    override fun onNewEndpoint(context: Context?, endpoint: String, instance: String) {
        // Called when a new endpoint be used for sending push messages
    }
    
    override fun onRegistrationFailed(context: Context?, instance: String) {
        // called when the registration is not possible, eg. no network
    }
    
    override fun onRegistrationRefused(context: Context?, instance: String) {
        // called when the registration is refused, eg. an application with the same Id and another token is registered
    }
    
    override fun onUnregistered(context: Context?, instance: String){
        // called when this application is unregistered from receiving push messages
    }
}

class CustomReceiver: MessagingReceiver(handler)
```

Java
```java
class handler implements MessagingReceiverHandler {
    @Override
    public void onNewEndpoint(@Nullable Context context, @NotNull String endpoint, @NotNull String instance) {
        // Called when a new endpoint be used for sending push messages
    }

    @Override
    public void onRegistrationFailed(@Nullable Context context, @NotNull String instance) {
        // called when the registration is not possible, eg. no network
    }

    @Override
    public void onRegistrationRefused(@Nullable Context context, @NotNull String instance) {
        // called when the registration is refused, eg. an application with the same Id and another token is registered
    }

    @Override
    public void onUnregistered(@Nullable Context context, @NotNull String instance) {
        // called when this application is unregistered from receiving push messages
    }

    @Override
    public void onMessage(@Nullable Context context, @NotNull String message, @NotNull String instance) {
        // Called when a new message is received. The String contains the full POST body of the push message
    }
}

class CustomReceiver extends MessagingReceiver {
    public CustomReceiver() {
        super(new handler());
    }
}
```

You will also need to declare the receiver in your manifest:

```
      <receiver android:exported="true"  android:enabled="true"  android:name=".CustomReceiver">
          <intent-filter>
              <action android:name="org.unifiedpush.android.connector.MESSAGE"/>
              <action android:name="org.unifiedpush.android.connector.UNREGISTERED"/>
              <action android:name="org.unifiedpush.android.connector.NEW_ENDPOINT"/>
              <action android:name="org.unifiedpush.android.connector.REGISTRATION_FAILED"/>
              <action android:name="org.unifiedpush.android.connector.REGISTRATION_REFUSED"/>
          </intent-filter>
      </receiver>
```

## Sending Push Messages
(From the application server)

To send a message to an application you need the "endpoint". You get it in the onNewEndpoint method once it is available. You can then use it to send a message using for example curl. The POST body is the message received by the function onMessage.
```bash
curl -X POST "$endpoint" --data "Any message body that is desired."
```

## Application With Embedded Distributor

Please refere to [Embedded FCM Distributor](/developers/embedded_fcm/) for more information.

