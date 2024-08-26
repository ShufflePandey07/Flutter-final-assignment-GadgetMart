class ApiEndPoints {
  ApiEndPoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);
  // static const String baseUrl = 'http://10.0.2.2:5000/api/';
  static const String baseUrl = 'http://192.168.100.156/api/';

  // --------------------------Auth Routes--------------------------
  static const String loginUser = "user/login";
  static const String registerUser = "user/create";
  static const String pagination = "product/pagination";
  // static const String productImage = "http://10.0.2.2:5000/products/";
  static const String getMe = "user/get_single_user";
  static const String getToken = "user/getToken";
  static const String verifyUser = "user/verify";
  static const String updateUser = "user/update_profile";

  static const String productImage = "http://192.168.100.156/api/products/";

  // Cart Routes
  static const String addToCart = "cart/add";
  static const String getCart = "cart/all";
  static const String removeFromCart = "cart/delete/";
  static const String updateQuantity = "cart/update/";
  static const String clearCart = "/update/";
  static const String changeStatus = "cart/status";

  // Favourites Routes
  static const String addToFavourites = "favourite/add";
  static const String getFavourites = "favourite/get";
  static const String removeFromFavourites = "favourite/delete/";

  // Order Routes
  static const String createOrder = "order/create";
  static const String getOrder = "order/user";
}
