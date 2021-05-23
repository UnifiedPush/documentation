+++
title = "Go and C"
+++

These two libraries are grouped together since they're based on the same code.

- [Repository](github.com/UnifiedPush/go_dbus_connector)

An example app can be found in the [\_examples folder](//github.com/UnifiedPush/go_dbus_connector/tree/main/_examples) of this module's repository.
A link to the documentation of this module can be found [here](/go/dbus_connector).

### C

The header files for the C library contains basic documentation, since it is only a wrapper around the Go lib the godoc will be very relevant.

It can be built from source using just the Go command (check Makefile). The releases contain statically linkable .a files and dynamically loadable .so files.

```c
#include "libunifiedpush.h"
```

### Go

[Go Documentation](//pkg.go.dev/unifiedpush.org/go/dbus_connector)

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

### Usage

#### Initialization

On startup the program should check if it was awaken for push first. If so, it should initialize as little as required to notify the user. The background status is in an argument.

Running `up.Initialize` requires manually checking for the argument. `UNIFIEDPUSH_DBUS_BACKGROUND_ACTIVATION` is the recommended argument to be used in the DBus service file.  

In pseudocode, the function `up.InitializeAndCheck` does the following

```
up.Initialize(whatever arguments are required)
if (program is in background) //UNIFIEDPUSH_DBUS_BACKGROUND_ACTIVATION is given
	Call background handlers
	once the handlers return, exit
else
	return and the program continues like normal in the foreground
```

**Go**

```go
	up.InitializeAndCheck("cc.malhotra.karmanyaah.testapp.golibrary", handlerStruct)
	// or
	up.Initialize("cc.malhotra.karmanyaah.testapp.golibrary", handlerStruct)
```

**C**

```c
	bool ok = UPInitializeAndCheck("cc.malhotra.karmanyaah.testapp.cgo", *newMessage, *newEndpoint, *unregistered);
	// or
	bool ok = UPInitialize("cc.malhotra.karmanyaah.testapp.cgo", *newMessage, *newEndpoint, *unregistered);
```

#### Distributor Selection

If a distributor isn't already picked, the program should pick a distributor. If there are 0 distributors the program should stop using UnifiedPush; if there's 1, that should be auto-selected; and if there are more distributors, the user should be prompted to pick one.

**Go**

```go
	if len(up.GetDistributor()) == 0 {
		pickDist()
	}
```

**C**

```c

	if (strnlen(UPGetDistributor(), 1) == 0)
		pickDistributors();
```

#### (Re)Registration

Every program should register each instance of notifications on startup, so that any updated endpoints can be sent.

**Go**

```go
	result, reason, err := up.Register("")
```

**C**

```c
	struct UPRegister_return ret = UPRegister("");
	char *reason = ret.r1;
	int status = ret.r0;
```

The reason is usually a user-readable error message.

After this, your app can receive push notifications!
    Some other functions are provided to unregister and/or change the UP config which are available in the Godoc and every method there also has a C version.

### Handler

#### C

The notification handlers should not be dependent on any state to exist since they can be called at any time.

```c
static void newMessage(char *instance, char *msg, char *id)
{
	printf("new message: %s\n", msg);
}

static void newEndpoint(char *instance, char *endpoint)
{
	printf("new endpoint received: %s\n", endpoint);
}

static void unregistered(char *instance)
{
	printf("instance unregistered\n");
}
```

The functions above are passed into the initialization. In C, the function arguments are freed after the function returns so the data should be copied out if required. Each call gets an instance name which is the same as the one registered with.

#### Go

In Go, a struct is passed during initialization which must contain the following methods.

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

- NewMessage receives a string that can be deserialized into whatever format the server sends (json, etc).
- NewEndpoint is called when a new endpoint needs to be saved or sent to the server.
- Unregister is called when the distributor has unregistered the app either due to request or something on the distributor side.
