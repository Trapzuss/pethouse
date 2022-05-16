import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:pet_house/screens/edit_profile.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pet_house/screens/feed.dart';
import 'package:pet_house/screens/login.dart';
import 'package:pet_house/services/authentication_services.dart';
import 'package:provider/provider.dart';

import 'package:pet_house/screens/discovery/category.dart';
import 'package:pet_house/screens/edit_Profile.dart';

import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_house/layout/default_layout.dart';

import 'package:pet_house/screens/home.dart';
import 'package:pet_house/utils/utils.dart';
import 'package:bot_toast/bot_toast.dart';

// void main() {
//   runApp(const MyApp());
// }
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      theme: ThemeData(
          scaffoldBackgroundColor: Color.fromARGB(240, 255, 255, 255),
          textTheme: GoogleFonts.interTextTheme(
            Theme.of(context).textTheme.apply(
                bodyColor: const Color(0xFF263238),
                displayColor: const Color(0xFF263238)),
          ),
          colorScheme: ColorScheme.fromSwatch()
              .copyWith(primary: AppTheme.colors.primary),
          appBarTheme: AppBarTheme(foregroundColor: Color(0xFF263238))),
      title: 'Flutter Demo',

      home: AuthenticationWrapper(),
      navigatorObservers: [BotToastNavigatorObserver()],
      builder: BotToastInit(),

      // home: DefaultLayout(),
      // navigatorObservers: [BotToastNavigatorObserver()],
      // builder: BotToastInit(),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: SpinKitDancingSquare(
            color: AppTheme.colors.primary,
          ));
        } else if (snapshot.hasError) {
          return Center(child: Text('Something went wrong!'));
        } else if (snapshot.hasData) {
          return DefaultLayout();
        } else {
          return LoginScreen();
        }
      },
    );
  }
}
