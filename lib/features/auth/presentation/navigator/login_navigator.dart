import 'package:final_assignment/app/navigator/navigator.dart';
import 'package:final_assignment/features/auth/presentation/navigator/signup_navigator.dart';
import 'package:final_assignment/features/auth/presentation/view/login_view.dart';
import 'package:final_assignment/features/home/presentation/navigator/home_navigator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginViewNavigatorProvider = Provider((ref) => LoginViewNavigator());

// This class will be used to call register view
class LoginViewNavigator with RegisterViewRoute, HomeViewRoute {}

// Anyone who want to call login page
mixin LoginViewRoute {
  openLoginView() {
    NavigateRoute.popAndPushRoute(const LoginView());
  }
}
