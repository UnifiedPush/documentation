---
geekdocHidden: true
geekdocHiddenTocTree: false
title: ntfy - Android
weight: 10
---

ntfy is an easy way to set up push server that does not require an account.

* License: Apache2 | GPLv2
* Server sources: <https://github.com/binwiederhier/ntfy>
* Android sources: <https://github.com/binwiederhier/ntfy-android>
* website: <https://ntfy.sh/>
* Technology: WebSockets ([default](https://ntfy.sh/docs/deprecations/#android-app-websockets-will-become-the-default-connection-protocol)) or HTTP JSON stream (Like HTTP Server Sent Events)
* Download for Android:

[<img alt="Get it on F-Droid" src="/img/f-droid-badge.png" height=100 >](https://f-droid.org/packages/io.heckel.ntfy)

## Set Up

* Install this app on your device.
* Open it once.
* You're ready!

## Self Hosting

If you want to self host the server, you can find the steps here: <https://ntfy.sh/docs/install/>

### Matrix Gateway

ntfy has a Matrix gateway built-in. It can convert the Matrix Push Format -> the UnifiedPush format. You MUST configure the **base-url** for the Matrix gateway to work! See ntfy docs for the specifics of setting that up.

### Limit access to some users (ACL)

By default, ntfy allows everyone to use a server.
As push URLs should be secret, this shouldn't be of concern for most people.
Nevertheless, it could be abused in some way or another by actors using the resources of your server, maybe even for malicious purposes.
The following steps will lock the server down to only allow manually-created users to read and send notifications, while still allowing external services to send UnifiedPush notifications.

**Note:** since passwords are sent to the server for authentication, you probably want to secure ntfy with HTTPS to prevent others from sniffing them.

* To allow only users to read and write topics, you need to enable authentication:
  * Create a config.yml file if it doesn't exist (by default in `/etc/ntfy/config.yml` )
  * As the [ntfy docs say](https://ntfy.sh/docs/config/#example-private-instance), add the following to enable access control:
  ```yaml
  auth-file: "/var/lib/ntfy/user.db" # Specify user database path
  auth-default-access: "deny-all" # Only users will be able to read or write topics
  ```
  * Restart ntfy server, it will create the db file
  * Add a user:
    * `ntfy user add --role=admin someuser` (`--role=admin` is optional here)
    * Type a password
    * If the user isn't admin, give it read and/or write access to some topics, at least the UnifiedPush ones:
      * `ntfy access someuser 'up*' read-only` To make that user only able to subscribe to UnifiedPush topics (necessary to use UnifiedPush)
      * `ntfy access someuser '*' read-write` To give that user the ability to subscribe and publish to any topics, including UnifiedPush ones (this is the default for everyone if authentication is disabled)
    * Repeat as many times as desired. See [ntfy docs on user management](https://ntfy.sh/docs/config/#users-and-roles) for more details.
* Pushers still need to be able to write to UnifiedPush topics to send push notifications. Add a rule to make UnifiedPush topics (they all start with "up") world-writeable:
    * `ntfy access '*' 'up*' write-only`
* Log in with the distributor app. On ntfy Android:
  * Settings -> Manage users -> Add new user
  * Service URL: your ntfy instance. For instance, `https://ntfy.example.com/
  * Username and password: the ones you chose previously

<details><summary>Notes for Docker users</summary>

* You might want to adjust the user DB path to something like `/etc/ntfy/user.db`, or mount `/var/lib/ntfy` as a volume to keep it somewhere safe.
* You will probably want to use `docker exec -it ntfy-container-name ntfy` instead of `ntfy` (replace ntfy-container-name with the appropriate one).
  * For instance, with the command `docker exec -it ntfy-container-name ntfy user add --role=admin someuser`
</details>
