import 'package:final_assignment/features/settings/presentation/viewmodel/current_user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

class UserProfileView extends ConsumerStatefulWidget {
  const UserProfileView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UserProfileViewState();
}

class _UserProfileViewState extends ConsumerState<UserProfileView> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _fullNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    final state = ref.read(currentUserViewModelProvider);
    _fullNameController =
        TextEditingController(text: state.authEntity?.fullName);
    _emailController = TextEditingController(text: state.authEntity?.email);
    _phoneController =
        TextEditingController(text: state.authEntity?.phoneNumber);
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _updateProfile() {
    if (_formKey.currentState!.validate()) {
      // Update profile logic here
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(currentUserViewModelProvider);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Edit Profile',
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Lottie.asset(
                'assets/lottie/profile_animation.json', // Add your Lottie animation file
                height: 220,
                width: 200,
              ),
              const SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildTextField(
                      controller: _fullNameController,
                      label: 'Full Name',
                      icon: Icons.person,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _emailController,
                      label: 'Email',
                      icon: Icons.email,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _phoneController,
                      label: 'Phone',
                      icon: Icons.phone,
                    ),
                    const SizedBox(height: 16),
                  
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: _updateProfile,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ),
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                        child: Text('Update Profile',
                            style: TextStyle(fontSize: 18)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscureText = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.purple),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.transparent,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }
}

// import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
// import 'package:final_assignment/features/settings/presentation/viewmodel/current_user_view_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:lottie/lottie.dart';

// class UserProfileView extends ConsumerStatefulWidget {
//   const UserProfileView({super.key});

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() =>
//       _UserProfileViewState();
// }

// class _UserProfileViewState extends ConsumerState<UserProfileView> {
//   final _formKey = GlobalKey<FormState>();
//   late TextEditingController _fullNameController;
//   late TextEditingController _emailController;
//   late TextEditingController _phoneController;
//   late TextEditingController _passwordController;
//   bool _isPasswordVisible = false;

//   @override
//   void initState() {
//     super.initState();
//     final state = ref.read(currentUserViewModelProvider);
//     _fullNameController =
//         TextEditingController(text: state.authEntity?.fullName);
//     _emailController = TextEditingController(text: state.authEntity?.email);
//     _phoneController =
//         TextEditingController(text: state.authEntity?.phoneNumber);
//     _passwordController =
//         TextEditingController(text: state.authEntity?.password);
//   }

//   @override
//   void dispose() {
//     _fullNameController.dispose();
//     _emailController.dispose();
//     _phoneController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   void _updateProfile() {
//     if (_formKey.currentState!.validate()) {
//       ref.read(currentUserViewModelProvider.notifier).updateUser(
//             AuthEntity(
//               fullName: _fullNameController.text,
//               email: _emailController.text,
//               phoneNumber: _phoneController.text,
//               password: _passwordController.text,
//             ),
//           );
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Profile updated successfully')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final state = ref.watch(currentUserViewModelProvider);
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               const Text(
//                 'Edit Profile',
//                 style: TextStyle(
//                     fontSize: 28,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 20),
//               Lottie.asset(
//                 'assets/lottie/profile_animation.json', // Add your Lottie animation file
//                 height: 220,
//                 width: 200,
//               ),
//               const SizedBox(height: 20),
//               Form(
//                 key: _formKey,
//                 child: Column(
//                   children: [
//                     _buildTextField(
//                       controller: _fullNameController,
//                       label: 'Full Name',
//                       icon: Icons.person,
//                     ),
//                     const SizedBox(height: 16),
//                     _buildTextField(
//                       controller: _emailController,
//                       label: 'Email',
//                       icon: Icons.email,
//                     ),
//                     const SizedBox(height: 16),
//                     _buildTextField(
//                       controller: _phoneController,
//                       label: 'Phone',
//                       icon: Icons.phone,
//                     ),
//                     const SizedBox(height: 16),
//                     _buildTextField(
//                       controller: _passwordController,
//                       label: 'Password',
//                       icon: Icons.lock,
//                       obscureText: !_isPasswordVisible,
//                       suffixIcon: IconButton(
//                         icon: Icon(
//                           _isPasswordVisible
//                               ? Icons.visibility
//                               : Icons.visibility_off,
//                         ),
//                         onPressed: () {
//                           setState(() {
//                             _isPasswordVisible = !_isPasswordVisible;
//                           });
//                         },
//                       ),
//                     ),
//                     const SizedBox(height: 32),
//                     ElevatedButton(
//                       onPressed: _updateProfile,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.purple,
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(30)),
//                       ),
//                       child: const Padding(
//                         padding:
//                             EdgeInsets.symmetric(vertical: 16, horizontal: 32),
//                         child: Text('Update Profile',
//                             style: TextStyle(fontSize: 18)),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String label,
//     required IconData icon,
//     bool obscureText = false,
//     Widget? suffixIcon,
//   }) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.8),
//         borderRadius: BorderRadius.circular(15),
//       ),
//       child: TextFormField(
//         controller: controller,
//         obscureText: obscureText,
//         decoration: InputDecoration(
//           labelText: label,
//           prefixIcon: Icon(icon, color: Colors.purple),
//           suffixIcon: suffixIcon,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(15),
//             borderSide: BorderSide.none,
//           ),
//           filled: true,
//           fillColor: Colors.transparent,
//         ),
//         validator: (value) {
//           if (value == null || value.isEmpty) {
//             return 'Please enter $label';
//           }
//           return null;
//         },
//       ),
//     );
//   }
// }
