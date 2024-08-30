---
title: Android
---

An [example application](https://codeberg.org/UnifiedPush/android-example) is available to show basic usage of the library.

## Index

{{<toc>}}

## Declare dependencies

Add the dependency to the **app** build.gradle. Replace {VERSION} with the last versions ([connector](https://central.sonatype.com/artifact/org.unifiedpush.android/connector), [connector-ui](https://central.sonatype.com/artifact/org.unifiedpush.android/connector-ui)).

```groovy
dependencies {
    // ...
    implementation 'org.unifiedpush.android:connector:{VERSION}'
    // If you wish to use connector-ui dialog
    implementation 'org.unifiedpush.android:connector-ui:{VERSION}'
}
```

## Register for Push

{{< tabs "registration" >}}
{{< tab "Kotlin" >}}

**Select a distributor and register**

To register for receiving push services you have two options:

{{< expand "Use connector-ui's dialog" >}}

If there is no distributor, it will inform the user they need one.

If there is a single distributor, it will register to it.

If there are many distributors, it will open a dialog to ask the user which one to use.

Once a distributor is saved, calling this method will register again to the saved distributor.

```kotlin
import org.unifiedpush.android.connector.INSTANCE_DEFAULT
import org.unifiedpush.android.connector.UnifiedPush
import org.unifiedpush.android.connector.ui.SelectDistributorDialogBuilder
import org.unifiedpush.android.connector.ui.UnifiedPushFunctions
/* ... */

// Options:
// "instances" can be used to handle multiple registrations

SelectDistributorDialogBuilder(
    context,
    listOf<String>(INSTANCE_DEFAULT),
    object : UnifiedPushFunctions {
        override fun getAckDistributor(): String? =
            UnifiedPush.getAckDistributor(context)

        override fun getDistributors(): List<String> =
            UnifiedPush.getDistributors(context, UnifiedPush.DEFAULT_FEATURES)

        override fun registerApp(instance: String) =
            UnifiedPush.registerApp(context, instance, UnifiedPush.DEFAULT_FEATURES)

        override fun saveDistributor(distributor: String) =
            UnifiedPush.saveDistributor(context, distributor)
    }
).show()
```

It is possible to customize this dialog by extending `SelectDistributorDialogBuilder`:

```kotlin
SelectDistributorDialogBuilder(
    context,
    listOf<String>(INSTANCE_DEFAULT),
    object : UnifiedPushFunctions {/*...*/}
){
    override var registrationDialogContent = MyDialogContent // See https://codeberg.org/UnifiedPush/android-connector-ui/src/branch/main/connector_ui/src/main/java/org/unifiedpush/android/connector/ui/RegistrationDialogContent.kt

    override fun onNoDistributorFound() {
        // TODO
    }

    override fun onDistributorSelected(distributor: String) {
        // TODO
    }

    override fun onManyDistributorsFound(distributors: List<String>) {
        // TODO
    }
}.show()
```
{{< /expand >}}

{{< expand "Handle the selection yourself" >}}

```kotlin
import org.unifiedpush.android.connector.UnifiedPush.*
/* ... */

// Check if a distributor is already registered
getAckDistributor(context)?.let {
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

{{< /expand >}}

**Unregister**

```kotlin
// inform the library that you would like to unregister from receiving push messages
// Options:
// "instance" to delete if used during registration
unregisterApp(context)

// You won't receive onUnregistered for this instance
```

{{< /tab >}}
{{< tab "Java" >}}

**Select a distributor and register**

To register for receiving push services you have two options:

{{< expand "Use connector-ui's dialog" >}}

If there is no distributor, it will inform the user they need one.

If there is a single distributor, it will register to it.

If there are many distributors, it will open a dialog to ask the user which one to use.

Once a distributor is saved, calling this method will register again to the saved distributor.

```java
import static org.unifiedpush.android.connector.ConstantsKt.INSTANCE_DEFAULT;
import org.unifiedpush.android.connector.UnifiedPush;
import org.unifiedpush.android.connector.ui.SelectDistributorDialogBuilder;
import org.unifiedpush.android.connector.ui.UnifiedPushFunctions;
/* ... */

// First you need to create a class that implements UnifiedPushFunctions:
private class UPFunctions implements UnifiedPushFunctions {
    Context context;
    public UPFunctions(Context context) {
        this.context = context;
    }
    @Nullable
    @Override
    public String getAckDistributor() {
        return UnifiedPush.getAckDistributor(context);
    }

    @NonNull
    @Override
    public List<String> getDistributors() {
        return UnifiedPush.getDistributors(context, UnifiedPush.getDEFAULT_FEATURES());
    }

    @Override
    public void registerApp(@NonNull String instance) {
        UnifiedPush.registerApp(context, instance, UnifiedPush.getDEFAULT_FEATURES(), "MyApp");
    }

    @Override
    public void saveDistributor(@NonNull String distributor) {
        UnifiedPush.saveDistributor(context, distributor);
    }
}

/* ... */

// Then you can use the dialog in a function:
// Options:
// "instances" can be used to handle multiple registrations

    SelectDistributorDialogBuilder builder = new SelectDistributorDialogBuilder(
        this,
        List.of(INSTANCE_DEFAULT),
        new UPFunctions(this)
    );
    builder.show();
```

It is possible to customize this dialog by extending `SelectDistributorDialogBuilder`:

```java
private class MyDialogBuilder extends SelectDistributorDialogBuilder {
        public MyDialogBuilder(@NonNull Context context, @NonNull List<String> instances, @NonNull UnifiedPushFunctions unifiedPushFunctions) {
            super(context, instances, unifiedPushFunctions);
        }
        RegistrationDialogContent registrationDialogContent = MyContent;
        @Override
        public void onNoDistributorFound() {
            // TODO
        }
        @Override
        public void onDistributorSelected(@NonNull String distributor) {
            // TODO
        }
        @Override
        public void onManyDistributorsFound(@NonNull List<String> distributors) {
            // TODO
        }
    }
```
{{< /expand >}}

{{< expand "Handle the selection yourself" >}}

```java
import static org.unifiedpush.android.connector.ConstantsKt.INSTANCE_DEFAULT;
import org.unifiedpush.android.connector.UnifiedPush;
/* ... */

// Check if a distributor is already registered
if (UnifiedPush.getAckDistributor(context) != null) {
    // Re-register in case something broke
    UnifiedPush.registerApp(
        context, // Context
        INSTANCE_DEFAULT, // instance
        UnifiedPush.getDEFAULT_FEATURES(), // features, or ArrayList<String>(Collections.singleton(UnifiedPush.FEATURE_BYTES_MESSAGE)),
                                 //    to be sure the distributor handles non-UTF-8 input
        context.getPackageName() // messageForDistributor
    );
    return;
}
// Get a list of distributors that are available
List<String> distributors = UnifiedPush.getDistributors(context);
// select one or show a dialog or whatever
String userDistrib = yourFunc(distributors);
// the below line will crash the app if no distributors are available
UnifiedPush.saveDistributor(context, userDistrib);
UnifiedPush.registerApp(
    context, // Context
    INSTANCE_DEFAULT, // instance
    UnifiedPush.getDEFAULT_FEATURES(), // features, or ArrayList<String>(Collections.singleton(UnifiedPush.FEATURE_BYTES_MESSAGE)),
                             //    to be sure the distributor handles non-UTF-8 input
    context.getPackageName() // messageForDistributor
);

```

{{< /expand >}}

**Unregister**
```java
// inform the library that you would like to unregister from receiving push messages
UnifiedPush.unregisterApp(
    context,
    INSTANCE_DEFAULT // instance
);

// You won't receive onUnregistered for this instance
```

{{< /tab >}}
{{< /tabs >}}

## Receiving Push Messages

To receive Push Messages you should extend the class _MessagingReceiver_ and implement the following four methods:

{{< tabs "Receiver" >}}
{{< tab "Kotlin" >}}

```kotlin
class CustomReceiver: MessagingReceiver() {
    override fun onMessage(context: Context, message: ByteArray, instance: String) {
        // Called when a new message is received. The message contains the full POST body of the push message
    }

    override fun onNewEndpoint(context: Context, endpoint: String, instance: String) {
        // Called when a new endpoint is to be used for sending push messages
        // You should send the endpoint to your application server
        // and sync for missing notifications.
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

## Manifest

You will also need to declare the receiver in your manifest:

```xml
      <receiver android:exported="true"  android:enabled="true"  android:name=".CustomReceiver">
          <intent-filter>
              <action android:name="org.unifiedpush.android.connector.MESSAGE"/>
              <action android:name="org.unifiedpush.android.connector.UNREGISTERED"/>
              <action android:name="org.unifiedpush.android.connector.NEW_ENDPOINT"/>
              <action android:name="org.unifiedpush.android.connector.REGISTRATION_FAILED"/>
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
