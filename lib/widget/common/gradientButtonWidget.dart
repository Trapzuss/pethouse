import 'package:flutter/material.dart';
import 'package:pet_house/screens/posts/newPost.dart';

class gradientButton extends StatefulWidget {
  final text;
  final action;
  const gradientButton({Key? key, this.action, this.text}) : super(key: key);

  @override
  State<gradientButton> createState() => _gradientButtonState();
}

class _gradientButtonState extends State<gradientButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8, bottom: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        child: SizedBox(
          width: 120,
          height: 35,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Color(0xFF5A9FFF),
                Color.fromARGB(255, 70, 145, 250)
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
              borderRadius: BorderRadius.circular(20),

              // boxShadow: <BoxShadow>[
              //   BoxShadow(
              //       color: Color.fromRGBO(0, 0, 0, 0.57), //shadow for button
              //       blurRadius: 5) //blur radius of shadow
              // ]
            ),
            child: Center(
              child: Text(
                widget.text,
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
          ),
        ),
        onTap: () {
          widget.action == null
              ? Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const newPost();
                }))
              : widget.action;
        },
      ),
    );
  }
}
