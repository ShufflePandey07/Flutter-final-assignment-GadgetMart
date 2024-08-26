import 'dart:async';

import 'package:all_sensors2/all_sensors2.dart';
import 'package:final_assignment/core/common/common_widget/show_my_snackbar.dart';
import 'package:final_assignment/core/common/provider/my_yes_no_dialog.dart';
import 'package:final_assignment/features/auth/presentation/navigator/login_navigator.dart';
import 'package:final_assignment/features/auth/presentation/viewmodel/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final _formSignInKey = GlobalKey<FormState>();
  List<double> _gyroscopeValues = [];
  final List<StreamSubscription<dynamic>> _streamSubscription = [];

  @override
  void initState() {
    _streamSubscription.add(gyroscopeEvents!.listen((GyroscopeEvent event) {
      setState(() {
        _gyroscopeValues = <double>[event.x, event.y, event.z];

        _checkGyroscopeValues(_gyroscopeValues);
      });
    }));

    super.initState();
  }

  final TextEditingController _emailController =
      TextEditingController(text: 'pandey@gmail.com');
  final TextEditingController _passwordController =
      TextEditingController(text: '1111111');
  bool rememberPassword = true;
  bool _isPasswordVisible = false;
  bool showYesNoDialog = true;
  bool isDialogShowing = false;

  void _checkGyroscopeValues(List<double> values) async {
    const double threshold = 0.5; // Example threshold value, adjust as needed
    if (values.any((value) => value.abs() > threshold)) {
      if (showYesNoDialog && !isDialogShowing) {
        isDialogShowing = true;
        final result = await myYesNoDialog(
          title: 'Are you sure you want to send feedback?',
        );
        isDialogShowing = false;
        if (result) {
          showMySnackBar(
            message: 'Feedback sent',
            color: Colors.green,
          );
        }
      }
      showMySnackBar(message: 'Feedback sent');
    }
  }

  @override
  Widget build(BuildContext context) {
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
                        key: _formSignInKey,
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
                              controller: _emailController,
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
                            const SizedBox(
                              height: 25.0,
                            ),
                            TextFormField(
                              controller: _passwordController,
                              obscureText: !_isPasswordVisible,
                              obscuringCharacter: '*',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Password';
                                }
                                return null;
                              },
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
                                    size: 20.0,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isPasswordVisible = !_isPasswordVisible;
                                    });
                                  },
                                ),
                              ),
                              style: const TextStyle(
                                color: Colors
                                    .white, // Typing text color set to white
                              ),
                            ),
                            const SizedBox(
                              height: 25.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                      value: rememberPassword,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          rememberPassword = value!;
                                        });
                                      },
                                      focusColor: Colors.white,
                                    ),
                                    const Text(
                                      'Remember me',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  child: const Text(
                                    'Forget password?',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 25.0,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formSignInKey.currentState!.validate() &&
                                      rememberPassword) {
                                    ref
                                        .watch(authViewModelProvider.notifier)
                                        .loginUser(_emailController.text,
                                            _passwordController.text);
                                  } else if (!rememberPassword) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            'Please agree to the processing of personal data'),
                                      ),
                                    );
                                  }
                                },
                                child: const Text('Login'),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.fingerprint,
                                size: 50,
                              ),
                              onPressed: () {
                                ref
                                    .read(authViewModelProvider.notifier)
                                    .fingerPrintLogin();
                              },
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Don\'t have an account? ',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    ref
                                        .read(loginViewNavigatorProvider)
                                        .openRegisterView();
                                  },
                                  child: const Text(
                                    'Sign up',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 25.0,
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 0,
                                    horizontal: 10,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Continue with',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 25.0,
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Icon(
                                      Icons.facebook,
                                      color: Colors.white,
                                    ),
                                    Text('Facebook',
                                        style: TextStyle(color: Colors.white)),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Icon(
                                      Icons.apple,
                                      color: Colors.white,
                                    ),
                                    Text('Apple',
                                        style: TextStyle(color: Colors.white)),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 25.0,
                            ),
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
