import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_house/services/collection_services.dart';
import 'package:pet_house/utils/utils.dart';

Future showCreateCollectionModal(BuildContext context) async {
  final GlobalKey<FormState> _collectionFormKey = GlobalKey<FormState>();
  final TextEditingController _collectionNameController =
      TextEditingController();

  Future submitCollectionForm(BuildContext context) async {
    final isValid = _collectionFormKey.currentState!.validate();
    if (!isValid) return;
    await CollectionServices().createCollection(_collectionNameController.text);
    Navigator.pop(context);
  }

  // if (Platform.isIOS) {
  //   return showCupertinoModalPopup(
  //       context: context,
  //       builder: (context) => CupertinoActionSheet(
  //             actions: [
  //               CupertinoActionSheetAction(
  //                   onPressed: () => Navigator.of(context).pop(),
  //                   child: Text('Camera')),
  //             ],
  //           ));
  // } else
  //  {
  return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => FractionallySizedBox(
            heightFactor: 0.9,
            child: Container(
              padding: MediaQuery.of(context).viewInsets,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          customBorder: CircleBorder(),
                          child: Icon(Icons.close),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        Text(
                          'ADD COLLECTION',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        ElevatedButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18),
                                        side: BorderSide.none))),
                            onPressed: () async {
                              await submitCollectionForm(context);
                            },
                            child: Text(
                              'CREATE',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.colors.darkFontColor),
                            )),
                      ],
                    ),
                  ),
                  _collectionForm(_collectionFormKey, _collectionNameController)
                ],
              ),
            ),
          ));
  // }
}

class _collectionForm extends StatelessWidget {
  _collectionForm(this._collectionFormKey, this._collectionNameController);
  GlobalKey<FormState> _collectionFormKey = GlobalKey<FormState>();
  TextEditingController _collectionNameController = TextEditingController();
  String? _validateCollectionName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Collection name is required';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        margin: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Collection Name',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _collectionFormKey,
                child: TextFormField(
                  validator: _validateCollectionName,
                  controller: _collectionNameController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Input you collection name...'),
                ))
          ],
        ),
      ),
    );
  }
}
