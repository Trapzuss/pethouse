import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pet's house"),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset("assets/images/logo.png"),
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
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.add),
                    label: Text("Register", style: TextStyle(fontSize: 20)),
                    onPressed: () {},
                  ),
                ),
                Padding(padding: const EdgeInsets.all(8.0)),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.login),
                    label: Text("Login", style: TextStyle(fontSize: 20)),
                    onPressed: () {},
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image.asset(
                          "assets/images/footcat.png",
                          width: 200,
                          height: 200,
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
    );
  }
}
