class Parameter {
  static const bool API_PRINT_LOGGING_ENABLED = true;
}

class ApiUrl {
  static String MAIN_BASE = MAIN_BASE_DEVELOPMENT;
  static String SECONDARY_BASE = SECONDARY_BASE_DEVELOPMENT;

  // Server development
  static final String MAIN_BASE_DEVELOPMENT = "https://fakestoreapi.com";
  static final String SECONDARY_BASE_DEVELOPMENT = "https://fakestoreapi.com";


  static const String SIGN_IN = "/auth/login";
  static const String GET_PKBU = "/get-company";
  static const String REFRESH_TOKEN = "/refresh-token";
  static const String GET_USER_2 = "/users/2";
  static const String GET_PRODUCT = "/products";
  static const String GET_CATEGORIES = "/products/categories";
  static const String GET_SPECIFIC_CATEGORY = "/products/category/";
  static const String GET_USER_CART = "/carts/user/";
  static const String GET_CART = "/carts";


}

enum SharedPreferenceKey {
  IS_LOGIN,
  MAIN_BASE,
  SECONDARY_BASE,
  SESSION_ID,
  FIRSTNAME,
  LASTNAME,
  SESSION_EXPIRED_AT,
  USER_CODE,
  COMPANY_CODE
}