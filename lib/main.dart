import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_house/layout/default_layout.dart';
import 'package:pet_house/screens/home.dart';
import 'package:pet_house/utils/utils.dart';

// void main() {
//   runApp(const MyApp());
// }
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      // home: HomeScreen(),

      home: DefaultLayout(),
    );
  }
}
