// import 'package:final_assignment/app/navigator_key/navigator_key.dart';
// import 'package:final_assignment/app/themes/app_theme.dart';
// import 'package:final_assignment/features/splash/presentation/view/splash_view.dart';
// import 'package:flutter/material.dart';
// import 'package:khalti_flutter/khalti_flutter.dart';

// class App extends StatelessWidget {
//   const App({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return KhaltiScope(
//       publicKey: "test_public_key_0800545e039d45368cab4d1b2fb93d01",
//       navigatorKey: AppNavigator.navigatorKey,
//       builder: (context, navigatorKey) {
//         return MaterialApp(
//           debugShowCheckedModeBanner: false,
//           navigatorKey: AppNavigator.navigatorKey,
//           home: const SplashView(),
//           theme: AppTheme.getApplicationTheme(false),
//           supportedLocales: const [
//             Locale('en', 'US'),
//             Locale('ne', 'NP'),
//           ],
//           localizationsDelegates: const [
//             KhaltiLocalizations.delegate,
//           ],
//         );
//       },
//     );
//   }
// }

import 'package:final_assignment/app/navigator_key/navigator_key.dart';
import 'package:final_assignment/app/themes/app_theme.dart';
import 'package:final_assignment/features/gadgets/presentation/view/gadget_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

// Add this provider for theme mode
final themeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.light);

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);

    return KhaltiScope(
      publicKey: "test_public_key_0800545e039d45368cab4d1b2fb93d01",
      navigatorKey: AppNavigator.navigatorKey,
      builder: (context, navigatorKey) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: AppNavigator.navigatorKey,
          home: const GadgetListView(),
          theme: AppTheme.getApplicationTheme(false),
          darkTheme: AppTheme.getApplicationTheme(true), // Add dark theme
          themeMode: themeMode, // Use the theme mode from the provider
          supportedLocales: const [
            Locale('en', 'US'),
            Locale('ne', 'NP'),
          ],
          localizationsDelegates: const [
            KhaltiLocalizations.delegate,
          ],
        );
      },
    );
  }
}
