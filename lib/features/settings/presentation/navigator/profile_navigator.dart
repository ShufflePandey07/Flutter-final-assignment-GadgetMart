import 'package:final_assignment/app/navigator/navigator.dart';
import 'package:final_assignment/features/auth/presentation/navigator/login_navigator.dart';
import 'package:final_assignment/features/settings/presentation/view/profile_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profileNavigatorProvider = Provider<ProfileNavigator>((ref) {
  return ProfileNavigator();
});

class ProfileNavigator with LoginViewRoute {}

mixin ProfileRoute {
  openProfile() {
    NavigateRoute.popAndPushRoute(const ProfileView());
  }
}
