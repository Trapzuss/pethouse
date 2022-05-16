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
            crossAxisSpacing: 0.0,
            mainAxisSpacing: 0.0,
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
    return Container(
      padding: const EdgeInsets.only(
        top: 15.0,
      ),
      margin: const EdgeInsets.only(left: 3.0, right: 3),
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
                    border: Border.all(
                        width: 2,
                        color:
                            AppTheme.colors.primaryFontColor.withOpacity(0.9)),
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
                          color: AppTheme.colors.primary.withOpacity(0.7),
                          child: Text(name,
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 241, 241, 241),
                                  shadows: [
                                    Shadow(
                                        color: Color.fromARGB(74, 51, 51, 51),
                                        blurRadius: 10,
                                        offset: Offset(0, 2))
                                  ]))),
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
