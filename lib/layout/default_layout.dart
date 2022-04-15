import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// import 'package:flutter/cupertino.dart';

class DefaultLayout extends StatefulWidget {
  const DefaultLayout({Key? key}) : super(key: key);

  @override
  State<DefaultLayout> createState() => _DefaultLayoutState();
}

class _DefaultLayoutState extends State<DefaultLayout> {
  int _state = 0;
  late PageController pageController; // for tabs animation

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        leading: Icon(Icons.pets),
        middle: Text("Pet's house"),
        trailing: Icon(Icons.account_circle),
        backgroundColor: Colors.white70,
      ),
      child: SafeArea(
        child: Container(
            child: CupertinoTabBar(
          items: <BottomNavigationBarItem>[
            const BottomNavigationBarItem(
                icon: Icon(Icons.home), label: 'Home'),
            const BottomNavigationBarItem(
                icon: Icon(Icons.search), label: 'Discovery'),
            const BottomNavigationBarItem(
                icon: Icon(Icons.notifications), label: 'Notification'),
            const BottomNavigationBarItem(
                icon: Icon(Icons.bookmark), label: 'Collection'),
          ],
          currentIndex: _state,
          onTap: (int index) {
            setState(() {
              _state = index;
            });
          },
        )),
      ),
    );
  }
}
