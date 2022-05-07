import 'package:flutter/material.dart';
import 'package:pet_house/screens/home.dart';
import 'package:pet_house/screens/login.dart';

class CategoriesChip extends StatefulWidget {
  CategoriesChip({Key? key}) : super(key: key);

  @override
  State<CategoriesChip> createState() => _CategoriesChipState();
}

class _CategoriesChipState extends State<CategoriesChip> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Chip(
            avatar: CircleAvatar(
              child: Text('Mammals'),
            ),
            label: Text('Hello'),
          ),
          Chip(
            avatar: CircleAvatar(
              child: Text('Mammals'),
            ),
            label: Text('Hello'),
          ),
          InkWell(
            onTap: () async => await Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return const HomeScreen();
            })),
            child: Icon(Icons.login),
          )
        ],
      ),
    );
  }
}
