import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ub_t/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:ub_t/core/theme/theme.dart';
import 'package:ub_t/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ub_t/features/auth/presentation/pages/login_page.dart';
import 'package:ub_t/features/courses/presentation/bloc/course_bloc.dart';
import 'package:ub_t/features/courses/presentation/pages/course_selection_page.dart';
import 'package:ub_t/features/home/presentation/pages/home_page.dart';
import 'package:ub_t/features/resources/presentation/bloc/resource_bloc.dart';
import 'package:ub_t/features/resources/presentation/pages/resource_detail_page.dart';
import 'package:ub_t/features/splash/presentation/pages/splash_page.dart';
import 'package:ub_t/init_dependencies.dart';

import 'package:ub_t/features/resources/presentation/pages/resources_page.dart';

import 'package:ub_t/features/payment/presentation/bloc/payment_bloc.dart';
import 'package:ub_t/features/payment/presentation/pages/payment_page.dart';
import 'package:ub_t/features/payment/presentation/pages/paywall_page.dart';
import 'package:ub_t/features/payment/presentation/pages/payment_success_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => serviceLocator<AppUserCubit>()),
        BlocProvider(create: (_) => serviceLocator<AuthBloc>()),
        BlocProvider(create: (_) => serviceLocator<CourseBloc>()),
        BlocProvider(create: (_) => serviceLocator<ResourceBloc>()),
        BlocProvider(create: (_) => serviceLocator<PaymentBloc>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UB Timetable',
      theme: AppTheme.lightTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashPage(),
        '/login': (context) => const LoginPage(),
        '/course-selection': (context) => const CourseSelectionPage(),
        '/home': (context) => const HomePage(),
        '/resources': (context) => const ResourcesPage(),
        '/resource-detail': (context) {
          final id = ModalRoute.of(context)!.settings.arguments as String;
          return ResourceDetailPage(resourceId: id);
        },
        '/payment': (context) => const PaymentPage(),
        '/paywall': (context) => const PaywallPage(),
        '/payment-success': (context) => const PaymentSuccessPage(),
      },
    );
  }
}
