import 'package:final_assignment/app/navigator/navigator.dart';
import 'package:final_assignment/features/auth/presentation/navigator/login_navigator.dart';
import 'package:final_assignment/features/home/presentation/view/home_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeViewNavigatorProvider =
    Provider<HomeViewNavigator>((ref) => HomeViewNavigator());

// This will be used to view login view
class HomeViewNavigator with LoginViewRoute {}

mixin HomeViewRoute {
  openHomeView() {
    NavigateRoute.popAndPushRoute(const DashboardView());
  }
}
