import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_house/screens/feed.dart';
import 'package:pet_house/screens/forgot.dart';
import 'package:pet_house/services/authentication_services.dart';
import 'register.dart';

import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _validateEmail(String? value) {
    RegExp emailRegex = RegExp(r'^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$',
        caseSensitive: false);
    if (value == null || value.isEmpty) {
      return 'Required';
    } else if (!emailRegex.hasMatch(value)) {
      return 'Invalid email address';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Required';
    } else if (value.length < 6) {
      return 'Password must be longer than 6 characters';
    }
    return null;
  }

  bool isChecked = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Color getColor(Set<MaterialState> states) {
    //   const Set<MaterialState> interactiveStates = <MaterialState>{
    //     MaterialState.pressed,
    //     MaterialState.hovered,
    //     MaterialState.focused,
    //   };
    //   if (states.any(interactiveStates.contains)) {
    //     return Colors.blue;
    //   }
    //   return Colors.grey;
    // }

    Future signInCustom() async {
      final isValid = _formKey.currentState!.validate();
      if (!isValid) return;
      await AuthenticationService()
          .signIn(_emailController.text, _passwordController.text);
    }

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomRight,
                colors: [
              Color.fromARGB(255, 255, 254, 254),
              Color.fromARGB(255, 247, 215, 127),
            ])),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _formKey,
                child: Column(
                  children: [
                    Image.asset(
                      "assets/images/pets.png",
                      width: 200,
                    ),
                    Text("Pets's House",
                        style: GoogleFonts.freckleFace(
                            fontSize: 40, color: Colors.brown[800])),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Beautiful community with on our hands!."),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Email"),
                        ],
                      ),
                    ),
                    SizedBox(
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                        child: TextFormField(
                          validator: _validateEmail,
                          controller: _emailController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.email),
                            hintText: 'email',
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Password"),
                        ],
                      ),
                    ),
                    SizedBox(
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                        child: TextFormField(
                          validator: _validatePassword,
                          controller: _passwordController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.lock),
                            // suffixIcon: Icon(Icons.visibility),
                            hintText: 'password',
                          ),
                          obscureText: true,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Forgot();
                        }));
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // Text(
                            //   "Forgot Password",
                            //   style: TextStyle(
                            //     fontSize: 12,
                            //     fontWeight: FontWeight.bold,
                            //   ),
                            // ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.start,
                            //   children: [
                            //     Checkbox(
                            //       checkColor: Colors.white,
                            //       fillColor: MaterialStateProperty.resolveWith(getColor),
                            //       value: isChecked,
                            //       onChanged: (bool? value) {
                            //         setState(() {
                            //           isChecked = value!;
                            //         });
                            //       },
                            //     ),
                            //     Text("Remember"),
                            //   ]
                            // ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Color(0xff2979ff)),
                            onPressed: () {
                              //   Navigator.push(context,
                              //     MaterialPageRoute(builder: (context) {
                              //   return Feed();
                              // }));
                              signInCustom();
                            },
                            child: const Text('LOG IN'),
                          ),
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Don't have an Account?  ",
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return RegisterScreen();
                            }));
                          },
                          child: Text(
                            "Sign up",
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
