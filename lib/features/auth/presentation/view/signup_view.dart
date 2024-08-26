import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
import 'package:final_assignment/features/auth/presentation/navigator/signup_navigator.dart';
import 'package:final_assignment/features/auth/presentation/viewmodel/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignupView extends ConsumerStatefulWidget {
  const SignupView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignupViewState();
}

class _SignupViewState extends ConsumerState<SignupView> {
  final _formKey = GlobalKey<FormState>();

  final fullNameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authViewModelProvider);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Background image
            SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Image.asset(
                'assets/images/bggimage.png',
                fit: BoxFit.cover,
              ),
            ),
            Column(
              children: [
                Expanded(
                  flex: 7,
                  child: SingleChildScrollView(
                    child: Container(
                      padding:
                          const EdgeInsets.fromLTRB(25.0, 50.0, 25.0, 20.0),
                      // Removed the color property to make it transparent
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/GMlogo.png',
                              height: 200,
                            ),
                            const SizedBox(
                              height: 1.0,
                            ),
                            const SizedBox(
                              height: 40.0,
                            ),
                            TextFormField(
                              controller: fullNameController,
                              decoration: InputDecoration(
                                label: const Text('Full Name'),
                                labelStyle: const TextStyle(
                                  color:
                                      Colors.white, // Set the label color here
                                ),
                                hintText: 'Enter Full Name',
                                prefixIcon: const Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                                hintStyle: const TextStyle(
                                  color: Colors.white,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.white, // Default border color
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.white, // Default border color
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              keyboardType: TextInputType.name,
                              style: const TextStyle(
                                color: Colors
                                    .white, // Typing text color set to white
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your Full Name';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: phoneController,
                              decoration: InputDecoration(
                                label: const Text('Phone Number'),
                                labelStyle: const TextStyle(
                                  color:
                                      Colors.white, // Set the label color here
                                ),
                                hintText: 'Enter Phone Number',
                                prefixIcon: const Icon(
                                  Icons.phone,
                                  color: Colors.white,
                                ),
                                hintStyle: const TextStyle(
                                  color: Colors.white,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.white, // Default border color
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.white, // Default border color
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              keyboardType: TextInputType.phone,
                              style: const TextStyle(
                                color: Colors
                                    .white, // Typing text color set to white
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your phone number';
                                }
                                if (!RegExp(r'^\+?1?\d{9,15}$')
                                    .hasMatch(value)) {
                                  return 'Please enter a valid phone number';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: emailController,
                              decoration: InputDecoration(
                                label: const Text('Email'),
                                labelStyle: const TextStyle(
                                  color:
                                      Colors.white, // Set the label color here
                                ),
                                hintText: 'Enter Email',
                                prefixIcon: const Icon(
                                  Icons.email,
                                  color: Colors.white,
                                ),
                                hintStyle: const TextStyle(
                                  color: Colors.white,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.white, // Default border color
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.white, // Default border color
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              style: const TextStyle(
                                color: Colors
                                    .white, // Typing text color set to white
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                if (!RegExp(r'^[^@]+@[^@]+\.[^@]+$')
                                    .hasMatch(value)) {
                                  return 'Please enter a valid email';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: passwordController,
                              decoration: InputDecoration(
                                label: const Text('Password'),
                                labelStyle: const TextStyle(
                                  color:
                                      Colors.white, // Set the label color here
                                ),
                                hintText: 'Enter Password',
                                prefixIcon: const Icon(
                                  Icons.lock,
                                  color: Colors.white,
                                ),
                                hintStyle: const TextStyle(
                                  color: Colors.white,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.white, // Default border color
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.white, // Default border color
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isPasswordVisible = !_isPasswordVisible;
                                    });
                                  },
                                ),
                              ),
                              keyboardType: TextInputType.visiblePassword,
                              style: const TextStyle(
                                color: Colors
                                    .white, // Typing text color set to white
                              ),
                              obscureText: !_isPasswordVisible,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                if (value.length < 6) {
                                  return 'Password must be at least 6 characters';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: confirmPasswordController,
                              decoration: InputDecoration(
                                label: const Text('Confirm password'),
                                labelStyle: const TextStyle(
                                  color:
                                      Colors.white, // Set the label color here
                                ),
                                hintText: 'Confirm Password',
                                prefixIcon: const Icon(
                                  Icons.lock,
                                  color: Colors.white,
                                ),
                                hintStyle: const TextStyle(
                                  color: Colors.white,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.white, // Default border color
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.white, // Default border color
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isConfirmPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isConfirmPasswordVisible =
                                          !_isConfirmPasswordVisible;
                                    });
                                  },
                                ),
                              ),
                              keyboardType: TextInputType.visiblePassword,
                              style: const TextStyle(
                                color: Colors
                                    .white, // Typing text color set to white
                              ),
                              obscureText: !_isConfirmPasswordVisible,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please confirm your password';
                                }
                                if (value != passwordController.text) {
                                  return 'Passwords do not match';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 30),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                key: const Key('registerButton'),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    AuthEntity auth = AuthEntity(
                                      fullName: fullNameController.text,
                                      email: emailController.text,
                                      phoneNumber: phoneController.text,
                                      password: passwordController.text,
                                    );
                                    ref
                                        .read(authViewModelProvider.notifier)
                                        .registerUser(auth);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(double.infinity, 50),
                                  backgroundColor: Colors.black,
                                ),
                                child: const Text('Register',
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextButton(
                              onPressed: () {
                                ref
                                    .read(registerViewNavigatorProvider)
                                    .openLoginView();
                              },
                              child: const Text(
                                'Already have an account? Login Now',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            const SizedBox(height: 20),
                            if (authState.isLoading)
                              const CircularProgressIndicator()
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
