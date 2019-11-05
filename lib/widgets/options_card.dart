import 'package:flutter/material.dart';

class OptionsCard extends StatelessWidget {
  final String title;
  final bool switchValue;
  final Function switchKey;

  const OptionsCard({Key key, this.title, this.switchValue, this.switchKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(title),
            Switch(
              value: switchValue,
              onChanged: switchKey,
            ),
          ],
        ),
      ),
    );
  }
}