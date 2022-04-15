import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CupertinoNavigationBar(
          leading: Icon(Icons.pets),
          // middle: Text("Pet's house"),
          trailing: Icon(Icons.account_circle),
          backgroundColor: Colors.white70,
        ),
        body: PageView(
          children: bottomNavigationScreenItems,
          // [

          // Container(
          //   child: Text('0'),
          // ),
          // Container(
          //   child: Text('1'),
          // ),
          // Container(
          //   child: Text('2'),
          // ),
          // Container(
          //   child: Text('3'),
          // ),
          // ],
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
