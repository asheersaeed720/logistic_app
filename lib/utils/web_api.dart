class WebApi {
  static const String appKey = 'fdsanfbsalsdola_nljkagn_';

  static const String baseURL = 'https://portal.hubexsa.com/API';

  static const String loginURL = baseURL + '/auth/login';

  static const String registerURL = baseURL + '/auth/signup';

  static const String userVerificationURL = baseURL + '/auth/verify';

  static const String getCitiesURL = baseURL + '/locations/cities';

  static const String addOrderURL = baseURL + '/Orders/order';

  static const String updateOrderURL = baseURL + '/Orders/order_update';

  static const String getOrderURL = baseURL + '/Orders/orders';

  static const String getOrderbySenderOrReceiverURL =
      baseURL + '/Orders/search_by_address';

  static const String getFilterOrdersURL = baseURL + '/Orders/search';

  static const String getUserAddressesURL = baseURL + '/Users/addresses';

  static const String getUserAddressesByIdURL = baseURL + '/Users/address';

  static const String addUserAddressesURL = baseURL + '/Users/address';

  static const String delUserAddressesURL = baseURL + '/Users/address';

  static const String changePasswordURL = baseURL + '/Users/user_password';

  static const String getforgotPasswordKeyURL = baseURL + '/auth/forgot_key';

  static const String forgotPasswordURL = baseURL + '/auth/forgot';

  static const String getDeliveryCost = baseURL + '/Misc/settings';

  static const String getBankURL = baseURL + '/Misc/banks';

  static const String getBalanceURL = baseURL + '/Users/dashboard_data';

  static const String getNotificationURL = baseURL + '/Users/notifications';

  static const String withDrawAmountURL = baseURL + '/Users/withdraw';

  static const String reportOrderURL = baseURL + '/reports/report';
}

// TEST LOGIN CREDENTIAL
// '576398998';
// 'test123';
