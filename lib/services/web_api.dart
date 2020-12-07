class WebApi {
  var test = '576398998';
  static const String apiKey = 'fdsanfbsalsdola_nljkagn_';
  static const String xApiKey =
      '0cd80861f585f2135f559bef1980dff1'; // FOR TESTING
  static const String baseURL = 'https://portal.hubexsa.com/API';
  static const String loginURL = baseURL + '/auth/login';
  // static const String loginGetkeyURL = baseURL + '/auth/get_key';
  static const String registerURL = baseURL + '/auth/signup';
  static const String getUserVerifyURL = baseURL + '/auth/verify';
  static const String getCitiesURL = baseURL + '/locations/cities';
  static const String addOrderURL = baseURL + '/Orders/order';
  static const String updateOrderURL = baseURL + '/Orders/order_update';
  static const String getOrderURL = baseURL + '/Orders/orders';

  static const String getFilterOrdersURL = baseURL + '/Orders/search';
  static const String getUserAddressesURL = baseURL + '/Users/addresses';
  static const String getUserAddressesByIdURL = baseURL + '/Users/address';

  static const String addUserAddressesURL = baseURL + '/Users/address';
  static const String delUserAddressesURL = baseURL + '/Users/address';
  static const String changePasswordURL = baseURL + '/Users/user_password';
  static const String getforgotPasswordKeyURL = baseURL + '/auth/forgot_key';
  static const String forgotPasswordURL = baseURL + '/auth/forgot';
}
