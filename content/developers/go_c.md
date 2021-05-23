+++
title = "Go and C"
+++

These two libraries are grouped together since they're based on the same code.

- [Repository](github.com/UnifiedPush/go_dbus_connector)
- [Go Documentation](//pkg.go.dev/unifiedpush.org/go/dbus_connector)

An example app can be found in the [\_examples folder](//github.com/UnifiedPush/go_dbus_connector/tree/main/_examples) of this module's repository.

{{<toc>}}

## Installation

{{< tabs "installation" >}}
{{< tab "C" >}}
The header files for the C library contains basic documentation, since it is only a wrapper around the Go lib the godoc will be very relevant.

It can be built from source using just the Go command (check Makefile). The releases contain statically linkable .a files and dynamically loadable .so files.

```c
#include "libunifiedpush.h"
```

{{< /tab >}}
{{< tab "Go" >}}

An example import statement for the Go library is

```go
import (
    up "unifiedpush.org/go/dbus_connector/api"
    "unifiedpush.org/go/dbus_connector/definitions"
)
```

```bash
go get -u unifiedpush.org/go/dbus_connector
```

{{< /tab >}}
{{< /tabs >}}

## Usage

### Initialization

Every time the application starts up, it needs to initialize the UnifiedPush connector to be able to receive incoming messages. This is done with the function `up.Initialize` which takes in [handlers](#handler) and the name of your app in [reverse DNS notation](https://en.wikipedia.org/wiki/Reverse_domain_name_notation).

When the application starts, it should check if it has been awaken by an incoming message before running its main program. This is done by checking if `UNIFIEDPUSH_DBUS_BACKGROUND_ACTIVATION` is one of the given arguments, which is given by the DBus [service](#background-activation).

The method `up.InitializeAndCheck` does both and so it's preferred to run that.
In pseudocode, the function `up.InitializeAndCheck` does the following

```cpp
up.Initialize(whatever arguments are required)
bool programInBackground = "UNIFIEDPUSH_DBUS_BACKGROUND_ACTIVATION" in os.args
if (programInBackground) 
    Call background handlers
    wait for handlers to return
    exit
else
    return and the continue the program like normal in the foreground
```

{{< tabs "initialization" >}}
    {{< tab "C" >}}

```c
bool ok = UPInitializeAndCheck("org.example.app", *newMessage, *newEndpoint, *unregistered);
// or
bool ok = UPInitialize("org.example.app", *newMessage, *newEndpoint, *unregistered);
if (containsString("UNIFIEDPUSH_DBUS_BACKGROUND_ACTIVATION", argv)) { // containsString needs to be defined
    // your code here, for instance:
    sleep(5);
    // this gives the callback functions some time to run
    exit(0);
}
```

    {{< /tab >}}
    {{< tab "Go" >}} 

```go
up.InitializeAndCheck("org.example.app", handlerStruct)
// or
up.Initialize("org.example.app", handlerStruct)
if containsString(os.Args, "UNIFIEDPUSH_DBUS_BACKGROUND_ACTIVATION") { // containsString needs to be defined
    // your code here, for instance:
    time.Sleep(5 * time.Second) 
    // this gives the callback functions some time to run
    os.Exit(0)
}
```

    {{< /tab >}}
{{< /tabs >}}

### Distributor Selection

If a distributor isn't already picked, the program should pick a distributor. If there are 0 distributors the program should stop using UnifiedPush; if there's 1, that should be auto-selected; and if there are more distributors, the user should be prompted to pick one.

{{< tabs "dist_selection" >}}
    {{< tab "C" >}}

```c
if (strnlen(UPGetDistributor(), 1) == 0)
    pickDistributors();
```

    {{< /tab >}}
    {{< tab "Go" >}} 

```go
if len(up.GetDistributor()) == 0 {
    pickDist()
}
```

    {{< /tab >}}
{{< /tabs >}}

### (Re)Registration

Every program should register each instance of notifications on startup, so that any updated endpoints can be sent.

{{< tabs "registration" >}}
    {{< tab "C" >}}

```c
struct UPRegister_return ret = UPRegister("");
char *reason = ret.r1;
int status = ret.r0;
```

    {{< /tab >}}
    {{< tab "Go" >}} 

```go
result, reason, err := up.Register("")
```

    {{< /tab >}}
{{< /tabs >}}

The reason is usually a user-readable error message.

After this, your app can receive push notifications!
    Some other functions are provided to unregister and/or change the UP config which are available in the Godoc and every method there also has a C version.

## Handler

The notification handlers should not be dependent on any state to exist since they can be called at any time.

{{< tabs "handler" >}}
    {{< tab "C" >}}
The functions below are passed into the initialization. The function arguments are freed after the function returns so the data should be copied out if required. Each call gets an instance name which is the same as the one registered with.

```c
static void newMessage(char *instance, char *msg, char *id){
    printf("new message: %s\n", msg);
}

static void newEndpoint(char *instance, char *endpoint){
    printf("new endpoint received: %s\n", endpoint);
}

static void unregistered(char *instance){
    printf("instance unregistered\n");
}
```

    {{< /tab >}}
    {{< tab "Go" >}} 
A struct is passed during initialization which must contain the following methods.

```go
type NotificationHandler struct{}

func (n NotificationHandler) Message(instance, message, id string) {
    fmt.Println("new message received")
    _ := beeep.Notify("title", message, "")
}

func (n NotificationHandler) NewEndpoint(instance, endpoint string) {
    fmt.Println("New endpoint received", endpoint)
}

func (n NotificationHandler) Unregistered(instance string) {
    fmt.Println("endpoint unregistered")
}
```

    {{< /tab >}}
{{< /tabs >}}

- NewMessage receives a string that can be deserialized into whatever format the server sends (json, etc).
- NewEndpoint is called when a new endpoint needs to be saved or sent to the server.
- Unregister is called when the distributor has unregistered the app either due to request or something on the distributor side.

## Background activation

A D-Bus service file needs to be packaged with your application and placed in the D-Bus activation directory to let it activate for a background notification. The name here is the same argument passed to initialize; Exec is the binary being executed with the activation argument.

This directory is usually `share/dbus-1/services/` in `~/.local` or `/usr`

```service
[D-BUS Service]
Name=org.example.app
Exec=<path to binary>/appBinaryname UNIFIEDPUSH_DBUS_BACKGROUND_ACTIVATION
```
