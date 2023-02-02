import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:notificaciones/screens/home_screen.dart';
import 'package:notificaciones/screens/message_screen.dart';
import 'package:notificaciones/services/notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PushNotificationService.initializeApp();
  runApp(const MyApp());
  }

class MyApp extends StatefulWidget {
  const MyApp({super.key});


  @override
  State<MyApp> createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldMessengerState> messengerKey = GlobalKey<ScaffoldMessengerState>();
  
  @override
  void initState() {
    super.initState();

    PushNotificationService.messageStream.listen((producto) {
      print('Myapp: $producto');

      navigatorKey.currentState?.pushNamed('message',arguments: producto);

      final  snackBar =  SnackBar(content: Text(producto));
      messengerKey.currentState?.showSnackBar(snackBar);
    });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'home',
      navigatorKey: navigatorKey,// Navegar
      scaffoldMessengerKey: messengerKey,//Snacks
      routes: {
        'home':(_) => const HomeScreen(),
        'message':(_) => const MessageScreen()
      },
      
    );
  }
}