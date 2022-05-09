import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_house/utils/utils.dart';

class AnimalsClassSelection extends StatefulWidget {
  int? selectedClass;
  Function? callback;
  AnimalsClassSelection({Key? key, this.selectedClass, this.callback})
      : super(key: key);

  @override
  State<AnimalsClassSelection> createState() => Animals_ClassSelectionState();
}

class Animals_ClassSelectionState extends State<AnimalsClassSelection> {
  Iterable<Object> animalClasses = [];

  void _showPicker(BuildContext ctx) {
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 8),
                  color: Colors.white,
                  width: double.infinity,
                  child: Text(
                    'Choose you animal class',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: AppTheme.colors.primaryFontColor),
                  ),
                ),
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(8)),
                  height: 250,
                  child: CupertinoPicker(
                    diameterRatio: 4,
                    backgroundColor: Colors.white,
                    itemExtent: 50,
                    scrollController: FixedExtentScrollController(
                        initialItem: widget.selectedClass!),
                    children: const [
                      IconWithLabel(
                        value: 'Fish',
                        icon: Icons.pets,
                      ),
                      IconWithLabel(
                        value: 'Amphibians',
                        icon: Icons.pets,
                      ),
                      IconWithLabel(
                        value: 'Aves',
                        icon: Icons.pets,
                      ),
                      IconWithLabel(
                        value: 'Mammals',
                        icon: Icons.pets,
                      ),
                      IconWithLabel(
                        value: 'Reptiles',
                        icon: Icons.pets,
                      ),
                      IconWithLabel(
                        value: 'Insecta',
                        icon: Icons.pets,
                      ),
                      IconWithLabel(
                        value: 'Cephalopod',
                        icon: Icons.pets,
                      ),
                    ],
                    onSelectedItemChanged: (value) {
                      setState(() {
                        widget.selectedClass = value;
                      });
                      widget.callback!(value);
                    },
                  ),
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: InkWell(
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              // Text('${widget.selectedClass}'),
              ClassList(widget.selectedClass),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.only(right: 8),
                    child: Icon(
                      Icons.book,
                      color: AppTheme.colors.primaryFontColor,
                    ),
                  ),
                  Text(
                    'Animal Classes',
                    style: TextStyle(
                        color: AppTheme.colors.primaryFontColor,
                        fontWeight: FontWeight.bold),
                  )
                ],
              )
            ],
          ),
        ),
        onTap: () => _showPicker(context),
      ),
    );
  }
}

class IconWithLabel extends StatelessWidget {
  final String value;
  final IconData icon;
  const IconWithLabel({Key? key, required this.value, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            child: Icon(
              icon,
              color: AppTheme.colors.primaryFontColor,
            ),
            backgroundColor: Colors.transparent,
          ),
          Text(value)
        ],
      ),
    );
  }
}

class animalClass {
  const animalClass(this.name, this.icon);
  final String name;
  final IconData icon;
}

class ClassList extends StatefulWidget {
  int? selectedClass;
  ClassList(int? _class, {Key? key}) : super(key: key) {
    selectedClass = _class;
  }

  @override
  State createState() => ClassListState();
}

class ClassListState extends State<ClassList> {
  static final _animalClasses = [
    // {'value': 'Did not select yet?', 'icon': Icons.pets},
    {'value': 'fish', 'icon': Icons.pets},
    {'value': 'amphibians', 'icon': Icons.pets},
    {'value': 'aves', 'icon': Icons.pets},
    {'value': 'mammals', 'icon': Icons.pets},
    {'value': 'reptiles', 'icon': Icons.pets},
    {'value': 'insecta', 'icon': Icons.pets},
    {'value': 'cephalopod', 'icon': Icons.pets}
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Wrap(
          children: [
            widget.selectedClass == -1
                ? emptyClassWidget()
                : animalClassChipWidget(),
          ],
        ),
      ),
    );
  }

  Widget animalClassChipWidget() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Chip(
        backgroundColor: AppTheme.colors.primary,
        avatar: CircleAvatar(
            child: Icon(
              Icons.pets,
              color: AppTheme.colors.primaryFontColor,
            ),
            backgroundColor: Colors.white),
        label: Text(_animalClasses[widget.selectedClass!]['value'].toString()),
      ),
    );
  }

  Widget emptyClassWidget() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Chip(
        backgroundColor: AppTheme.colors.primary,
        avatar: CircleAvatar(
            child: Icon(
              Icons.question_mark,
              color: AppTheme.colors.primaryFontColor,
            ),
            backgroundColor: Colors.white),
        label: Text('Choose you animal class'),
      ),
    );
  }
}
