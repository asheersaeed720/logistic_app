class WebApi {
  static const String apiKey = 'fdsanfbsalsdola_nljkagn_';
  static const String xApiKey =
      '8468c401f53feeaedcc3ed7ccfed5db6'; // FOR TESTING
  static const String baseURL = 'https://portal.hubexsa.com/API';
  static const String loginURL = baseURL + '/auth/login';
  static const String loginGetkeyURL = baseURL + '/auth/get_key';
  static const String registerURL = baseURL + '/auth/signup';
  static const String getCitiesURL = baseURL + '/locations/cities';
  static const String addOrderURL = baseURL + '/Orders/order';
  static const String getOrderURL = baseURL + '/Orders/orders';

  static const String getFilterOrdersURL = baseURL + '/Orders/search';
  static const String getUserAddressesURL = baseURL + '/Users/addresses';
  static const String addUserAddressesURL = baseURL + '/Users/address';
  static const String delUserAddressesURL = baseURL + '/Users/address';
  static const String changePasswordURL = baseURL + '/Users/user_password';
  static const String getforgotPasswordKeyURL = baseURL + '/auth/forgot_key';
  static const String forgotPasswordURL = baseURL + '/auth/forgot';
}
