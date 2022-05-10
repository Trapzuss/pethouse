import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pet_house/screens/category.dart';
import 'package:pet_house/screens/posts/newPost.dart';

class card_Bottom extends StatelessWidget {
  const card_Bottom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            "Tags for you",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 15.0),
            width: MediaQuery.of(context).size.width - 30.0,
            height: MediaQuery.of(context).size.height - 50.0,
            child: GridView.count(
              crossAxisCount: 2,
              primary: false,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 15.0,
              childAspectRatio: 1.5,
              children: <Widget>[
                _TypeCard(
                    'Fish', 'assets/images/fish11.png', false, false, context),
                _TypeCard('Amphibians', 'assets/images/frog.png', false, false,
                    context),
                _TypeCard(
                    'Aves', 'assets/images/birds.png', false, false, context),
                _TypeCard('Mammals', 'assets/images/panda.png', false, false,
                    context),
                _TypeCard('Mammals', 'assets/images/panda.png', false, false,
                    context),
                _TypeCard('Mammals', 'assets/images/panda.png', false, false,
                    context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _TypeCard(
      String name, String imgPath, bool added, bool isFavorite, context) {
    return Padding(
      padding: EdgeInsets.only(top: 15.0, bottom: 5.0, left: 5.0, right: 5.0),
      child: InkWell(
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 3.0,
                blurRadius: 5.0,
              )
            ],
            color: Colors.white,
          ),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: 87.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(imgPath),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: ClipRRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                      child: Container(
                          alignment: Alignment.center,
                          color: Colors.grey.withOpacity(0.0),
                          child: Text(name,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ))),
                    ),
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(20.0),
              //   child: SizedBox(
              //     width: double.infinity,
              //     child: ElevatedButton.icon(
              //       icon: Icon(Icons.ads_click),
              //       label: Text("Click", style: TextStyle(fontSize: 15)),
              //       onPressed: () {
              //         Navigator.push(context,
              //             MaterialPageRoute(builder: (context) {
              //           return Category();
              //         }));
              //       },
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
