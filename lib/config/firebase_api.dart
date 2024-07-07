import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseApi {
  //create an instance of firebase messaging
  final _firebaseMessaging = FirebaseMessaging.instance;
  //function to initialize notifications

  Future<void> initializeNotifications() async {
    //request permission to receive notifications
    await _firebaseMessaging.requestPermission();

    //fetch the FCM token for the device
    final fCMToken = await _firebaseMessaging.getToken();

    //print the token(notmally you would sent this to your server)
    print('Token: $fCMToken');

    //initialize further settings for pushNotification
    initPushNotification();
  }

  //function to handle received messages
  void handleMessages(RemoteMessage? message) {
    //if the message is null, do nothing
    if (message == null) {
      return;
    }
    //navigate to new screen when the message is tapped
  }

  //function to initialize foreground and background settings
  Future initPushNotification() async {
    //handle notification if the app was terminated and now opended
    FirebaseMessaging.instance.getInitialMessage().then(handleMessages);
    //attach event listeners for when a notification opens the app
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessages);
  }
}
