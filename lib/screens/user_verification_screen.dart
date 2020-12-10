import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';

import 'package:hani_almutairi_logistic/providers/auth_provider.dart';
import 'package:hani_almutairi_logistic/widgets/loading_indicator.dart';

class UserVerificationScreen extends StatefulWidget {
  static const String routeName = '/user-verification';

  @override
  _UserVerificationScreenState createState() => _UserVerificationScreenState();
}

class _UserVerificationScreenState extends State<UserVerificationScreen> {
  TextEditingController _pinEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authPvd = Provider.of<AuthProvider>(context);

    final user = ModalRoute.of(context).settings.arguments;

    return WillPopScope(
      onWillPop: authPvd.isLoading
          ? null
          : () async {
              return false;
            },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                color: Theme.of(context).primaryColor,
              ),
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 16,
              ),
            ),
            onPressed: authPvd.isLoading
                ? null
                : () {
                    Navigator.of(context).pop();
                  },
          ),
          elevation: 0,
          brightness: Brightness.light,
        ),
        body: SafeArea(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Enter 4 digits verification code sent to your number',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 30),
                PinInputTextField(
                  autoFocus: true,
                  inputFormatter: [
                    LengthLimitingTextInputFormatter(4),
                  ],
                  pinLength: 4,
                  decoration: UnderlineDecoration(
                    colorBuilder: PinListenColorBuilder(
                      Theme.of(context).primaryColor,
                      Colors.grey,
                    ),
                  ),
                  controller: _pinEditingController,
                  textInputAction: TextInputAction.go,
                  keyboardType: TextInputType.number,
                  textCapitalization: TextCapitalization.characters,
                  onSubmit: (pin) {
                    debugPrint('submit pin:$pin');
                  },
                  onChanged: (pin) {
                    debugPrint('onChanged execute. pin:$pin');
                  },
                  enableInteractiveSelection: false,
                ),
                const SizedBox(height: 40),
                authPvd.isLoading
                    ? LoadingIndicator()
                    : _buildConfirmBtn(context, authPvd),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildConfirmBtn(context, authPvd) {
    return Container(
      // margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      constraints: const BoxConstraints(maxWidth: 500),
      child: RaisedButton(
        onPressed: () {
          print('${_pinEditingController.text}');
          authPvd.getVerify(context, _pinEditingController.text);
        },
        color: Theme.of(context).primaryColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 8,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Confirm',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                  color: Theme.of(context).primaryColor.withOpacity(0.4),
                ),
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 16,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
