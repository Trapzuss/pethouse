// import 'dart:html';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: firebase,
      builder: (context, snapshot){
        if(snapshot.hasError){
          return Scaffold(
            appBar: AppBar(title: Text("Error"),
          ),
          body: Center(child: Text("${snapshot.error}"),
          ),
          );
        }
        if(snapshot.connectionState == ConnectionState.done){
          return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Username",
                      style: TextStyle(fontSize: 20),
                    ),
                    TextFormField(
                      
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Email",
                      style: TextStyle(fontSize: 20),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Password",
                      style: TextStyle(fontSize: 20),
                    ),
                    TextFormField(
                      obscureText: true,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          child: Text(
                            "Register",
                            style: TextStyle(fontSize: 20),
                          ),
                          onPressed: () {},
                        ),
                      ),
                    )
                  ],
                ),
              )),
        ),
      ),
    );
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator.adaptive(),
          ),
          );
      });
    
  }
}
