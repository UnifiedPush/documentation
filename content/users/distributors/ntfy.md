---
geekdocHidden: true
geekdocHiddenTocTree: false
title: ntfy - Android
weight: 10
---
[<img alt="Get it on F-Droid" src="/img/f-droid-badge.png" height=100 >](https://f-droid.org/packages/io.heckel.ntfy)
[<img alt="Get it on Google Play" src="/img/google-play-badge.png" height=100>](https://play.google.com/store/apps/details?id=io.heckel.ntfy)

ntfy (pronounced "notify") is an open-source push notification service that can be used as a UnifiedPush distributor. You can use it with the default server without needing to sign up to an account.
# Details
* License: Apache2 | GPLv2
* Server sources: [https://github.com/binwiederhier/ntfy](https://github.com/binwiederhier/ntfy)
* Android sources: [https://github.com/binwiederhier/ntfy-android](https://github.com/binwiederhier/ntfy-android)
* website: [https://ntfy.sh/](https://ntfy.sh/)
* Technology: WebSockets ([default](https://ntfy.sh/docs/deprecations/#android-app-websockets-will-become-the-default-connection-protocol)) or HTTP JSON stream (Like HTTP Server Sent Events)

## ntfy quickstart guide
### Step 1: Download ntfy
You can install ntfy from one of the following sources:
- [Google Play Store](https://play.google.com/store/apps/details?id=io.heckel.ntfy)
- [F-Droid](https://f-droid.org/en/packages/io.heckel.ntfy/)
### Step 2: Install ntfy (skip step if you used Google Play Store or F-Droid)
1. If you downloaded the APK, locate it in your device’s Downloads folder.
2. Tap the APK file to begin installation.
3. Follow the on-screen prompts to complete the installation.
### Step 3: Configure ntfy
1. Open the ntfy app after installation.
2. Open **Settings**
3. Choose a Server:
   * Use the public server at https://ntfy.sh (default).
   * If you’re self-hosting ntfy, enter your server’s URL (e.g., https://ntfy.example.com).
### Step 4: Configure ntfy as your UnifiedPush distributor
1. Open the app you want to use with UnifiedPush (e.g., a messaging app or email client).
2. Navigate to the app’s **Push Notification Settings** or **UnifiedPush** Settings.
3. Select **nfty** as the UnifiedPush distributer
4. Save the settings, and the app will now use nfty to deliver push notifications.
### Step 5: Test notifications
1. Trigger a test notification from the app you chose.
2. Ensure that the notification is delivered to your device successfully (you should be able to see the notification in the nfty logs)
3. If notifications are not working, check nfty’s settings and ensure it has the necessary permissions to run in the background.

## Self Hosting
If you prefer to self-host ntfy, follow the official installation guide:
[ntfy Self-Hosting Documentation](https://ntfy.sh/docs/install/).
### Matrix Gateway
ntfy includes a built-in **Matrix gateway** that converts Matrix Push Format messages into the UnifiedPush format.
**Important:** You must configure the base-url for the Matrix gateway to function. Refer to the [ntfy documentation](https://ntfy.sh/docs/config/) for setup details.
### Restricting Access with Access Control Lists (ACL)
By default, ntfy allows anyone to use the server. While push URLs are secret and generally secure, you may want to restrict access to prevent misuse of server resources. Follow these steps to lock down your server:
#### Step 1: Enable Authentication
1. Create or edit the config.yml file (default location: /etc/ntfy/config.yml).
2. Add the following lines to enable access control:
```
auth-file: "/var/lib/ntfy/user.db"  # Path to the user database
auth-default-access: "deny-all"     # Restrict access to only authorized users
```
3. Restart the ntfy server. This will create the user.db file.
#### Step 2: Add Users
1. Create a user with the following command:
```
⠀ntfy user add --role=admin someuser
```
  * Replace someuser with your desired username.
  * The --role=admin flag is optional but grants administrative privileges.
2. Set a password when prompted.
#### Step 3: Assign Permissions
To allow a user to only subscribe to UnifiedPush topics:
```
ntfy access someuser 'up*' read-only
```
To allow a user to subscribe and publish to all topics (including UnifiedPush):
```
ntfy access someuser '*' read-write
```
#### Step 4: Allow UnifiedPush Notifications
To ensure apps can send notifications via UnifiedPush, make UnifiedPush topics (which start with up*) writable by anyone:
```
`ntfy access '*' 'up*' write-only`
```
#### Step 5: Log in via the ntfy Android App
1. Open the ntfy app and go to **Settings** -> **Manage Users** -> **Add New User**.
2. Enter your server URL (e.g., https://ntfy.example.com).
3. Provide the username and password you created earlier.

### ⠀Notes for Docker users
* You might want to adjust the user DB path to something like /etc/ntfy/user.db, or mount /var/lib/ntfy as a volume to keep it somewhere safe.
* You will probably want to use docker exec -it ntfy-container-name ntfy instead of ntfy (replace ntfy-container-name with the appropriate one).
  * For instance, with the command docker exec -it ntfy-container-name ntfy user add --role=admin someuser
