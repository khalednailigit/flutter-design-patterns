import 'package:flutter/material.dart';

import '../../../design_patterns/abstract_factory/abstract_factory.dart';

class FactorySelection extends StatelessWidget {
  final List<IWidgetsFactory> widgetsFactoryList;
  final int selectedIndex;
  final ValueSetter<int?> onChanged;

  const FactorySelection({
    required this.widgetsFactoryList,
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        for (var i = 0; i < widgetsFactoryList.length; i++)
          RadioListTile(
            title: Text(widgetsFactoryList[i].getTitle()),
            value: i,
            groupValue: selectedIndex,
            selected: i == selectedIndex,
            activeColor: Colors.black,
            onChanged: onChanged,
          ),
      ],
    );
  }
}
