+++
title = "Go and C"
+++

These two libraries are grouped together since they're based on the same code.

- [Repository](github.com/UnifiedPush/go_dbus_connector)
- [Go Documentation](//pkg.go.dev/unifiedpush.org/go/dbus_connector)

An example app can be found in the \_examples folder of this module's repository.
A link to the documentation of this module can be found [here](/go/dbus_connector).

### C                                                                             
                                                                                  
The header files for the C library contains basic documentation, since it is only a wrapper around the Go lib that documentation will be very relevent. 
 
It can be built from source using just the Go command (check Makefile). The releases contain statically linkable .a files and dynamically loadable .so files. 

### Go

An example import statement for the Go library is
```go
import (
	up "unifiedpush.org/go/dbus_connector/api"
	"unifiedpush.org/go/dbus_connector/definitions"
)
```

### Usage

1. The first thing the program should do on startup is checking if the app has been activated in the background for a notification. In this case, it should initialize the minimum resources that are required to process (or decrypt depending upon your app) the notification. This is communicated using an argument to the program.


```go
	up.InitializeAndCheck("cc.malhotra.karmanyaah.testapp.golibrary", handlerStruct)
	// or
	up.Initialize("cc.malhotra.karmanyaah.testapp.golibrary", handlerStruct)
```
running `up.Initialize` requires manually checking for the argument given on background activation, in case of `InitializeAndCheck` that argument is `UNIFIEDPUSH_DBUS_BACKGROUND_ACTIVATION`. The program should quit with an exit code of 0 after handling background notifications, which InitializeAndCheck does.

The same applies to C except Initialize(AndCheck) takes in each function individually.
```c
	bool ok = UPInitializeAndCheck("cc.malhotra.karmanyaah.testapp.cgo", *newMessage, *newEndpoint, *unregistered);
```

2. If a distributor isn't already picked, the program should pick a distributor. If there are 0 distributors the program should stop using UnifiedPush; if there's 1, that should be auto-selected; and if there are more distributors, the user should be prompted to pick one.

```go
	if len(up.GetDistributor()) == 0 {
		pickDist()
	}
```
```c

	if (strnlen(UPGetDistributor(), 1) == 0)
		pickDistributors();
```

3. Every program should register each instance of notifications on startup, so that any updated endpoints can be sent.

```go
	result, reason, err := up.Register("")
```
```c
	struct UPRegister_return ret = UPRegister("");
	char *reason = ret.r1;
	int status = ret.r0;
```

The reason is usually a user-readable error message.

4. After this, your app can receive push notifications!
    Some other methods are provided to unregister and/or change the UP config which are availible in the Godoc and every method there also has a C version.

### Handler

The notification handlers should not be dependent on any state to exist since they can be called at any time. Check the examples for how to use them.
