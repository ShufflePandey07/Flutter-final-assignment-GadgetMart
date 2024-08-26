import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
import 'package:final_assignment/features/auth/domain/usecases/auth_usecases.dart';
import 'package:final_assignment/features/auth/presentation/navigator/login_navigator.dart';
import 'package:final_assignment/features/auth/presentation/viewmodel/auth_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_unit_test.mocks.dart';

@GenerateNiceMocks([
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
        (ref) => AuthViewModel(mockAuthUseCase, mockLoginViewNavigator),
      )
    ]);
  });
  test(
    "Register test with the valid Name, email, phone number and password",
    () async {
      when(mockAuthUseCase.registerUser(any)).thenAnswer((innovation) {
        final auth = innovation.positionalArguments[0] as AuthEntity;
        return Future.value(
          auth.fullName.isNotEmpty &&
                  auth.email.isNotEmpty &&
                  auth.phoneNumber.isNotEmpty &&
                  auth.password.isNotEmpty
              ? const Right(true)
              : Left(
                  Failure(error: 'Invalid'),
                ),
        );
      });
      await container
          .read(authViewModelProvider.notifier)
          .registerUser(const AuthEntity(
            fullName: "Safal Pandey",
            email: "pandeyy@gmail.com",
            phoneNumber: "9864440029",
            password: "123123",
          ));

      final state = container.read(authViewModelProvider);

      // Assert
      expect(state.isLoading, false);
      expect(state.error, null);
    },
  );

  tearDown(() {
    container.dispose();
  });
}
