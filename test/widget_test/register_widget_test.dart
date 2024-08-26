import 'package:dartz/dartz.dart';
import 'package:final_assignment/app/navigator_key/navigator_key.dart';
import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
import 'package:final_assignment/features/auth/domain/usecases/auth_usecases.dart';
import 'package:final_assignment/features/auth/presentation/navigator/login_navigator.dart';
import 'package:final_assignment/features/auth/presentation/view/signup_view.dart';
import 'package:final_assignment/features/auth/presentation/viewmodel/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../unit_test/login_unit_test.mocks.dart';

void main() {
  late AuthUseCase mockAuthUsecase;

  setUp(() {
    mockAuthUsecase = MockAuthUseCase();
  });

  testWidgets('renders SignupView', (tester) async {
    await tester.pumpWidget(ProviderScope(
      overrides: [
        authViewModelProvider.overrideWith(
            (ref) => AuthViewModel(mockAuthUsecase, LoginViewNavigator())),
      ],
      child: MaterialApp(
        home: const SignupView(),
        navigatorKey: AppNavigator.navigatorKey,
      ),
    ));

    await tester.pumpAndSettle();

    // Check if all fields are present
    expect(find.byType(TextFormField), findsNWidgets(5)); // 5 text fields
    expect(find.text('Register'), findsOneWidget);
    expect(find.text('Already have an account? Login Now'), findsOneWidget);
  });

  testWidgets('shows validation errors when form is submitted empty',
      (tester) async {
    await tester.pumpWidget(ProviderScope(
      overrides: [
        authViewModelProvider.overrideWith(
            (ref) => AuthViewModel(mockAuthUsecase, LoginViewNavigator())),
      ],
      child: MaterialApp(
        home: const SignupView(),
        navigatorKey: AppNavigator.navigatorKey,
      ),
    ));

    await tester.pumpAndSettle();

    // Try to submit the form
    expect(find.text('Register'), findsOneWidget);
    // scroll the ui
    final registerBtn = find.text('Register');
    await tester.ensureVisible(registerBtn);

    await tester.tap(registerBtn);

    await tester.pumpAndSettle();

    // Expect validation errors
    expect(find.text('Please enter your Full Name'), findsOneWidget);
    expect(find.text('Please enter your phone number'), findsOneWidget);
    expect(find.text('Please enter your email'), findsOneWidget);
    expect(find.text('Please enter your password'), findsOneWidget);
    expect(find.text('Please confirm your password'), findsOneWidget);
  });

  testWidgets('submits the form with valid data', (tester) async {
    // Mock the use case
    AuthEntity user = const AuthEntity(
      fullName: 'test test',
      email: 'test@gmail.com',
      phoneNumber: '9864440029',
      password: '12345678',
    );

    when(mockAuthUsecase.registerUser(any)).thenAnswer((_) async {
      return Future.value(const Right(true));
    });

    // Pump the widget
    await tester.pumpWidget(ProviderScope(
      overrides: [
        authViewModelProvider.overrideWith(
            (ref) => AuthViewModel(mockAuthUsecase, LoginViewNavigator())),
      ],
      child: MaterialApp(
        home: const SignupView(),
        navigatorKey: AppNavigator.navigatorKey,
      ),
    ));

    await tester.pumpAndSettle();

    // Enter valid data into each TextFormField by index
    await tester.enterText(
        find.byType(TextFormField).at(0), 'test test'); // Full Name
    await tester.enterText(
        find.byType(TextFormField).at(1), '9864440029'); // Phone Number
    await tester.enterText(
        find.byType(TextFormField).at(2), 'test@gmail.com'); // Email
    await tester.enterText(
        find.byType(TextFormField).at(3), '12345678'); // Password
    await tester.enterText(
        find.byType(TextFormField).at(4), '12345678'); // Confirm Password

    // Submit the form
    expect(find.text('Register'), findsOneWidget);

    // scroll the ui
    final registerBtn = find.text('Register');
    await tester.ensureVisible(registerBtn);

    await tester.tap(registerBtn);

    await tester.pumpAndSettle();

    // Verify that registerUser was called with the correct data
    verify(mockAuthUsecase.registerUser(user)).called(1);
  });

  testWidgets('shows loading indicator when submitting', (tester) async {
    when(mockAuthUsecase.registerUser(any)).thenAnswer((_) async {
      await Future.delayed(const Duration(seconds: 2));
      return const Right(true);
    });

    await tester.pumpWidget(ProviderScope(
      overrides: [
        authViewModelProvider.overrideWith(
            (ref) => AuthViewModel(mockAuthUsecase, LoginViewNavigator())),
      ],
      child: MaterialApp(
        home: const SignupView(),
        navigatorKey: AppNavigator.navigatorKey,
      ),
    ));

    await tester.pumpAndSettle();

    // Enter valid data into each TextFormField by index
    await tester.enterText(
        find.byType(TextFormField).at(0), 'test test'); // Full Name
    await tester.enterText(
        find.byType(TextFormField).at(1), '9864440029'); // Phone Number
    await tester.enterText(
        find.byType(TextFormField).at(2), 'test@gmail.com'); // Email
    await tester.enterText(
        find.byType(TextFormField).at(3), '12345678'); // Password
    await tester.enterText(
        find.byType(TextFormField).at(4), '12345678'); // Confirm Password

    // Submit the form
    final registerBtn = find.text('Register');
    await tester.ensureVisible(registerBtn);

    await tester.tap(registerBtn);

    await tester.pumpAndSettle();

    // Verify that loading indicator appears

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
