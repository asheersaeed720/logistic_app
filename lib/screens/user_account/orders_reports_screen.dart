import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:hani_almutairi_logistic/models/order_report.dart';
import 'package:hani_almutairi_logistic/providers/auth_provider.dart';
import 'package:hani_almutairi_logistic/providers/order_provider.dart';
import 'package:hani_almutairi_logistic/utils/input_decoration.dart';
import 'package:provider/provider.dart';

class OrdersReportsScreen extends StatelessWidget {
  static const String routeName = '/orders-reports';

//   reports
// from: date picker
// to  : date picker
// checkbox:
// 1. shipment report
// 2. report of invoice
// 3. balance report
// 4. transfer report
// text feild email
// btn

  final _formKey = new GlobalKey<FormState>();

  OrderReport _orderReport = OrderReport();

  @override
  Widget build(BuildContext context) {
    final orderPvd = Provider.of<OrderProvider>(context);
    final authPvd = Provider.of<AuthProvider>(context);

    final shipmentReport = CheckboxListTile(
      title: Text('Shipment report'),
      value: orderPvd.isShipmentReportSelected,
      onChanged: (value) {
        orderPvd.setShipmentReportSelected(value);
      },
      controlAffinity: ListTileControlAffinity.leading,
    );

    final invoiceReport = CheckboxListTile(
      title: Text('Report of invoice'),
      value: orderPvd.isInvoiceReportSelected,
      onChanged: (value) {
        orderPvd.setInvoiceReportSelected(value);
      },
      controlAffinity: ListTileControlAffinity.leading,
    );

    final balanceReport = CheckboxListTile(
      title: Text('Balance Report'),
      value: orderPvd.isBalanceReportSelected,
      onChanged: (value) {
        orderPvd.setBalanceReportSelected(value);
      },
      controlAffinity: ListTileControlAffinity.leading,
    );

    final transferReport = CheckboxListTile(
      title: Text('Transfer Report'),
      value: orderPvd.isSelectedTransferReport,
      onChanged: (value) {
        orderPvd.setSelectedTransferReport(value);
      },
      controlAffinity: ListTileControlAffinity.leading,
    );

    final emailField = TextFormField(
      autofocus: false,
      validator: (value) => value.isEmpty ? "Please fill this" : null,
      onSaved: (value) => _orderReport.email = value,
      keyboardType: TextInputType.emailAddress,
      decoration: buildTextFieldInputDecoration("Email", Icons.mail),
    );

    final submit = Material(
      elevation: 4.0,
      borderRadius: BorderRadius.circular(6.0),
      color: Theme.of(context).primaryColor,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width * 0.8,
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            orderPvd.addOrderReport(
              context,
              authPvd.user,
              _orderReport,
              orderPvd.isShipmentReportSelected,
              orderPvd.isInvoiceReportSelected,
              orderPvd.isBalanceReportSelected,
              orderPvd.isSelectedTransferReport,
            );
          }
        },
        child: Text(
          "Submit",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 2.1,
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Order Report'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  children: [
                    Text('From:'),
                    FlatButton(
                      onPressed: () {
                        DatePicker.showDatePicker(context,
                            showTitleActions: true,
                            minTime: DateTime(2020, 3, 5),
                            maxTime: DateTime(2050, 6, 7), onChanged: (date) {
                          print('change $date');
                        }, onConfirm: (date) {
                          print('confirm $date');
                          _orderReport.fromDate = date;
                        }, currentTime: DateTime.now(), locale: LocaleType.en);
                      },
                      child: Text(
                        'From',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text('To:'),
                    FlatButton(
                      onPressed: () {
                        DatePicker.showDatePicker(context,
                            showTitleActions: true,
                            minTime: DateTime(2020, 3, 5),
                            maxTime: DateTime(2050, 6, 7), onChanged: (date) {
                          print('change $date');
                        }, onConfirm: (date) {
                          print('confirm $date');
                          _orderReport.toDate = date;
                        }, currentTime: DateTime.now(), locale: LocaleType.en);
                      },
                      child: Text(
                        'to',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
                shipmentReport,
                invoiceReport,
                balanceReport,
                transferReport,
                const SizedBox(height: 12),
                Container(
                  width: MediaQuery.of(context).size.width / 1.3,
                  child: emailField,
                ),
                const SizedBox(height: 20),
                submit,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
