import 'package:final_assignment/features/splash/presentation/navigator/splash_navigator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final splashViewModelProvider =
    StateNotifierProvider<SplashViewModel, void>((ref) {
  final navigator = ref.read(splashViewNavigatorProvider);
  return SplashViewModel(navigator);
});

class SplashViewModel extends StateNotifier<void> {
  SplashViewModel(this.navigator) : super(null);

// Dependency Injection
  final SplashViewNavigator navigator;

  // Open login page
  void openLoginView() async {
    // Delaying login view opening for 1 secs
    Future.delayed(const Duration(seconds: 2), () {
      navigator.openLoginView();
    });
  }

  void openHomeView() {
    // Open Home View Logic
  }
}