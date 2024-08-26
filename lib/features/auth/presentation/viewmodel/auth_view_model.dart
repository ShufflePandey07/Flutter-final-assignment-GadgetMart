import 'package:final_assignment/core/common/common_widget/show_my_snackbar.dart';
import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
import 'package:final_assignment/features/auth/domain/usecases/auth_usecases.dart';
import 'package:final_assignment/features/auth/presentation/navigator/login_navigator.dart';
import 'package:final_assignment/features/auth/presentation/state/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';

final authViewModelProvider =
    StateNotifierProvider<AuthViewModel, AuthState>((ref) {
  return AuthViewModel(
      ref.read(authUseCaseProvider), ref.read(loginViewNavigatorProvider));
});

class AuthViewModel extends StateNotifier<AuthState> {
  AuthViewModel(this.authUseCase, this.navigator) : super(AuthState.initial());

  final AuthUseCase authUseCase;
  final LoginViewNavigator navigator;
  late LocalAuthentication _localAuth;

  Future<void> registerUser(AuthEntity auth) async {
    state = state.copyWith(isLoading: true);
    var data = await authUseCase.registerUser(auth);
    data.fold(
      (l) {
        state = state.copyWith(isLoading: false, error: l.error);
        // showMySnackBar(message: l.error, color: Colors.red);
      },
      (r) {
        state = state.copyWith(isLoading: false);
        // showMySnackBar(message: 'Register Success');
      },
    );
  }

  void loginUser(String email, String password) async {
    state = state.copyWith(isLoading: true);
    var data = await authUseCase.loginUser(email, password);
    data.fold(
      (l) {
        state = state.copyWith(isLoading: false, error: l.error);
        // showMySnackBar(message: l.error, color: Colors.red);
      },
      (r) {
        state = state.copyWith(isLoading: false, error: null);
        // showMySnackBar(message: 'Login Success');
        openHomeView();
      },
    );
  }

  void openHomeView() {
    navigator.openHomeView();
  }

  Future<void> fingerPrintLogin() async {
    _localAuth = LocalAuthentication();

    bool authenticated = false;
    try {
      authenticated = await _localAuth.authenticate(
        localizedReason: 'Authenticate to enable fingerprint',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
          useErrorDialogs: true,
        ),
      );
    } catch (e) {
      showMySnackBar(
          message: 'Fingerprint authentication failed', color: Colors.red);
    }

    if (authenticated) {
      authUseCase.fingerPrintLogin().then((data) {
        data.fold(
          (l) {
            showMySnackBar(message: l.error, color: Colors.red);
          },
          (r) {
            showMySnackBar(message: "User logged in successfully");
            navigator.openHomeView();
          },
        );
      });
    } else {
      showMySnackBar(
          message: 'Fingerprint authentication failed', color: Colors.red);
    }
  }
}
