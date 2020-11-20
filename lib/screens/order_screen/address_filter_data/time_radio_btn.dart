import 'package:flutter/material.dart';

class TimeRadioBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RadioListTile(
          value: 1,
          groupValue: 1,
          title: Text('From 9 to 12'),
          activeColor: Colors.black54,
          onChanged: (currentVal) {
            print(currentVal);
          },
        ),
        RadioListTile(
          value: 2,
          groupValue: 2,
          title: Text('From 12 to 3'),
          activeColor: Colors.black54,
          onChanged: (currentVal) {
            print(currentVal);
          },
        ),
        RadioListTile(
          value: 3,
          groupValue: 3,
          title: Text('From 3 to 6'),
          activeColor: Colors.black54,
          onChanged: (currentVal) {
            print(currentVal);
          },
        ),
      ],
    );
  }
}
