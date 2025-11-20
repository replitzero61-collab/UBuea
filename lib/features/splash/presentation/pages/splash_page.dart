import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ub_t/core/common/constants/app_constants.dart';
import 'package:ub_t/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:ub_t/core/common/cubits/app_user/app_user_state.dart';
import 'package:ub_t/core/theme/app_pallete.dart';
import 'package:ub_t/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ub_t/features/auth/presentation/bloc/auth_event.dart';

class SplashPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const SplashPage());
  
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkAuthentication();
  }

  Future<void> _checkAuthentication() async {
    await Future.delayed(
      const Duration(seconds: AppConstants.splashDuration),
    );

    if (!mounted) return;

    context.read<AuthBloc>().add(const AuthIsUserLoggedIn());

    await Future.delayed(const Duration(milliseconds: 500));

    if (!mounted) return;

    final userState = context.read<AppUserCubit>().state;

    if (userState is AppUserLoggedIn) {
      Navigator.of(context).pushReplacementNamed('/home');
    } else {
      Navigator.of(context).pushReplacementNamed('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.primarySkyBlue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.school,
              size: 120,
              color: Colors.white,
            ),
            const SizedBox(height: 24),
            Text(
              AppConstants.appName,
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'University of Buea',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.white70,
                  ),
            ),
            const SizedBox(height: 48),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
