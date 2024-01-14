---
title: Gateway

aliases: ["/developers/gateway/"]
---

{{< hint type=important >}}
**For self-hosters only**

If you use a public push server, this page doesn't apply to you.
This page contains information to setup a component that can be used by people self-hosting their push server.
{{< /hint >}}

Gateways are ways to convert the application server format of notifications to the UnifiedPush format of notifications. 

Right now, the only gateway that exists is for the Matrix protocol.

## Discovery & Hosting

App developers should host default gateways (otherwise it'll be impossible to use your app with a public push server), however for some gateways, the user can host their own. This is called **Gateway Discovery**.

## Matrix

Matrix homeservers don't directly support UnifiedPush (yet). This means that a gateway is needed.

**All Matrix applications have defined a default gateway that will forward notifications to your push server. You can use your own Matrix gateway instead if you host your push server yourself and also want to host the gateway yourself.**

Discovery URL: `http(s)://endpoint.domain/_matrix/push/v1/notify` (replace whole path and query with `/_matrix/push/v1/notify`)

Discovery GET response: `{"unifiedpush":{"gateway":"matrix"}}`

### Gateway built-in to push servers

**Recommended**

Some push servers come with a built-in matrix gateway :

* [ntfy](/users/distributors/ntfy/)

* [NextPush](/users/distributors/nextpush/) You need to setup a rule on your reverse proxy. More information at <https://github.com/UP-NextPush/server-app#gateways>

### Common-Proxies

**If your push servers does not have a built-in gateway or you want to host a public gateway**

Common-Proxies is a set of rewrite proxies and push gateways for UnifiedPush. It can be used as a matrix gateway. If needed, it supports forwarding to any public remote URL with defense against requests to internal networks.

Information on setup is in the documentation for the [Common-Proxies](https://github.com/UnifiedPush/common-proxies)

