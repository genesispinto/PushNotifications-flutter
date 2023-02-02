// 7E:F6:21:3A:AB:F3:DB:86:AB:6D:78:A3:6E:9C:E7:89:85:BA:39:A8
import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService{

  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;
  static final StreamController<String>_messageStreamController = StreamController.broadcast();
  static Stream<String> get messageStream => _messageStreamController.stream;

  static Future _onbackgroundHandler(RemoteMessage message) async{
    print('onMessage Handler ${message.data}');
    _messageStreamController.add(message.notification?.title ?? 'no title');
    _messageStreamController.add(message.data['producto'] ?? 'no data');
  }
    static Future _onMessageHandler(RemoteMessage message) async{
    print('onMessage Handler ${message.data}');
    _messageStreamController.add(message.notification?.title ?? 'no title');
   _messageStreamController.add(message.data['producto'] ?? 'no data');
  }
    static Future _onMessageOpenApp(RemoteMessage message) async{
    //print('onMessageOpenApp Handler ${message.messageId}');
    print('onMessage Handler ${message.data}');
    _messageStreamController.add(message.notification?.title ?? 'no title');
    _messageStreamController.add(message.data['producto'] ?? 'no data');
  }

  static Future initializeApp() async{
    //Push notifications
    await Firebase.initializeApp();
    token = await FirebaseMessaging.instance.getToken();
    print(token);


    //Handlers
    FirebaseMessaging.onBackgroundMessage(_onbackgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);
    //Local notifications
  }

  static closeStreams(){
    _messageStreamController.close();
  }

}