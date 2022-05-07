import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_house/utils/utils.dart';

class AnimalsClassSelection extends StatefulWidget {
  const AnimalsClassSelection({Key? key}) : super(key: key);

  @override
  State<AnimalsClassSelection> createState() => Animals_ClassSelectionState();
}

class Animals_ClassSelectionState extends State<AnimalsClassSelection> {
  int _selectedValue = 0;
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
                    scrollController:
                        FixedExtentScrollController(initialItem: 1),
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
                        // print(value);
                        _selectedValue = value;
                      });
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
              CastList(),
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

class CastList extends StatefulWidget {
  const CastList({Key? key}) : super(key: key);

  @override
  State createState() => CastListState();
}

class CastListState extends State<CastList> {
  final List<animalClass> _cast = <animalClass>[
    const animalClass('Mammals', Icons.pets),
    // const animalClass('Alexander Hamilton', Icons.pets),
    // const animalClass('Eliza Hamilton', Icons.pets),
    // const animalClass('James Madison', Icons.pets),
  ];

  Iterable<Widget> get animalClassWidgets {
    return _cast.map((animalClass indicator) {
      return Padding(
        padding: const EdgeInsets.all(4.0),
        child: Chip(
          backgroundColor: AppTheme.colors.primary,
          avatar: CircleAvatar(
              child: Icon(
                indicator.icon,
                color: AppTheme.colors.primaryFontColor,
              ),
              backgroundColor: Colors.white),
          label: Text(indicator.name),
          onDeleted: () {
            setState(() {
              _cast.removeWhere((animalClass entry) {
                return entry.name == indicator.name;
              });
            });
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Wrap(
          children: animalClassWidgets.toList(),
        ),
      ),
    );
  }
}
