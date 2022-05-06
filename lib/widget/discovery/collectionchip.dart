import 'package:flutter/material.dart';
import 'package:pet_house/screens/home.dart';

class CollectionsChip extends StatefulWidget {
  CollectionsChip({Key? key}) : super(key: key);

  @override
  State<CollectionsChip> createState() => _CollectionsChipState();
}

class _CollectionsChipState extends State<CollectionsChip> {
  var collections = ['cute', 'cool'];
  final List<String> _filters = <String>[];
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(4),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 4),
            child: Icon(Icons.add_circle),
          ),
          getCollections(collections)
        ],
      ),
    );
  }

  Widget getCollections(List<String> strings) {
    return new Row(
        children: strings
            .map((item) => new Container(
                  margin: EdgeInsets.symmetric(horizontal: 2),
                  // child: FilterChip(
                  //   label: Text(item),
                  //   onSelected:,
                  // ),
                  child: FilterChip(
                    label: Text(item),
                    selected: _filters.contains(item),
                    onSelected: (bool value) {
                      setState(() {
                        if (value) {
                          _filters.add(item);
                        } else {
                          _filters.removeWhere((String name) {
                            return name == item;
                          });
                        }
                      });
                    },
                  ),
                ))
            .toList());
  }
}
