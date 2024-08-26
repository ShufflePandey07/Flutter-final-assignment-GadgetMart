import 'package:final_assignment/features/favourites/presentation/view/favourites_view.dart';
import 'package:final_assignment/features/orders/presentation/view/order_view.dart';
import 'package:final_assignment/features/settings/presentation/viewmodel/current_user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final themeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.light);

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => ref.read(currentUserViewModelProvider.notifier).initialize());
  }

  String _getGreeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUserState = ref.watch(currentUserViewModelProvider);
    final themeMode = ref.watch(themeProvider);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).primaryColor.withOpacity(0.8),
                    ],
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.person,
                          size: 60,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        _getGreeting(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 5),
                      currentUserState.isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text(
                              currentUserState.authEntity?.fullName ??
                                  'No Name',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              const SizedBox(height: 20),
              _buildSettingsSection(context),
              const SizedBox(height: 20),
              _buildDangerZone(context),
              const SizedBox(height: 40),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            'Settings',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Column(
            children: [
              ProfileMenuItem(
                icon: FontAwesomeIcons.paintbrush,
                text: 'Theme Mode',
                onTap: () => _showModeSelectionDialog(context),
              ),
              const Divider(height: 1),
              ProfileMenuItem(
                icon: FontAwesomeIcons.heart,
                text: 'Favorites',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FavouritesView(),
                    ),
                  );
                },
              ),
              const Divider(height: 1),
              ProfileMenuItem(
                icon: FontAwesomeIcons.heart,
                text: 'My Orders',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OrderView(),
                    ),
                  );
                },
              ),
              const Divider(height: 1),
              ProfileMenuItem(
                icon: FontAwesomeIcons.fingerprint,
                text: 'Enable Fingerprint',
                onTap: () {
                  ref
                      .read(currentUserViewModelProvider.notifier)
                      .enableFingerprint();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDangerZone(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            'Danger Zone',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
          ),
        ),
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Column(
            children: [
              ProfileMenuItem(
                icon: FontAwesomeIcons.userSlash,
                text: 'Delete Account',
                onTap: () {
                  // Implement delete account functionality
                },
                textColor: Colors.red,
              ),
              const Divider(height: 1),
              ProfileMenuItem(
                icon: FontAwesomeIcons.rightFromBracket,
                text: 'Logout',
                onTap: () {
                  ref.read(currentUserViewModelProvider.notifier).logout();
                },
                textColor: Colors.red,
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showModeSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Theme'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Light Mode'),
                leading: const Icon(FontAwesomeIcons.sun),
                onTap: () {
                  ref.read(themeProvider.notifier).state = ThemeMode.light;
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: const Text('Dark Mode'),
                leading: const Icon(FontAwesomeIcons.moon),
                onTap: () {
                  ref.read(themeProvider.notifier).state = ThemeMode.dark;
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;
  final Color? textColor;

  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: FaIcon(icon, color: Theme.of(context).primaryColor, size: 20),
      title: Text(
        text,
        style: TextStyle(
          color: textColor ?? Theme.of(context).textTheme.bodyLarge?.color,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing:
          Icon(Icons.chevron_right, color: Theme.of(context).primaryColor),
      onTap: onTap,
    );
  }
}
