import 'package:flutter/material.dart';
import 'package:pet_house/screens/discover/cardBottom.dart';

class Discovery extends StatefulWidget {
  const Discovery({Key? key}) : super(key: key);

  @override
  State<Discovery> createState() => _DiscoveryState();
}

class _DiscoveryState extends State<Discovery>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  Icon cusIcon = Icon(Icons.search);
  Widget cusSearchBar = Text("Discovery");

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfffed269),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
              onPressed: () {
                setState(() {
                  if (this.cusIcon.icon == Icons.search) {
                    this.cusIcon = Icon(Icons.cancel);
                    this.cusSearchBar = TextField(
                      textInputAction: TextInputAction.go,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Search to ......."),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    );
                  } else {
                    this.cusIcon = Icon(Icons.search);
                    this.cusSearchBar = Text("Discovery");
                  }
                });
              },
              icon: cusIcon,
            ),
          ),
        ],
        title: cusSearchBar,
      ),
      body: Container(
          child: card_Bottom(),
        
      ),
    );
  }
}
