import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:rlbasic/models/user.dart';
import 'package:rlbasic/pantallas/splashScreen.dart';
import 'package:rlbasic/services/local_notification_service.dart';
import 'my_navigator.dart';

import 'dart:io' show Platform;
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

// Registrar? registrar;

//receiver message when app is in background solution for on message
Future<void> backgroundHandler(RemoteMessage message) async{
  print(message.data.toString());
  print(message.notification!.title);
}

late User user;
void main() async{

  if(Platform.isAndroid){
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    // //this provides functions when the app is closed
    FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  }

  //options: Platform.isAndroid or Platform.isIOS or kIsWeb
  // if(kIsWeb){
  //   FirebaseCoreWeb.registerWith(registrar!);
  //   FirebaseMessagingWeb.registerWith(registrar!);
  // }

  //runApp(MaterialApp(home: App()));
  runApp(MyApp());
}

//MyApp heredates of StatelessWidget ---> overwrite build method
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'SmartStock',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          dividerColor: Colors.grey,
          primarySwatch: Colors.blue,
        ),
        //First widget to render
        home: SplashScreen(),
        routes: routes);
  }
}

//stateful widget to notifications
class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(Platform.isAndroid){
      //initialize the headset pop-up
      LocalNotificationService.initialize(context);

      //gives you the message on which user taps
      //and it opened the app from terminated state
      //all this functions works with a close app
      FirebaseMessaging.instance.getInitialMessage().then((message) {
        if(message!=null){
          final routeFromMessage = message.data["route"];

          Navigator.of(context).pushNamed(routeFromMessage);
        }
      });

      //this function only works in forground (direct screen) -> this print on the console the pop-up
      FirebaseMessaging.onMessage.listen((message) {
        if(message.notification !=null){
          //with null check !
          print(message.notification!.body);
          print(message.notification!.title);
        }

        LocalNotificationService.display(message);

      });

      //another stream, this goes to the route
      //this is the case when app is in the background but opened and user taps
      FirebaseMessaging.onMessageOpenedApp.listen((message) {
        final routeFromMessage = message.data["route"];

        //print(routeFromMessage);
        //se puede probar el otro navigator es para redireccionar a la pagina que deseemos
        Navigator.of(context).pushNamed(routeFromMessage);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
       child: null,
    );
  }
} 
