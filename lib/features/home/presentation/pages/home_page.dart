import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ub_t/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:ub_t/core/common/cubits/app_user/app_user_state.dart';
import 'package:ub_t/core/theme/app_pallete.dart';

class HomePage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const HomePage());
  
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const TimetableTab(),
    const VenuesTab(),
    const ResourcesTab(),
    const ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UB Timetable'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
            },
          ),
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.calendar_today),
            label: 'Timetable',
          ),
          NavigationDestination(
            icon: Icon(Icons.location_on),
            label: 'Venues',
          ),
          NavigationDestination(
            icon: Icon(Icons.book),
            label: 'Resources',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class TimetableTab extends StatelessWidget {
  const TimetableTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.calendar_today,
            size: 64,
            color: AppPallete.primarySkyBlue,
          ),
          const SizedBox(height: 16),
          Text(
            'Your Timetable',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          const Text('No courses registered yet'),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
            },
            icon: const Icon(Icons.add),
            label: const Text('Add Courses'),
          ),
        ],
      ),
    );
  }
}

class VenuesTab extends StatelessWidget {
  const VenuesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.location_on,
            size: 64,
            color: AppPallete.primarySkyBlue,
          ),
          const SizedBox(height: 16),
          Text(
            'Venue Guide',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          const Text('Find your classrooms easily'),
        ],
      ),
    );
  }
}

class ResourcesTab extends StatelessWidget {
  const ResourcesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.book,
            size: 64,
            color: AppPallete.primarySkyBlue,
          ),
          const SizedBox(height: 16),
          Text(
            'Course Resources',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          const Text('Access materials and tutorials'),
        ],
      ),
    );
  }
}

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    final userState = context.watch<AppUserCubit>().state;

    if (userState is! AppUserLoggedIn) {
      return const Center(child: Text('Not logged in'));
    }

    final user = userState.user;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: AppPallete.primarySkyBlue,
                      child: Text(
                        user.matriculeNumber.substring(0, 2),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.matriculeNumber,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Level ${user.level}',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text(
                            user.department,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: user.hasActiveSubscription
                        ? AppPallete.successColor.withOpacity(0.1)
                        : AppPallete.warningColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        user.hasActiveSubscription
                            ? Icons.check_circle
                            : Icons.warning,
                        color: user.hasActiveSubscription
                            ? AppPallete.successColor
                            : AppPallete.warningColor,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        user.hasActiveSubscription
                            ? user.isTrialActive
                                ? 'Free Trial Active'
                                : 'Premium Active'
                            : 'Trial Expired - Upgrade',
                        style: TextStyle(
                          color: user.hasActiveSubscription
                              ? AppPallete.successColor
                              : AppPallete.warningColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('Settings'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {
          },
        ),
        ListTile(
          leading: const Icon(Icons.help),
          title: const Text('Help & Support'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {
          },
        ),
        ListTile(
          leading: const Icon(Icons.info),
          title: const Text('About'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {
          },
        ),
        ListTile(
          leading: const Icon(Icons.logout, color: AppPallete.errorColor),
          title: const Text(
            'Logout',
            style: TextStyle(color: AppPallete.errorColor),
          ),
          onTap: () {
            Navigator.of(context).pushReplacementNamed('/login');
          },
        ),
      ],
    );
  }
}

extension on Color {
  withOpacity(double d) {}
}
