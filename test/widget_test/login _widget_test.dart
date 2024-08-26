import 'package:dartz/dartz.dart';
import 'package:final_assignment/app/navigator_key/navigator_key.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/auth/domain/usecases/auth_usecases.dart';
import 'package:final_assignment/features/auth/presentation/navigator/login_navigator.dart';
import 'package:final_assignment/features/auth/presentation/view/login_view.dart';
import 'package:final_assignment/features/auth/presentation/viewmodel/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../unit_test/login_unit_test.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AuthUseCase mockAuthUseCase;

  setUp(() {
    mockAuthUseCase = MockAuthUseCase();
  });

  // Check initial view
  testWidgets('renders loginView', (tester) async {
    await tester.pumpWidget(ProviderScope(
        overrides: [
          authViewModelProvider.overrideWith(
            (ref) => AuthViewModel(mockAuthUseCase, LoginViewNavigator()),
          )
        ],
        child: MaterialApp(
          home: const LoginView(),
          navigatorKey: AppNavigator.navigatorKey,
        )));

    await tester.pumpAndSettle();

    expect(find.text("Login"), findsOneWidget);
  });

  testWidgets("Login test with valid username and password", (tester) async {
    const correctEmail = 'safal@gmail.com';
    const correctPassword = 'safal123';

    when(mockAuthUseCase.loginUser(any, any)).thenAnswer((invocation) {
      final email = invocation.positionalArguments[0] as String;
      final password = invocation.positionalArguments[1] as String;
      return Future.value(email == correctEmail && password == correctPassword
          ? const Right(true)
          : Left(Failure(error: "invalid ")));
    });

    await tester.pumpWidget(ProviderScope(
        overrides: [
          authViewModelProvider.overrideWith(
            (ref) => AuthViewModel(mockAuthUseCase, LoginViewNavigator()),
          )
        ],
        child: MaterialApp(
          home: const LoginView(),
          navigatorKey: AppNavigator.navigatorKey,
        )));

    await tester.pumpAndSettle(const Duration(seconds: 10));
    print("test");

    // Enter email
    await tester.enterText(find.byType(TextFormField).at(0), correctEmail);
    // Enter password
    await tester.enterText(find.byType(TextFormField).at(1), correctPassword);

    // Tap the login button
    await tester.tap(find.text('Login'));

    // Verify that the login method was called
    verify(mockAuthUseCase.loginUser(correctEmail, correctPassword)).called(1);
  });

  testWidgets("Login test with invalid username and password", (tester) async {
    const incorrectEmail = 'invalid@gmail.com';
    const incorrectPassword = 'wrongpassword';

    when(mockAuthUseCase.loginUser(any, any)).thenAnswer((invocation) {
      final email = invocation.positionalArguments[0] as String;
      final password = invocation.positionalArguments[1] as String;
      return Future.value(
          email == incorrectEmail && password == incorrectPassword
              ? const Right(true)
              : Left(Failure(error: "invalid credentials")));
    });

    await tester.pumpWidget(ProviderScope(
        overrides: [
          authViewModelProvider.overrideWith(
            (ref) => AuthViewModel(mockAuthUseCase, LoginViewNavigator()),
          )
        ],
        child: MaterialApp(
          home: const LoginView(),
          navigatorKey: AppNavigator.navigatorKey,
        )));

    await tester.pumpAndSettle();

    // Enter invalid email
    await tester.enterText(find.byType(TextFormField).at(0), incorrectEmail);
    // Enter invalid password
    await tester.enterText(find.byType(TextFormField).at(1), incorrectPassword);

    // Tap the login button
    await tester.tap(find.text('Login'));

    // Verify that the login method was called
    verify(mockAuthUseCase.loginUser(incorrectEmail, incorrectPassword))
        .called(1);

        
  });
}
