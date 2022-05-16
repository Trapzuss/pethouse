import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_house/screens/collections/collections.dart';
import 'package:pet_house/screens/discovery/discovery.dart';
import 'package:pet_house/screens/feed.dart';
import 'package:pet_house/screens/posts/newPost.dart';
import 'package:pet_house/screens/profile.dart';
import 'package:pet_house/screens/discovery/search.dart';
import 'package:pet_house/services/collection_services.dart';

import 'package:pet_house/utils/utils.dart';
import 'package:pet_house/widget/collection/createCollectionModal.dart';
import 'package:pet_house/widget/navigation/categorieschip.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_house/screens/posts/updatePost.dart';

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

  // var items = [
  //   FloatingActionButtonLocation.startFloat,
  //   FloatingActionButtonLocation.startDocked,
  //   FloatingActionButtonLocation.centerFloat,
  //   FloatingActionButtonLocation.endFloat,
  //   FloatingActionButtonLocation.endDocked,
  //   FloatingActionButtonLocation.startTop,
  //   FloatingActionButtonLocation.centerTop,
  //   FloatingActionButtonLocation.endTop,
  // ];

  // final TextEditingController _controllerSearch = TextEditingController();
  // int _page = 0;
  late PageController pageController; // for tabs animation
  String searchValue = '';

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
    // _controllerSearch.dispose();
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

  final List<Map<String, Object>> _tabs = <Map<String, Object>>[
    {
      'label': 'Home',
      'icon': const Icon(Icons.home),
      'body': const FeedScreen(),
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
    final user = FirebaseAuth.instance.currentUser!;
    bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      key: _scaffoldrKey,
      appBar: AppBar(
        title: AppbarComputed(),
      ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        children: [
          FeedScreen(),
          DiscoveryScreen(searchValue: searchValue),
          collectionsScreen(),
          Profile(),
        ],
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Visibility(
          visible: !keyboardIsOpen,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return newPost();
              }));
            },
            tooltip: 'Create your post',
            child: CircleAvatar(
              backgroundColor: AppTheme.colors.primaryFontColor,
              child: Icon(
                Icons.pets,
                color: Color.fromARGB(255, 243, 243, 243),
              ),
            ),
            backgroundColor: Colors.white,
          )),
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
      return SizedBox(
        height: 30,
        child: TextFormField(
          maxLines: 1,
          decoration: InputDecoration(
              hintText: 'search your animal',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              contentPadding: EdgeInsets.only(left: 10, right: 10),
              suffixIcon: Icon(Icons.search),
              filled: true,
              fillColor: Color.fromARGB(179, 255, 255, 255)),
          onFieldSubmitted: (value) {
            print(value);
            setState(() {
              searchValue = value;
            });
          },
        ),
      );
    } else if (_appBarTitle == 'Collections') {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(),
          Text(
            _appBarTitle,
            style:
                GoogleFonts.freckleFace(fontSize: 36, color: Colors.brown[800]),
          ),
          InkWell(
            child: Icon(
              Icons.add_box,
              color: AppTheme.colors.primaryFontColor,
              size: 24,
            ),
            onTap: () {
              showCreateCollectionModal(context);
            },
          )
        ],
      );
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
  }
}
