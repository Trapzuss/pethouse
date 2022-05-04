// import 'dart:html';

import 'dart:math';

import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

Column _buildButtonColumn(String label, String text) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Text(
            text,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
      ],
    );
  }
  

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Center(
          child: Column(
            children: [
              Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ-0xqWrYOTxA6pEN2dcsMhqHTAqFFjTr3UyA&usqp=CAU'),
              Text('ta'),
              Text('love cat',style: TextStyle(fontSize: 20),),
              TextButton(onPressed: (){}, child: Text('text button')),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildButtonColumn('post', '20'),
                  _buildButtonColumn('likes', '50'),
                ],
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.green),
                child: Column(
                  children: [
                    Text('My post'),
                    Icon(Icons.newspaper)
                  ]),
              )
            ],
          )
        
        ),
      ),
    );
  }
}
