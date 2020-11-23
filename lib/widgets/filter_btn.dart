import 'package:flutter/material.dart';

class FilterBtn extends StatelessWidget {
  final filterTitle1;
  final filterTitle2;
  final filterTitle3;
  final filterBtn1;
  final filterBtn2;
  final filterBtn3;
  final activateFilterBtn1;
  final activateFilterBtn2;
  final activateFilterBtn3;

  FilterBtn(
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
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RaisedButton(
            padding: EdgeInsets.symmetric(horizontal: 6.5),
            elevation: 0,
            splashColor: Colors.white,
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
            padding: EdgeInsets.symmetric(horizontal: 6.5),
            elevation: 0,
            splashColor: Colors.white,
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
            padding: EdgeInsets.symmetric(horizontal: 6.5),
            elevation: 0,
            splashColor: Colors.white,
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
