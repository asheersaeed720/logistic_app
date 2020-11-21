import 'package:flutter/material.dart';

class FormWidget extends StatefulWidget {
  @override
  _FormWidgetState createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final _formKey = GlobalKey<FormState>();

  int _stepNumber = 1;

  final ctl_name = TextEditingController();
  final ctl_age = TextEditingController();
  final ctl_address = TextEditingController();
  final ctl_city = TextEditingController();

  // void saveData(BuildContext context) {
  //   _formKey.currentState.save();

  //   print(ctl_name.text);
  //   print(ctl_age.text);
  //   print(ctl_address.text);
  //   print(ctl_city.text);
  // }

  void nextPage(BuildContext context) {
    setState(() {
      if (_stepNumber == 1)
        _stepNumber = 2;
      else
        _stepNumber = 1;
    });
  }

  Column formOneBuilder(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
            width: double.infinity,
            child: Text("STEP 1"),
          ),
        ),
        TextFormField(
          controller: ctl_name,
          decoration: const InputDecoration(labelText: 'Step 1 Name'),
        ),
        TextFormField(
          controller: ctl_age,
          decoration: const InputDecoration(labelText: 'Step 2 Age'),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  color: Colors.blue,
                  child: Text('Next'),
                  onPressed: () {
                    nextPage(context);
                  },
                ),
                Padding(padding: EdgeInsets.only(left: 8)),
                // FlatButton(
                //   color: Colors.blue,
                //   child: Text('Save'),
                //   onPressed: () {
                //     saveData(context);
                //   },
                // ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Column formTwoBuilder(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(border: Border.all(color: Colors.red)),
            width: double.infinity,
            child: Text("STEP 2"),
          ),
        ),
        TextFormField(
          controller: ctl_address,
          decoration: const InputDecoration(labelText: 'Step 2 Address'),
        ),
        TextFormField(
          controller: ctl_city,
          decoration: const InputDecoration(labelText: 'Step 2 City'),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  color: Colors.blue,
                  child: Text('Previous'),
                  onPressed: () {
                    nextPage(context);
                  },
                ),
                Padding(padding: EdgeInsets.only(left: 8)),
                // FlatButton(
                //   color: Colors.blue,
                //   child: Text('Save'),
                //   onPressed: () {
                //     saveData(context);
                //   },
                // ),
              ],
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (_stepNumber) {
      case 1:
        return Form(
          key: _formKey,
          child: this.formOneBuilder(context),
        );
        break;

      case 2:
        return Form(
          key: _formKey,
          child: this.formTwoBuilder(context),
        );
        break;
    }
  }

  void dispose() {
    ctl_address.dispose();
    ctl_age.dispose();
    ctl_city.dispose();
    ctl_name.dispose();
  }
}
