---
title: Troubleshooting Self-Hosted UnifiedPush and Matrix Servers
---

This page helps you resolve problems with self-hosting and integrating your UnifiedPush and Matrix (Synapse) servers. This is aimed at people managing their own servers.

---

First, **if you self-host your matrix homeserver and your push server: there is a high probability you have not set the [`ip_range_whitelist`](https://matrix-org.github.io/synapse/latest/usage/configuration/config_documentation.html#ip_range_whitelist)**.

  * You have to whitelist your push server (e.g. ntfy server) IP address as seen by your synapse server. It may be a private IP depending on your setup.

  * Check your synapse's logs.

Then, you should run the notifications troubleshooter feature on Element, and check the push history on Element-X.

If you don't receive the notification, the problem comes from your push provider:

  * If you use ntfy, double check you have correctly set the authorizations: UnifiedPush topics (they all start with “up”) world-writeable (https://unifiedpush.org/users/distributors/ntfy/#limit-access-to-some-users-acl) *

  * Test with [UP-Example](https://f-droid.org/en/packages/org.unifiedpush.example/) ([see how](/users/troubleshooting/#troubleshooting-with-the-up-example-app-android))

If you receive the test notification:

  * Have you check the `ip_range_whitelist` ? Once again, this is a very common error *

  * Check your synapse logs

  * Make sure your synapse server can reach your push server: open a shell on your synapse server, or container if you use it, and try to send a request with curl `curl https://mypushdomain.tld/foo` *

  * Make sure you have disable battery optimization for your distributor and Element. On recent Android systems, you have to enable "Allow background usage", __and the click on this label__ to open a new menu, then thick "Unrestricted".

  * Check https://dontkillmyapp.com/ and follow the suggested steps if needed

---

\* *indicates the most common issues.*

---

*See also: [Troubleshooting your setup](/users/troubleshooting/), aimed at end-users but also helpful for people managing their own servers.*

*See also: [mpeter50's Matrix-Ntfy debugging advices for 2024 Q2](https://gist.github.com/mpeter50/9220dac1056c9a66c313d049838c1ab2).*
