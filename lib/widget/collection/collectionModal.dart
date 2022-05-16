import 'dart:developer';
import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_house/models/collection.dart';
import 'package:pet_house/services/collection_services.dart';
import 'package:pet_house/utils/utils.dart';
import 'package:pet_house/widget/common/emptyWidget.dart';

final List<IconData> tags = [Icons.pets];
final List<dynamic> collections = [
  '2',
  '3 Reference',
];

Future showCollectionModal(BuildContext context, String postId) async {
  bool isChangedValue = false;
  if (Platform.isIOS) {
    return showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
              actions: [
                CupertinoActionSheetAction(
                    onPressed: () {
                      print('yes');
                      Navigator.pop(context);
                    },
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(collections[index]),
                            onTap: () {
                              print('Add successfully');
                              Navigator.pop(context);
                            },
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(),
                        itemCount: collections.length)),
              ],
            ));
  } else {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        builder: (context) => StreamBuilder<List>(
            stream: CollectionServices().getCollectionsOfCurrentUser(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return EmptyPostsTypeError(error: snapshot.error.toString());
              } else if (snapshot.hasData) {
                final List<CollectionModel> collections =
                    (snapshot.data) as List<CollectionModel>;

                if (snapshot.data!.isEmpty) {
                  return FractionallySizedBox(
                      heightFactor: 0.6, child: EmptyCollection());
                }
                log('${snapshot.data}');
                return StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                  void onChangedCallback(bool isChanged) {
                    setState(() {
                      isChangedValue = isChanged;
                    });
                  }

                  return FractionallySizedBox(
                    heightFactor: 0.6,
                    child: NestedScrollView(
                      headerSliverBuilder: (context, innerBoxIsScrolled) {
                        return [
                          SliverList(
                              delegate: SliverChildListDelegate([
                            ListTile(
                              title: Text('Save to...',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              onTap: () {
                                return null;
                              },
                            ),
                            Divider()
                          ]))
                        ];
                      },
                      body: ListView.builder(
                          itemBuilder: (context, index) {
                            bool isInCollection = false;

                            final checkInCollection =
                                collections[index].postsId.where(
                              (id) {
                                return id == postId.trim();
                              },
                            );

                            if (checkInCollection.isNotEmpty) {
                              isInCollection = true;
                            }

                            return DynamicCheckboxTile(
                              collections: collections,
                              index: index,
                              postId: postId,
                              value: isInCollection,
                              onChangedCallback: onChangedCallback,
                            );
                          },
                          itemCount: collections.length),
                    ),
                  );
                });
              } else {
                return Center(child: const CircularProgressIndicator());
              }
            })).whenComplete(() => isChangedValue == true
        ? BotToast.showNotification(
            leading: (cancel) => SizedBox.fromSize(
                size: const Size(40, 40),
                child: IconButton(
                  icon: Icon(Icons.check_circle, color: Colors.green),
                  onPressed: cancel,
                )),
            duration: Duration(seconds: 3),
            title: (_) => Text("Your collection has been updated."),
          )
        : null);
  }
}

class DynamicCheckboxTile extends StatefulWidget {
  List<CollectionModel> collections;
  int index;
  String postId;
  bool value;
  Function onChangedCallback;
  DynamicCheckboxTile(
      {Key? key,
      required this.collections,
      required this.index,
      required this.postId,
      required this.value,
      required this.onChangedCallback})
      : super(key: key);

  @override
  State<DynamicCheckboxTile> createState() => _DynamicCheckboxTileState();
}

class _DynamicCheckboxTileState extends State<DynamicCheckboxTile> {
  // bool _isChanged = false;
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(widget.collections[widget.index].collectionName),
      value: widget.value,
      onChanged: (bool? value) {
        String action = value == true ? 'add' : 'remove';
        CollectionServices().onChangeCollection(action,
            widget.collections[widget.index].collectionId, widget.postId);
        setState(() {
          // _isChanged = true;
          widget.value = value!;
        });
        widget.onChangedCallback(value);
        // log('$_isChanged');
      },
      activeColor: AppTheme.colors.primary,
    );
  }
}
