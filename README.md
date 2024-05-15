# FlutterChat 💬

This is a chat application developed in Flutter to Android and iOs devices 📱

_It is a project to study the framework and principles of dart_

## Description

FlutterChat allows you to create an account with name and photo, and interact with other users in a live chat room.

https://github.com/RaphaelJesus1/chat-app/assets/61888147/8c686d35-e439-4da2-82f4-f03438f823d1

### Login
The video below shows a step by step to create an account on the application. 

https://github.com/RaphaelJesus1/chat-app/assets/61888147/62ef96ed-9b97-4edd-90b8-f4c6c4bb88de

The user can choose picking the profile image from gallery or camera, by selecting the method when drawer appears.
The fields are validated to ensure that they were filled in correctly.
* Must have a profile picture
* Name must have more than 4 letters
* Password must have more than 6 characters and match confirmation

If the requirements are not met, the fields will be highlighted as shown in the image below
<img width="352" alt="Screenshot 2024-05-15 at 00 38 59" src="https://github.com/RaphaelJesus1/chat-app/assets/61888147/68d55d79-4397-441d-be7a-4d7a539361c3">

## Technical specifications
The app uses firebase as backend. It uses the services below:
* Authentication (for login)
* Storage (to store users image)
* Firestore database (to store chat messages)
* Messaging (to send push notifications) 

## Getting started
1. At first, you need to install flutter in your computer. Access the [Official Flutter Documentation](https://flutter-ko.dev/get-started/install) and follow the steps related to your OS.

2. You'll need to setup your firebase project credentials to run this app. You can access the link below to configure it by yourself.

Follow the step by step from the first step to the second command of the third step. This way you will configure the connection to your firebase project.
https://firebase.google.com/docs/flutter/setup?platform=ios#install-cli-tools

4. After configuring firebase, you'll need to install [Android Studio](https://developer.android.com/studio/install) (for Android) or [XCode](https://apps.apple.com/us/app/xcode/id497799835?mt=12) (for iOS) to simulate the devices that you'll use to interact with FlutterChat. iOS devices can only be simulated in MacOS.

5. Run the simulator you installed in previous step and execute the command below inside of your project folder in terminal to run the application.
```bash
flutter run
```
