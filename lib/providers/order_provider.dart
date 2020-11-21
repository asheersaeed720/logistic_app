import 'package:flutter/cupertino.dart';

class OrderProvider with ChangeNotifier {
  int _stepFormNo = 1;
  int get stepFormNo => _stepFormNo;
  set stepFormNo(int indexVal) {
    _stepFormNo = indexVal;
    notifyListeners();
  }

  formNavigation() {
    if (stepFormNo == 1) {
      stepFormNo = 2;
    } else {
      stepFormNo = 1;
    }
  }

  resetStepFormNo() {
    stepFormNo = 1;
  }
}
