# Secure Chat 🔒 
Have you ever been in an embarrassing situation **when someone sitting next to you or standing over you gets the opportunity to get a sneak peek of what’s on your large smartphone screen?** Or someone without your consent **takes a look at your chats endangering your privacy?**

<p><img src="assest/peeping.jpg" width="60%"></p>

## Well, Worry Not!

Secure chat is flutter based messaging app that would protect your chats anywhere anytime!🔒 Users can login or signup using their email address and password and chat with their near and dear ones using a unique Room Id.

## Download Here
 <pre><a href="https://github.com/azim2429/Flutter-Chat-Application/blob/master/app.apk?raw=true">Secure Chat 🔒</a></pre>

## Features of Secure Chat

* Clean and Simple UI
* Easy to login and logout
* Uses Firebase for authentication and storing messages
* Uniquely Generated Room
* Uses AES algorithm for encrypting the messages
* One tap to hide and read your messages
* Automated message encryption even if user forgets to hide

### SCREENSHOTS

<img src="assest/login.gif" width="30%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="assest/img1.jpg" width="30%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="assest/img2.jpg" width="30%">

# 

<img src="assest/img4.jpg" width="30%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="assest/img3.jpg" width="30%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="assest/securechat.gif" width="30%">


### WORKING

Once the user logs inside the app and enters into the preferred room , a room is created in the firebase firestore.

Now the if the user sends a message it is by default encrypted in client side , so that no one can see the messages.Suppose the receiver wants to decrypt ,**receiver would simply click the corresponding profile photo of the message.**
And again click it to encrypt.

Users can leave the room or logout from the app using logout button at the top.


## Setup

  ##### Clone the repository
```bash
git clone https://github.com/azim2429/Flutter-Chat-Application.git
```
  ##### Move to the desired folder
```bash
cd \chat-app
```

#### To install dependencies
```bash
flutter pub get
````

  ##### To run the app, simply write
```bash
flutter run
```

### Dependencies

1. [Firebase](https://pub.dev/packages/firebase)

1. [Firebase_Auth](https://pub.dev/packages/firebase_auth)

1. [Firebase_Core](https://pub.dev/packages/firebase_core)

1. [Cloud_Firestore](https://pub.dev/packages/cloud_firestore)

1. [Shared Preference](https://pub.dev/packages/shared_preferences)

1. [Image Picker](https://pub.dev/packages/image_picker)

1. [Encrypt](https://pub.dev/packages/encrypt)

## Author

👨‍💻 **Abdul Azim**

* Github: [Abdul Azim](https://github.com/azim2429)

## Show your support

Give a ⭐️ if this project helped you!
