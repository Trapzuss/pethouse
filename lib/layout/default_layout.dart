import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_house/screens/profile.dart';
import 'package:pet_house/screens/rank.dart';
import 'package:pet_house/screens/aboutme.dart';
import 'package:pet_house/utils/global_variable.dart';
// import 'package:flutter/cupertino.dart';

class DefaultLayout extends StatefulWidget {
  const DefaultLayout({Key? key}) : super(key: key);

  @override
  State<DefaultLayout> createState() => _DefaultLayoutState();
}

class _DefaultLayoutState extends State<DefaultLayout> {
  int _state = 0;
  bool customDialRoot = false;
  var buttonSize = const Size(56.0, 56.0);
  var extend = false;
  ValueNotifier<bool> isDialOpen = ValueNotifier(false);
  var closeManually = false;
  var speedDialDirection = SpeedDialDirection.up;
  var switchLabelPosition = false;
  var rmicons = false;
  var visible = true;
  var childrenButtonSize = const Size(56.0, 56.0);
  var selectedfABLocation = FloatingActionButtonLocation.endDocked;
  var renderOverlay = true;
  var useRAnimation = true;

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

  final GlobalKey<ScaffoldState> _scaffoldrKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldrKey,
        appBar: CupertinoNavigationBar(
          // leading: Icon(Icons.pets),
          leading: const Padding(
            padding: EdgeInsets.only(top: 8),
            child: Text(
              'Petshouse',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          // middle: Text("Pet's house"),
          trailing: IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              _scaffoldrKey.currentState?.openEndDrawer();
              // Scaffold.of(context).openEndDrawer();
            },
          ),
          backgroundColor: Colors.white70,
        ),
        // appBar: AppBar(title: Text('yo')),
        endDrawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.black54,
                        foregroundColor: Colors.white,
                        child: Icon(Icons.person),
                      ),
                      Row(
                        children: [
                          Text(
                            'userDisplayName',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Icon(Icons.lock)
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 4),
                        child: Text(
                          '@username',
                          style: TextStyle(fontSize: 12),
                        ),
                      )
                    ]),
                decoration: BoxDecoration(color: Color(0xff557C37)),
              ),
              ListTile(
                title: Text('Personal Profile'),
                leading: Icon(Icons.person),
                onTap: () async {
                  // onPageChanged(1);
                  await Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Profile()));
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Ranking'),
                leading: Icon(Icons.leaderboard),
                onTap: () async {
                  // onPageChanged(1);
                  await Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Rank()));
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('About me'),
                leading: Icon(Icons.info),
                onTap: () async {
                  // onPageChanged(1);
                  await Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Aboutme()));
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        body: PageView(
          children: bottomNavigationScreenItems,
          controller: pageController,
          onPageChanged: onPageChanged,
        ),
        floatingActionButton: SpeedDial(
          openCloseDial: isDialOpen,
          icon: Icons.add,
          spacing: 3,
          activeIcon: Icons.close,
          spaceBetweenChildren: 4,
          dialRoot: customDialRoot
              ? (ctx, open, toggleChildren) {
                  return ElevatedButton(
                    onPressed: toggleChildren,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue[900],
                      padding: const EdgeInsets.symmetric(
                          horizontal: 22, vertical: 18),
                    ),
                    child: const Text(
                      "Custom Dial Root",
                      style: TextStyle(fontSize: 17),
                    ),
                  );
                }
              : null,
          buttonSize: buttonSize,
          label: extend ? Text('Open') : null,
          activeLabel: extend ? const Text("Close") : null,
          childrenButtonSize: childrenButtonSize,
          visible: visible,
          direction: speedDialDirection,
          switchLabelPosition: switchLabelPosition,

          /// If false, backgroundOverlay will not be rendered.
          renderOverlay: renderOverlay,
          // overlayColor: Colors.black,
          // overlayOpacity: 0.5,
          onOpen: () => debugPrint('OPENING DIAL'),
          onClose: () => debugPrint('DIAL CLOSED'),
          useRotationAnimation: useRAnimation,
          tooltip: 'Open Speed Dial',
          heroTag: 'speed-dial-hero-tag',
          // foregroundColor: Colors.black,
          backgroundColor: Color(0xff557C37),
          // activeForegroundColor: Colors.red,
          // activeBackgroundColor: Colors.blue,
          elevation: 8.0,
          isOpenOnStart: false,
          animationSpeed: 200,
          shape: customDialRoot
              ? const RoundedRectangleBorder()
              : const StadiumBorder(),
          children: [
            // SpeedDialChild(
            //   child: !rmicons ? const Icon(Icons.accessibility) : null,
            //   backgroundColor: Colors.red,
            //   foregroundColor: Colors.white,
            //   label: 'First',
            //   onTap: () => setState(() => rmicons = !rmicons),
            //   onLongPress: () => debugPrint('FIRST CHILD LONG PRESS'),
            // ),
            SpeedDialChild(
              child: !rmicons ? const Icon(Icons.chat_bubble_outline) : null,
              backgroundColor: Colors.deepOrange,
              foregroundColor: Colors.white,
              label: 'Second',
              onTap: () => debugPrint('SECOND CHILD'),
            ),
            SpeedDialChild(
              child: !rmicons
                  ? const Icon(Icons.video_camera_back_outlined)
                  : null,
              backgroundColor: Colors.indigo,
              foregroundColor: Colors.white,
              label: 'Show Snackbar',
              visible: true,
              onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text(("Third Child Pressed")))),
              onLongPress: () => debugPrint('THIRD CHILD LONG PRESS'),
            ),
          ],
          // childMargin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                  icon: Icon(Icons.search), label: 'Discovery'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.notifications), label: 'Notification'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.bookmark), label: 'Collection'),
            ],
            currentIndex: _state,
            onTap: _onNavigationTapped,
            unselectedItemColor: Color(0xff4A4A4A),
            selectedItemColor: Colors.amber,
          ),
        ));
  }
}
