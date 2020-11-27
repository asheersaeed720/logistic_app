import 'package:flutter/material.dart';
import 'package:hani_almutairi_logistic/providers/order_provider.dart';
import 'package:provider/provider.dart';

class RadioBtn extends StatelessWidget {
  final radioBtnTitle1;
  final radioBtnTitle2;
  final radioBtnTitle3;

  RadioBtn(this.radioBtnTitle1, this.radioBtnTitle2, this.radioBtnTitle3);

  @override
  Widget build(BuildContext context) {
    final orderPvd = Provider.of<OrderProvider>(context);

    return Column(
      children: [
        RadioListTile(
          value: radioBtnTitle1,
          groupValue: orderPvd.selectedTime,
          title: Text('$radioBtnTitle1'),
          activeColor: Theme.of(context).primaryColor,
          onChanged: (currentVal) {
            orderPvd.setSelectedTime(currentVal);
          },
        ),
        RadioListTile(
          value: radioBtnTitle2,
          groupValue: orderPvd.selectedTime,
          title: Text('$radioBtnTitle2'),
          activeColor: Theme.of(context).primaryColor,
          onChanged: (currentVal) {
            orderPvd.setSelectedTime(currentVal);
          },
        ),
        RadioListTile(
          value: radioBtnTitle3,
          groupValue: orderPvd.selectedTime,
          title: Text('$radioBtnTitle3'),
          activeColor: Theme.of(context).primaryColor,
          onChanged: (currentVal) {
            orderPvd.setSelectedTime(currentVal);
          },
        ),
      ],
    );
  }
}
