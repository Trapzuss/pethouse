import 'package:flutter/material.dart';

class Rank extends StatefulWidget {
  const Rank({Key? key}) : super(key: key);

  @override
  State<Rank> createState() => _RankState();
}

class _RankState extends State<Rank> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hello')),
    );
  }
}
