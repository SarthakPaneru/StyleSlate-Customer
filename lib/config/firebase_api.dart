import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:hamro_barber_mobile/config/api_requests.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseApi {
  final ApiRequests _apiRequests = ApiRequests();

  //create an instance of firebase messaging
  final _firebaseMessaging = FirebaseMessaging.instance;
  //function to initialize notifications

  Future<void> sendFcmTokenToServer(int userId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? fcmToken;
    fcmToken = prefs.getString("fcmToken");

    if (fcmToken == null) {
      //fetch the FCM token for the device
      fcmToken = await _firebaseMessaging.getToken();

      //print the token(notmally you would sent this to your server)
      print('Firebase FCM Token new: $fcmToken');

      await _apiRequests.updateFcmToken(userId, fcmToken!);

      //save the token to shared preferences
      prefs.setString("fcmToken", fcmToken!);
    }

    print('Firebase FCM Token: $fcmToken');
  }

  Future<void> initializeNotifications() async {
    //request permission to receive notifications
    await _firebaseMessaging.requestPermission();

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
