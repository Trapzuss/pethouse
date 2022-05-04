import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_house/screens/feed.dart';
import 'package:pet_house/screens/profile.dart';
import 'package:pet_house/screens/rank.dart';
import 'package:pet_house/screens/aboutme.dart';
import 'package:pet_house/screens/posts/createPost.dart';
import 'package:pet_house/utils/global_variable.dart';
import 'package:pet_house/widget/navigation/categoriesChip.dart';
// import 'package:flutter/cupertino.dart';

class DefaultLayout extends StatefulWidget {
  const DefaultLayout({Key? key}) : super(key: key);

  @override
  State<DefaultLayout> createState() => _DefaultLayoutState();
}

class _DefaultLayoutState extends State<DefaultLayout> {
  int _state = 0;

  var items = [
    FloatingActionButtonLocation.startFloat,
    FloatingActionButtonLocation.startDocked,
    FloatingActionButtonLocation.centerFloat,
    FloatingActionButtonLocation.endFloat,
    FloatingActionButtonLocation.endDocked,
    FloatingActionButtonLocation.startTop,
    FloatingActionButtonLocation.centerTop,
    FloatingActionButtonLocation.endTop,
  ];

  // int _page = 0;
  late PageController pageController; // for tabs animation

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void onPageChanged(int index) {
    setState(() {
      _state = index;
    });
  }

  _onNavigationTapped(int index) {
    pageController.jumpToPage(index);
  }

  void _incrementTab(index) {
    setState(() {
      print('PRESSED floating button');
      print(index);
    });
  }

  final List<Map<String, Object>> _tabs = <Map<String, Object>>[
    {
      'label': 'Home',
      'icon': const Icon(Icons.home),
      'body': const Feed(),
    },
    {
      'label': 'Collection',
      'icon': const Icon(Icons.business),
      'body': const Text('Collection'),
    },
  ];

  final GlobalKey<ScaffoldState> _scaffoldrKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldrKey,
        appBar: PreferredSize(
            child: Column(
              children: [
                CupertinoNavigationBar(
                  // leading: Icon(Icons.pets),
                  leading: Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Text(
                      'Petshouse',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  // middle: Text("Pet's house"),
                  // trailing: IconButton(
                  //   icon: const Icon(Icons.account_circle),
                  //   onPressed: () {
                  //     _scaffoldrKey.currentState?.openEndDrawer();
                  //     // Scaffold.of(context).openEndDrawer();
                  //   },
                  // ),
                  backgroundColor: Colors.white70,
                ),
                CategoriesChip()
              ],
            ),
            preferredSize: Size.fromHeight(100)),
        // appBar: AppBar(title: Text('yo')),

        body: PageView(
          children: bottomNavigationScreenItems,
          controller: pageController,
          onPageChanged: onPageChanged,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // _incrementTab(1);
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return CreatePost();
            }));
          },
          tooltip: 'Increament',
          child: const Icon(
            Icons.camera,
            color: Colors.amber,
          ),
          backgroundColor: Colors.white,
        ),
        bottomNavigationBar: SafeArea(
          child: BottomNavigationBar(
            elevation: 2,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), label: 'Search'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.bookmark), label: 'Collection'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle), label: 'Profile'),
            ],
            currentIndex: _state,
            onTap: _onNavigationTapped,
            unselectedItemColor: const Color(0xff4A4A4A),
            selectedItemColor: Colors.amber,
          ),
        ));
  }
}
