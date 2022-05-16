import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pet_house/models/collection.dart';
import 'package:pet_house/models/post.dart';
import 'package:pet_house/screens/collections/collection.dart';
import 'package:pet_house/screens/posts/post.dart';
import 'package:pet_house/services/collection_services.dart';
import 'package:pet_house/services/post_services.dart';
import 'package:pet_house/utils/utils.dart';
import 'package:pet_house/widget/collection/collectionchip.dart';
import 'package:pet_house/widget/common/emptyWidget.dart';
import 'dart:developer';

class collectionsScreen extends StatefulWidget {
  const collectionsScreen({Key? key}) : super(key: key);

  @override
  State<collectionsScreen> createState() => _collectionsScreenState();
}

class _collectionsScreenState extends State<collectionsScreen> {
  var userCollections = [
    'https://www.familyeducation.com/sites/default/files/fe_slideshow/2008_03/Chipmunk_H.jpg',
    'https://media1.popsugar-assets.com/files/thumbor/PZXP_YZYLIecUhZhKVpH0ThoAsM/fit-in/728xorig/filters:format_auto-!!-:strip_icc-!!-/2019/07/18/646/n/1922243/3a21fb761112a072_pet/i/Royal-Pet-Portraits.jpg',
    'https://www.familyeducation.com/sites/default/files/collection-item/Cockatiels_H.jpg',
    'https://ae01.alicdn.com/kf/H35ab780c7bd04d81a9dae76bb729b9813/Vintage-Body-Deer-Cat-Dog-Portrait.jpg_640x640.jpg'
  ];

  Future<PostModel?> getPostJson(postId) async {
    // log('postId: ${postId}');
    final res = await PostServices().getPostById(postId);
    // log('data: ${res!.imageUrl} ');
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverList(delegate: SliverChildListDelegate([Container()]))
          ];
        },
        body: StreamBuilder<List<CollectionModel>>(
            stream: CollectionServices().getCollectionsOfCurrentUser(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return EmptyPostsTypeError(error: snapshot.error.toString());
              } else if (snapshot.hasData) {
                if (snapshot.data!.isEmpty) {
                  return EmptyCollection();
                }
                final collections = snapshot.data!;
                return Container(
                  padding: EdgeInsets.all(8),
                  child: MasonryGridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    itemCount: collections.length,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    // shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: EdgeInsets.all(2),
                        child: InkWell(
                          radius: 8,
                          // child: Container(),
                          child: getCollectionGroup(collections, index),
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              // log('${collections[index].postsId}');
                              return collectionScreen(
                                postsId: collections[index].postsId,
                              );
                            }));
                          },
                        ),
                        clipBehavior: Clip.antiAlias,
                      );
                    },
                  ),
                );
              }
              return Center(
                  child: SpinKitDancingSquare(
                color: AppTheme.colors.primary,
              ));
            }));
  }

  Widget getCollectionGroup(List<CollectionModel> collections, int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        collections[index].postsId.length > 0
            ? Stack(
                children: collections[index]
                    .postsId
                    .toList()
                    .asMap()
                    .entries
                    .map((item) {
                return FutureBuilder(
                  future: getPostJson(item.value),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return EmptyPostsTypeError(
                          error: snapshot.error.toString());
                    } else if (snapshot.hasData) {
                      final post = (snapshot.data) as PostModel;

                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                              style: BorderStyle.solid,
                              color: Color.fromARGB(136, 44, 44, 44),
                              width: 2),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Opacity(
                            opacity: item.key + 1 ==
                                    collections[index].postsId.length
                                ? 1
                                : 0.6,
                            child: Image.network(
                              post == null ? AppTheme.src.empty : post.imageUrl,
                              width: (MediaQuery.of(context).size.width / 2) -
                                  (item.key * 40),
                              height: 160,
                              fit: BoxFit.cover,
                              alignment: Alignment.center,
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Center(
                          child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ));
                    }
                  },
                );
              }).toList())
            : Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    AppTheme.src.empty,
                    height: 160,
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                ),
              ),
        Container(
          margin: EdgeInsets.only(left: 4),
          child: Text(collections[index].collectionName,
              style: TextStyle(
                  color: AppTheme.colors.primaryFontColor,
                  fontSize: 14,
                  fontWeight: FontWeight.bold)),
        ),
        Container(
          margin: EdgeInsets.only(left: 4),
          padding: EdgeInsets.only(bottom: 10),
          child: Text("Total ${collections[index].postsId.length.toString()}",
              style: TextStyle(
                  color: AppTheme.colors.primaryFontColor, fontSize: 12)),
        ),
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
