import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_speed_dial/flutter_speed_dial.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:pet_house/screens/feed.dart';
// import 'package:pet_house/screens/profile.dart';
// import 'package:pet_house/screens/rank.dart';
// import 'package:pet_house/screens/aboutme.dart';
import 'package:pet_house/screens/posts/createPost.dart';
import 'package:pet_house/utils/global_variable.dart';
import 'package:pet_house/utils/utils.dart';
import 'package:pet_house/widget/navigation/categorieschip.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:google_fonts/google_fonts.dart';

// import 'package:flutter/cupertino.dart';

class DefaultLayout extends StatefulWidget {
  const DefaultLayout({Key? key}) : super(key: key);

  @override
  State<DefaultLayout> createState() => _DefaultLayoutState();
}

class _DefaultLayoutState extends State<DefaultLayout> {
  int _state = 0;
  String _appBarTitle = 'Pethouse';
  List<IconData> iconList = [
    (Icons.home),
    (Icons.search),
    (Icons.bookmark),
    (Icons.account_circle)
  ];

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
    setState(() {
      var title = {
        0: 'Pethouse',
        1: 'Discovery',
        2: 'Collections',
        3: 'Profile'
      } as dynamic;
      _appBarTitle = title[index];
    });
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
      'label': 'Collections',
      'icon': const Icon(Icons.business),
      'body': const Text('Collections'),
    },
  ];

  final GlobalKey<ScaffoldState> _scaffoldrKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldrKey,
      appBar: AppBar(
        title: AppbarComputed(),
      ),
      // appBar: PreferredSize(
      //     child: Column(
      //       children: [
      //         CupertinoNavigationBar(
      //           // leading: Icon(Icons.pets),
      //           leading: Padding(
      //             padding: EdgeInsets.only(top: 8),
      //             child: Text(
      //               _appBarTitle,
      //               style: TextStyle(fontWeight: FontWeight.bold),
      //             ),
      //           ),
      //           // middle: Text("Pet's house"),
      //           // trailing: IconButton(
      //           //   icon: const Icon(Icons.account_circle),
      //           //   onPressed: () {
      //           //     _scaffoldrKey.currentState?.openEndDrawer();
      //           //     // Scaffold.of(context).openEndDrawer();
      //           //   },
      //           // ),
      //           backgroundColor: AppTheme.colors.primary,
      //         ),
      //         // CategoriesChip()
      //       ],
      //     ),
      //     preferredSize: Size.fromHeight(60)),
      // appBar: AppBar(title: Text('yo')),

      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        children: bottomNavigationScreenItems,
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // _incrementTab(1);
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return createPost();
          }));
        },
        tooltip: 'Create your Post',
        child: Icon(
          Icons.pets,
          color: AppTheme.colors.primaryFontColor,
        ),
        backgroundColor: Colors.white,
      ),
      bottomNavigationBar: AnimatedBottomNavigationBar(
        inactiveColor: AppTheme.colors.secondaryFontColor,
        activeColor: AppTheme.colors.primaryFontColor,
        icons: iconList,
        activeIndex: _state,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.verySmoothEdge,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        onTap: _onNavigationTapped,
        //other params
      ),
    );
  }

  Widget AppbarComputed() {
    if (_appBarTitle == 'Pethouse') {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/pets.png",
            width: 70,
          ),
          Text(
            _appBarTitle,
            style:
                GoogleFonts.freckleFace(fontSize: 36, color: Colors.brown[800]),
          )
        ],
      );
    } else if (_appBarTitle == 'Discovery') {
      return TextFormField(
          decoration: InputDecoration(
              hintText: 'search your animal',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              contentPadding: EdgeInsets.all(10),
              suffixIcon: Icon(Icons.search),
              filled: true,
              fillColor: Color.fromARGB(179, 255, 255, 255)));
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          _appBarTitle,
          style:
              GoogleFonts.freckleFace(fontSize: 36, color: Colors.brown[800]),
        )
      ],
    );
    ;
  }
}
