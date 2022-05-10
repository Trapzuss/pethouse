import 'package:flutter/material.dart';
import 'package:pet_house/screens/discover/cardBottom.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children:[
        card_Bottom(),
        card_Bottom(),
      ],
    );
  }
}
