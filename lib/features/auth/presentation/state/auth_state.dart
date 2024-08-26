class AuthState {
  final bool isLoading;
  final String? error;
  // final bool isObscure;

  AuthState({
    // required this.isObscure,
    required this.isLoading,
    this.error,
  });

  factory AuthState.initial() => AuthState(
        isLoading: false,
        error: null,
        // isObscure: true,
      );

  AuthState copyWith({
    bool? isLoading,
    bool? isObscure,
    String? error,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      // isObscure: isObscure ?? this.isObscure,
    );
  }
}
