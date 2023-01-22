---
title: Android
---

An [example application](https://github.com/UnifiedPush/android-example) is available to show basic usage of the library.

## Index

{{<toc>}}

## Install Library

Add the following two code snippets to your corresponding build files to include the library in your project.

Add the jitpack repo to the **project level** build.gradle:

```gradle
allprojects {
    repositories {
        // ...
        maven {
            url "https://www.jitpack.io"
            content {
                includeModule 'com.github.UnifiedPush', 'android-connector'
            }
        }
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

{{< tabs "registration" >}}
{{< tab "Kotlin" >}}
To register for receiving push services you have two options:
1. Have the library handle distributor selection

```kotlin
// Call the library function
// Options:
// "instance" to handle multiple registrations
// "RegistrationDialogContent" for the dialogs [1]
// "features" empty array or [FEATURE_BYTES_MESSAGE]
//     to be sure the distributor handles non-UTF-8 input
// "messageForDistributor" that may be displayed by the distrib.
//
// [1] To personnalize the dialogs:
//     RegistrationDialogContent().apply {noDistributorDialog.message = "0 found"}
// For other param, visit <https://github.com/UnifiedPush/android-connector/blob/main/connector/src/main/java/org/unifiedpush/android/connector/RegistrationDialogContent.kt>

registerAppWithDialog(context)
```

2. Handle selection yourself

```kotlin
// Check if a distributor is already registered
if (getDistributor(context).isNotEmpty()) {
    // Re-register in case something broke
    // Options:
    // "instance" to handle multiple registrations
    // "features" empty array or [FEATURE_BYTES_MESSAGE]
    //    to be sure the distributor handles non-UTF-8 input
    // "messageForDistributor" that may be displayed by the distrib.
    registerApp(context)
    return
}
// Get a list of distributors that are available
val distributors = getDistributors(context)
// select one or show a dialog or whatever
val userDistrib = yourFunc(distributors)
// save the distributor
saveDistributor(context, userDistrib)
// register your app to the distributor
// Options:
// "instance" to handle multiple registrations
// "features" empty array or [FEATURE_BYTES_MESSAGE]
//    to be sure the distributor handles non-UTF-8 input
// "messageForDistributor" that may be displayed by the distrib.
registerApp(context)
```

**unregister**

```kotlin
// inform the library that you would like to unregister from receiving push messages
// Options:
// "instance" to delete if used during registration
unregisterApp(context)
```

{{< /tab >}}
{{< tab "Java" >}}
To register for receiving push services you have two options:

1. Have the library handle distributor selection
```java
// Call the library function
//
// To personnalize the dialogs:
//     RegistrationDialogContent dialog = new RegistrationDialogContent()
//     dialog.getNoDistributorDialog().setMessage("0 found");
// For other param, visit <https://github.com/UnifiedPush/android-connector/blob/main/connector/src/main/java/org/unifiedpush/android/connector/RegistrationDialogContent.kt>
//
registerAppWithDialog(
    context, // Context
    "default", // instance
    new RegistrationDialogContent(), // dialogContent
    new ArrayList<String>(), // features, or ArrayList<String>(Collections.singleton(UnifiedPush.FEATURE_BYTES_MESSAGE)),
                             //    to be sure the distributor handles non-UTF-8 input
    context.getPackageName() // messageForDistributor
);
```

2. Handle selection yourself
```java
// Check if a distributor is already registered
if (!getDistributor(context).isEmpty()) {
    // Re-register in case something broke
    registerApp(
        context, // Context
        "default", // instance
        new ArrayList<String>(), // features, or ArrayList<String>(Collections.singleton(UnifiedPush.FEATURE_BYTES_MESSAGE)),
                                 //    to be sure the distributor handles non-UTF-8 input
        context.getPackageName() // messageForDistributor
    );
    return;
}
// Get a list of distributors that are available
List<String> distributors = getDistributors(context);
// select one or show a dialog or whatever
String userDistrib = yourFunc(distributors);
// the below line will crash the app if no distributors are available
saveDistributor(context, userDistrib);
registerApp(
    context, // Context
    "default", // instance
    new ArrayList<String>(), // features, or ArrayList<String>(Collections.singleton(UnifiedPush.FEATURE_BYTES_MESSAGE)),
                             //    to be sure the distributor handles non-UTF-8 input
    context.getPackageName() // messageForDistributor
);

```

**unregister**
```java
// inform the library that you would like to unregister from receiving push messages
unregisterApp(
    context,
    "default" // instance
);
```

{{< /tab >}}
{{< /tabs >}}

## Receiving Push Messages

To receive Push Messages you should extend the class _MessagingReceiver_ and implement the 5 following methods:

{{< tabs "Receiver" >}}
{{< tab "Kotlin" >}}

```kotlin
class CustomReceiver: MessagingReceiver() {
    override fun onMessage(context: Context, message: ByteArray, instance: String) {
        // Called when a new message is received. The message contains the full POST body of the push message
    }

    override fun onNewEndpoint(context: Context, endpoint: String, instance: String) {
        // Called when a new endpoint be used for sending push messages
    }

    override fun onRegistrationFailed(context: Context, instance: String) {
        // called when the registration is not possible, eg. no network
    }

    override fun onUnregistered(context: Context, instance: String){
        // called when this application is unregistered from receiving push messages
    }
}
```
{{< /tab >}}
{{< tab "Java" >}}
```java
class CustomReceiver extends MessagingReceiver {
    public CustomReceiver() {
        super();
    }
    @Override
    public void onNewEndpoint(@NotNull Context context, @NotNull String endpoint, @NotNull String instance) {
        // Called when a new endpoint be used for sending push messages
    }

    @Override
    public void onRegistrationFailed(@NotNull Context context, @NotNull String instance) {
        // called when the registration is not possible, eg. no network
    }

    @Override
    public void onUnregistered(@NotNull Context context, @NotNull String instance) {
        // called when this application is unregistered from receiving push messages
    }

    @Override
    public void onMessage(@NotNull Context context, @NotNull byte[] message, @NotNull String instance) {
        // Called when a new message is received. The message contains the full POST body of the push message
    }
}

```
{{< /tab >}}
{{< /tabs >}}

You will also need to declare the receiver in your manifest:

```xml
      <receiver android:exported="true"  android:enabled="true"  android:name=".CustomReceiver">
          <intent-filter>
              <action android:name="org.unifiedpush.android.connector.MESSAGE"/>
              <action android:name="org.unifiedpush.android.connector.UNREGISTERED"/>
              <action android:name="org.unifiedpush.android.connector.NEW_ENDPOINT"/>
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

Please refer to [Embedded FCM Distributor](/developers/embedded_fcm/) for more information.
