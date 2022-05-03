import 'package:flutter/material.dart';

class CategoriesChip extends StatefulWidget {
  const CategoriesChip({Key? key}) : super(key: key);

  @override
  State<CategoriesChip> createState() => _CategoriesChipState();
}

class _CategoriesChipState extends State<CategoriesChip> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
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
          )
        ],
      ),
    );
  }
}
