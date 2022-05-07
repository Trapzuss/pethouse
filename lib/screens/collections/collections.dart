import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pet_house/screens/collections/collection.dart';
import 'package:pet_house/screens/posts/post.dart';
import 'package:pet_house/utils/utils.dart';
import 'package:pet_house/widget/discovery/collectionchip.dart';

class collectionsScreen extends StatefulWidget {
  const collectionsScreen({Key? key}) : super(key: key);

  @override
  State<collectionsScreen> createState() => _collectionsScreenState();
}

class _collectionsScreenState extends State<collectionsScreen> {
  // var userCollections = [
  //   {
  //     'images': [
  //       'https://www.familyeducation.com/sites/default/files/fe_slideshow/2008_03/Chipmunk_H.jpg',
  //       'https://media1.popsugar-assets.com/files/thumbor/PZXP_YZYLIecUhZhKVpH0ThoAsM/fit-in/728xorig/filters:format_auto-!!-:strip_icc-!!-/2019/07/18/646/n/1922243/3a21fb761112a072_pet/i/Royal-Pet-Portraits.jpg',
  //       'https://www.familyeducation.com/sites/default/files/collection-item/Cockatiels_H.jpg',
  //       'https://ae01.alicdn.com/kf/H35ab780c7bd04d81a9dae76bb729b9813/Vintage-Body-Deer-Cat-Dog-Portrait.jpg_640x640.jpg'
  //     ],
  //     'name': 'Interested stuff',
  //     'amount': 4
  //   },
  //   {
  //     'images': [
  //       'https://www.familyeducation.com/sites/default/files/collection-item/Cockatiels_H.jpg',
  //       'https://ae01.alicdn.com/kf/H35ab780c7bd04d81a9dae76bb729b9813/Vintage-Body-Deer-Cat-Dog-Portrait.jpg_640x640.jpg'
  //     ],
  //     'name': 'Cutes Animals',
  //     'amount': 2
  //   },
  // ];
  var userCollections = [
    'https://www.familyeducation.com/sites/default/files/fe_slideshow/2008_03/Chipmunk_H.jpg',
    'https://media1.popsugar-assets.com/files/thumbor/PZXP_YZYLIecUhZhKVpH0ThoAsM/fit-in/728xorig/filters:format_auto-!!-:strip_icc-!!-/2019/07/18/646/n/1922243/3a21fb761112a072_pet/i/Royal-Pet-Portraits.jpg',
    'https://www.familyeducation.com/sites/default/files/collection-item/Cockatiels_H.jpg',
    'https://ae01.alicdn.com/kf/H35ab780c7bd04d81a9dae76bb729b9813/Vintage-Body-Deer-Cat-Dog-Portrait.jpg_640x640.jpg'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: MasonryGridView.count(
        shrinkWrap: true,
        crossAxisCount: 2,
        itemCount: userCollections.length,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        // shrinkWrap: true,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(top: 8),
            child: InkWell(
              child: getCollectionGroup(),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return collectionScreen();
                }));
              },
            ),
          );
        },
      ),
    );
  }

  Widget getCollectionGroup() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
            children: userCollections
                .getRange(0, 3)
                .toList()
                .asMap()
                .entries
                .map((item) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                            style: BorderStyle.solid,
                            color: Colors.white,
                            width: 3),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          item.value,
                          width: (MediaQuery.of(context).size.width / 2) -
                              (item.key * 40),
                          height: 160,
                          fit: BoxFit.cover,
                          alignment: Alignment.center,
                        ),
                      ),
                    ))
                .toList()),
        Text('Collection name',
            style: TextStyle(
                color: AppTheme.colors.primaryFontColor,
                fontSize: 14,
                fontWeight: FontWeight.bold)),
        Text('4 posts',
            style: TextStyle(
                color: AppTheme.colors.primaryFontColor, fontSize: 12)),
      ],
    );
  }

  // Widget collectionWidget(List images) {
  //   try {
  //     images.asMap().entries.map((item) => ClipRRect(
  //           borderRadius: BorderRadius.circular(10),
  //           child: Image.network(
  //             item.value,
  //             width: (MediaQuery.of(context).size.width / 2) - (item.key * 30),
  //             height: 160,
  //             fit: BoxFit.cover,
  //             alignment: Alignment.center,
  //           ),
  //         ));
  //     return Container();
  //   } catch (e) {
  //     return Container();
  //   }
  // }

}
