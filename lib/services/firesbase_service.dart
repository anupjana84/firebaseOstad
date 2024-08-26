import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseNotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  FirebaseNotificationService._();

  static final FirebaseNotificationService instance =
      FirebaseNotificationService._();

  Future<void> initialize() async {
    await _firebaseMessaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true);
//foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print(message.notification?.title);
      print(message.notification?.title);
      print(message.notification?.title);
    });
//background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message){
      print(message.notification?.title);
      print(message.notification?.title);
      print(message.notification?.title);
    });
    //app terminated
    FirebaseMessaging.onBackgroundMessage(getmesage);
    //
    String? token = await getToken();
    print(token);
  }

  Future<String?> getToken() async {
    String? token = await _firebaseMessaging.getToken();
    return token;
  }
  //for message receive token generate and api call token sase to database
  Future<void>onRefreshToken() async{
    _firebaseMessaging.onTokenRefresh.listen((toke){
      //api call token sa
    });

  }
}


Future<void>getmesage(RemoteMessage remoteMessage)async{
  print("object");
}