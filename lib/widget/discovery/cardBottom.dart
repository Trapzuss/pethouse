import 'dart:ui';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

import 'package:pet_house/screens/discovery/category.dart';
import 'package:pet_house/screens/posts/newPost.dart';
import 'package:pet_house/utils/utils.dart';

class card_Bottom extends StatelessWidget {
  const card_Bottom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Center(
          child: Container(
            margin: EdgeInsets.only(top: 16, bottom: 8),
            child: Text(
              "Categories",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width - 10.0,
          height: MediaQuery.of(context).size.height - 10.0,
          child: GridView.count(
            crossAxisCount: 2,
            primary: false,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 15.0,
            childAspectRatio: 1.5,
            children: <Widget>[
              _typeCard('Fishs', 'assets/images/categories/fishs.png', context),
              _typeCard('Amphibians', 'assets/images/categories/amphibians.png',
                  context),
              _typeCard('Aves', 'assets/images/categories/aves.png', context),
              _typeCard(
                  'Mammals', 'assets/images/categories/mammals.png', context),
              _typeCard(
                  'Reptiles', 'assets/images/categories/reptiles.png', context),
              _typeCard(
                  'Insecta', 'assets/images/categories/insecta.png', context),
              _typeCard('Cephalopod', 'assets/images/categories/cephalopod.png',
                  context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _typeCard(String name, String imgPath, context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 15.0, bottom: 5.0, left: 5.0, right: 5.0),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return CategoryScreen(
              animalClass: name,
            );
          }));
        },
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
            color: AppTheme.colors.primary,
          ),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: 87.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: AssetImage(imgPath),
                      fit: BoxFit.contain,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                      child: Container(
                          alignment: Alignment.center,
                          color: AppTheme.colors.primary.withOpacity(0.1),
                          child: Text(name,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 241, 241, 241)))),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
