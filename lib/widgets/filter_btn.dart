import 'package:flutter/material.dart';
import 'package:hani_almutairi_logistic/models/user_address.dart';
import 'package:hani_almutairi_logistic/providers/auth_provider.dart';
import 'package:hani_almutairi_logistic/providers/user_provider.dart';
import 'package:hani_almutairi_logistic/widgets/loading_indicator.dart';
import 'package:provider/provider.dart';

class OrderStatusFilterBtn extends StatelessWidget {
  final filterTitle1;
  final filterTitle2;
  final filterBtn1;
  final filterBtn2;
  final activateFilterBtn1;
  final activateFilterBtn2;

  OrderStatusFilterBtn(
    this.filterTitle1,
    this.filterTitle2,
    this.filterBtn1,
    this.filterBtn2,
    this.activateFilterBtn1,
    this.activateFilterBtn2,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 13),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RaisedButton(
            padding: const EdgeInsets.symmetric(horizontal: 6.5),
            elevation: 0,
            onPressed: () {
              activateFilterBtn1();
            },
            child: Text(
              '$filterTitle1',
              style: TextStyle(
                color:
                    filterBtn1 ? Colors.white : Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
            color: filterBtn1 ? Theme.of(context).primaryColor : Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Theme.of(context).primaryColor),
            ),
          ),
          RaisedButton(
            padding: const EdgeInsets.symmetric(horizontal: 6.5),
            elevation: 0,
            onPressed: () {
              activateFilterBtn2();
            },
            child: Text(
              '$filterTitle2',
              style: TextStyle(
                color:
                    filterBtn2 ? Colors.white : Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
            color: filterBtn2 ? Theme.of(context).primaryColor : Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Theme.of(context).primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}

class PickupTimeFilterBtn extends StatelessWidget {
  final filterTitle1;
  final filterTitle2;
  final filterTitle3;
  final filterBtn1;
  final filterBtn2;
  final filterBtn3;
  final activateFilterBtn1;
  final activateFilterBtn2;
  final activateFilterBtn3;

  PickupTimeFilterBtn(
    this.filterTitle1,
    this.filterTitle2,
    this.filterTitle3,
    this.filterBtn1,
    this.filterBtn2,
    this.filterBtn3,
    this.activateFilterBtn1,
    this.activateFilterBtn2,
    this.activateFilterBtn3,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 13),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RaisedButton(
            padding: const EdgeInsets.symmetric(horizontal: 6.5),
            elevation: 0,
            onPressed: () {
              activateFilterBtn1();
            },
            child: Text(
              '$filterTitle1',
              style: TextStyle(
                color:
                    filterBtn1 ? Colors.white : Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
            color: filterBtn1 ? Theme.of(context).primaryColor : Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Theme.of(context).primaryColor),
            ),
          ),
          RaisedButton(
            padding: const EdgeInsets.symmetric(horizontal: 6.5),
            elevation: 0,
            onPressed: () {
              activateFilterBtn2();
            },
            child: Text(
              '$filterTitle2',
              style: TextStyle(
                color:
                    filterBtn2 ? Colors.white : Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
            color: filterBtn2 ? Theme.of(context).primaryColor : Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Theme.of(context).primaryColor),
            ),
          ),
          RaisedButton(
            padding: const EdgeInsets.symmetric(horizontal: 6.5),
            elevation: 0,
            onPressed: () {
              activateFilterBtn3();
            },
            child: Text(
              '$filterTitle3',
              style: TextStyle(
                color:
                    filterBtn3 ? Colors.white : Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
            color: filterBtn3 ? Theme.of(context).primaryColor : Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Theme.of(context).primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}

class SenderAddressFilterBtn extends StatelessWidget {
  final filterTitle1;
  final filterTitle2;
  final filterTitle3;
  final filterBtn1;
  final filterBtn2;
  final filterBtn3;
  final activateFilterBtn1;
  final activateFilterBtn2;
  final activateFilterBtn3;
  Function clearRadio;
  List addressSender;
  Function clearSenderAddressInputVals;

  SenderAddressFilterBtn(
    this.filterTitle1,
    this.filterTitle2,
    this.filterTitle3,
    this.filterBtn1,
    this.filterBtn2,
    this.filterBtn3,
    this.activateFilterBtn1,
    this.activateFilterBtn2,
    this.activateFilterBtn3,
    this.clearRadio,
    this.addressSender,
    this.clearSenderAddressInputVals,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 13),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          addressSender.isEmpty
              ? Text('')
              : RaisedButton(
                  padding: const EdgeInsets.symmetric(horizontal: 6.5),
                  elevation: 0,
                  onPressed: () {
                    activateFilterBtn1();
                    clearRadio();
                    clearSenderAddressInputVals();
                  },
                  child: Text(
                    '$filterTitle1',
                    style: TextStyle(
                      color: filterBtn1
                          ? Colors.white
                          : Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  color: filterBtn1
                      ? Theme.of(context).primaryColor
                      : Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Theme.of(context).primaryColor),
                  ),
                ),
          RaisedButton(
            padding: const EdgeInsets.symmetric(horizontal: 6.5),
            elevation: 0,
            onPressed: () {
              activateFilterBtn2();
              clearRadio();
            },
            child: Text(
              '$filterTitle2',
              style: TextStyle(
                color:
                    filterBtn2 ? Colors.white : Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
            color: filterBtn2 ? Theme.of(context).primaryColor : Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Theme.of(context).primaryColor),
            ),
          ),
          addressSender.isEmpty
              ? Text('')
              : RaisedButton(
                  padding: const EdgeInsets.symmetric(horizontal: 6.5),
                  elevation: 0,
                  onPressed: () {
                    activateFilterBtn3();
                    clearSenderAddressInputVals();
                  },
                  child: Text(
                    '$filterTitle3',
                    style: TextStyle(
                      color: filterBtn3
                          ? Colors.white
                          : Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  color: filterBtn3
                      ? Theme.of(context).primaryColor
                      : Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Theme.of(context).primaryColor),
                  ),
                ),
        ],
      ),
    );
  }
}

class ReceiverAddressFilterBtn extends StatelessWidget {
  final filterTitle1;
  final filterTitle2;
  final filterTitle3;
  final filterBtn1;
  final filterBtn2;
  final filterBtn3;
  final activateFilterBtn1;
  final activateFilterBtn2;
  final activateFilterBtn3;
  Function clearRadio;
  List addressReceiver;
  Function clearReceiverAddressInputVals;
  ReceiverAddressFilterBtn(
    this.filterTitle1,
    this.filterTitle2,
    this.filterTitle3,
    this.filterBtn1,
    this.filterBtn2,
    this.filterBtn3,
    this.activateFilterBtn1,
    this.activateFilterBtn2,
    this.activateFilterBtn3,
    this.clearRadio,
    this.addressReceiver,
    this.clearReceiverAddressInputVals,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 13),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          addressReceiver.isEmpty
              ? Text('')
              : RaisedButton(
                  padding: const EdgeInsets.symmetric(horizontal: 6.5),
                  elevation: 0,
                  onPressed: () {
                    activateFilterBtn1();
                    clearRadio();
                    clearReceiverAddressInputVals();
                  },
                  child: Text(
                    '$filterTitle1',
                    style: TextStyle(
                      color: filterBtn1
                          ? Colors.white
                          : Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  color: filterBtn1
                      ? Theme.of(context).primaryColor
                      : Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Theme.of(context).primaryColor),
                  ),
                ),
          RaisedButton(
            padding: const EdgeInsets.symmetric(horizontal: 6.5),
            elevation: 0,
            onPressed: () {
              activateFilterBtn2();
              clearRadio();
            },
            child: Text(
              '$filterTitle2',
              style: TextStyle(
                color:
                    filterBtn2 ? Colors.white : Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
            color: filterBtn2 ? Theme.of(context).primaryColor : Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Theme.of(context).primaryColor),
            ),
          ),
          addressReceiver.isEmpty
              ? Text('')
              : RaisedButton(
                  padding: const EdgeInsets.symmetric(horizontal: 6.5),
                  elevation: 0,
                  onPressed: () {
                    activateFilterBtn3();
                    clearReceiverAddressInputVals();
                  },
                  child: Text(
                    '$filterTitle3',
                    style: TextStyle(
                      color: filterBtn3
                          ? Colors.white
                          : Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  color: filterBtn3
                      ? Theme.of(context).primaryColor
                      : Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Theme.of(context).primaryColor),
                  ),
                ),
        ],
      ),
    );
  }
}
