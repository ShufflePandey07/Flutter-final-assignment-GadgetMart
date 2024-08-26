import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/auth/domain/usecases/auth_usecases.dart';
import 'package:final_assignment/features/auth/presentation/navigator/login_navigator.dart';
import 'package:final_assignment/features/auth/presentation/viewmodel/auth_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_unit_test.mocks.dart';

@GenerateNiceMocks([
  // Created mock classes for AuthUseCase and LoginViewNavigator So that we dont have to call the original api
  MockSpec<AuthUseCase>(),
  MockSpec<LoginViewNavigator>(),
])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AuthUseCase mockAuthUseCase;
  late ProviderContainer container;
  late LoginViewNavigator mockLoginViewNavigator;

  setUp(() {
    mockAuthUseCase = MockAuthUseCase();
    mockLoginViewNavigator = MockLoginViewNavigator();
    container = ProviderContainer(overrides: [
      authViewModelProvider.overrideWith(
        (ref) => AuthViewModel(
          mockAuthUseCase,
          mockLoginViewNavigator,
        ),
      )
    ]);
  });

  test('check for the initial state in Auth state', () {
    final authState = container.read(authViewModelProvider);
    expect(authState.isLoading, false);
    expect(authState.error, null);
  });

  test("Login test with the valid username and passowrd", () async {
    const correctEmail = 'safal@gmail.com';
    const correctPassword = 'safal123';

    when(mockAuthUseCase.loginUser(any, any)).thenAnswer((invocation) {
      final email = invocation.positionalArguments[0] as String;
      final password = invocation.positionalArguments[1] as String;
      return Future.value(email == correctEmail && password == correctPassword
          ? const Right(true)
          : Left(Failure(error: "invalid ")));
    });

    container
        .read(authViewModelProvider.notifier)
        .loginUser('safal', 'safal123');

    final authState = container.read(authViewModelProvider);

    // Assert
    expect(authState.error, isNull);
  });

  // Act

  tearDown(() {
    container.dispose();
  });
}
