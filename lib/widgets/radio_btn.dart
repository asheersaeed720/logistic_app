import 'package:flutter/material.dart';

class RadioBtn extends StatelessWidget {
  final radioBtnTitle1;
  final radioBtnTitle2;
  final radioBtnTitle3;

  RadioBtn(this.radioBtnTitle1, this.radioBtnTitle2, this.radioBtnTitle3);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RadioListTile(
          value: 1,
          groupValue: 1,
          title: Text('$radioBtnTitle1'),
          activeColor: Colors.black54,
          onChanged: (currentVal) {
            print(currentVal);
          },
        ),
        RadioListTile(
          value: 2,
          groupValue: 2,
          title: Text('$radioBtnTitle2'),
          activeColor: Colors.black54,
          onChanged: (currentVal) {
            print(currentVal);
          },
        ),
        RadioListTile(
          value: 3,
          groupValue: 3,
          title: Text('$radioBtnTitle3'),
          activeColor: Colors.black54,
          onChanged: (currentVal) {
            print(currentVal);
          },
        ),
      ],
    );
  }
}
