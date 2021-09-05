import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modeuls/layout/layout_screen.dart';
import 'package:social_app/modeuls/log_in/login%20_screen.dart';
import 'package:social_app/share/blocobserver.dart';
import 'package:social_app/share/copmonents/component.dart';
import 'package:social_app/share/copmonents/constance.dart';
import 'package:social_app/share/network/local/cache_helper.dart';
import 'package:social_app/share/styles/themes.dart';

import 'modeuls/layout/cubit/socialapp_cubit.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('on background message');
  print(message.data.toString());

  MyToast(
    msg: 'on background message',
    state: toaststate.sucsses,
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await Firebase.initializeApp();
  var token = await FirebaseMessaging.instance.getToken();

  print("token is $token");

  // foreground fcm
  FirebaseMessaging.onMessage.listen((event) {
    print('on message');
    print(event.data.toString());

    MyToast(
      msg: 'on message',
      state: toaststate.sucsses,
    );
  });
  //  <category android:name="android.intent.category.LAUNCHER"/>

  // when click on notification to open app
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print('on message opened app');
    print(event.data.toString());
    MyToast(
      msg: 'on message opened app',
      state: toaststate.sucsses,
    );
  });

  // background fcm

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  Bloc.observer = MyBlocObserver();
  // DioHelper.init();
  await CacheHelper.init();
  uid = CacheHelper.sharedPreferences.getString('uid');
  Widget startWidget;
  if (uid == null) {
    startWidget = Login_Screen();
  } else {
    startWidget = LayOut_Screen();
  }

  runApp(MyApp(
    startWidget: startWidget,
  ));
}

class MyApp extends StatelessWidget {
  Widget startWidget;
  MyApp({this.startWidget});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialappCubit()
        ..getUser(uid)
        ..getPosts()
        ..getAllUser(),
      child: MaterialApp(
        theme: MyLigthThem,
        darkTheme: MyDarkThem,
        themeMode: ThemeMode.light,
        home: startWidget,
      ),
    );
  }
}
