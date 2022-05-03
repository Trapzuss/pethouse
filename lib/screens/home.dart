import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:pet_house/screens/login.dart';
import 'package:pet_house/screens/register.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: ((context) => LoginScreen()))));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Pet's house"),
      // ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomRight,
                colors: [
              Color.fromARGB(255, 255, 254, 254),
              Color.fromARGB(255, 247, 215, 127),
            ])),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset("assets/images/pets.png"),
                  Text("Pets's House",
                      style: GoogleFonts.freckleFace(
                          fontSize: 60, color: Colors.brown[800])),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Beautiful community with on our hands!."),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                  ),
                  // SizedBox(
                  //   width: double.infinity,
                  //   child: ElevatedButton.icon(
                  //     icon: Icon(Icons.add),
                  //     label: Text("Register", style: TextStyle(fontSize: 20)),
                  //     onPressed: () {
                  //       Navigator.push(context,
                  //           MaterialPageRoute(builder: (context) {
                  //         return RegisterScreen();
                  //       }));
                  //     },
                  //   ),
                  // ),
                  // Padding(padding: const EdgeInsets.all(8.0)),
                  // SizedBox(
                  //   width: double.infinity,
                  //   child: ElevatedButton.icon(
                  //     icon: Icon(Icons.login),
                  //     label: Text("Login", style: TextStyle(fontSize: 20)),
                  //     onPressed: () {
                  //       Navigator.push(context,
                  //           MaterialPageRoute(builder: (context) {
                  //         return LoginScreen();
                  //       }));
                  //     },
                  //   ),
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Image.asset(
                            "assets/images/footcat.png",
                            width: 300,
                            
                            fit: BoxFit.contain,
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
