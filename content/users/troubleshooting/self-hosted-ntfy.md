---
title: Troubleshooting Self-Hosted Ntfy Server
---

This page helps you resolve problems with self-hosting Ntfy servers. This is aimed at people managing their own servers.

*See also: [Troubleshooting your setup](/users/troubleshooting/), aimed at end-users but also helpful for people managing their own servers.*

---

## Index

{{<toc>}}

## Limit access to some users (ACL)

You may have limited access to some users. But application servers pushing to your ntfy server aren't registered on it, so you must ensure `/up*` subject are world writable.

For further informations, refere to [the self-hosting documentation](/users/distributors/ntfy/#self-hosting).

## Rate limits

Ntfy has a rate limiting settings. If you see 429 messages on you server logs, you may have enabled it.

For further informations, refere to [ntfy limitation](https://docs.ntfy.sh/publish/#limitations).

## Matrix Gateway

If your matrix client shows a matrix gateway that isn't your ntfy server, you probably not have configured the `base-url` settings, or you host your ntfy server on a subpath.

You must see the json `{"unifiedpush":{"gateway":"matrix"}}` if you go, with a browser, to https://YOURDOMAIN/_matrix/push/v1/notify, with this exact absolute path. Else configure your reverse-proxy.

For further informations, refere to [the self-hosting documentation](/users/distributors/ntfy/#self-hosting), and the [gateway documentation](/users/gateway/).

