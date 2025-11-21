import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ub_t/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:ub_t/core/secrets/app_secrets.dart';
import 'package:ub_t/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:ub_t/features/auth/data/repository/auth_repository_impl.dart';
import 'package:ub_t/features/auth/domain/repository/auth_repository.dart';
import 'package:ub_t/features/auth/domain/usecases/current_user.dart';
import 'package:ub_t/features/auth/domain/usecases/user_login.dart';
import 'package:ub_t/features/auth/domain/usecases/user_signup.dart';
import 'package:ub_t/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ub_t/features/courses/data/datasources/course_remote_data_source.dart';
import 'package:ub_t/features/courses/data/repository/course_repository_impl.dart';
import 'package:ub_t/features/courses/domain/repository/course_repository.dart';
import 'package:ub_t/features/courses/domain/usecases/get_available_courses.dart';
import 'package:ub_t/features/courses/domain/usecases/get_student_courses.dart';
import 'package:ub_t/features/courses/domain/usecases/register_courses.dart';
import 'package:ub_t/features/courses/presentation/bloc/course_bloc.dart';

// Resource feature imports
import 'package:ub_t/features/resources/data/datasources/resource_remote_data_source.dart';
import 'package:ub_t/features/resources/data/repository/resource_repository_impl.dart';
import 'package:ub_t/features/resources/domain/repository/resource_repository.dart';
import 'package:ub_t/features/resources/domain/usecases/get_resources_by_course.dart';
import 'package:ub_t/features/resources/domain/usecases/get_resource_by_id.dart';
import 'package:ub_t/features/resources/presentation/bloc/resource_bloc.dart';

// Payment feature imports
import 'package:ub_t/features/payment/data/datasources/payment_remote_data_source.dart';
import 'package:ub_t/features/payment/data/repository/payment_repository_impl.dart';
import 'package:ub_t/features/payment/domain/repository/payment_repository.dart';
import 'package:ub_t/features/payment/domain/usecases/make_payment.dart';
import 'package:ub_t/features/payment/domain/usecases/is_premium_user.dart';
import 'package:ub_t/features/payment/presentation/bloc/payment_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  await _initHive();
  await _initSupabase();

  _initAuth();
  _initCourses();
  _initResources();
  _initPayment();

  serviceLocator.registerLazySingleton(() => AppUserCubit());
}

void _initPayment() {
  serviceLocator
    ..registerFactory<PaymentRemoteDataSource>(
      () => PaymentRemoteDataSourceImpl(),
    )
    ..registerFactory<PaymentRepository>(
      () => PaymentRepositoryImpl(serviceLocator()),
    )
    ..registerFactory(() => MakePayment(serviceLocator()))
    ..registerFactory(() => IsPremiumUser(serviceLocator()))
    ..registerLazySingleton(
      () => PaymentBloc(
        makePayment: serviceLocator(),
        isPremiumUser: serviceLocator(),
      ),
    );
}

void _initResources() {
  serviceLocator
    ..registerFactory<ResourceRemoteDataSource>(
      () => ResourceRemoteDataSourceImpl(),
    )
    ..registerFactory<ResourceRepository>(
      () => ResourceRepositoryImpl(serviceLocator()),
    )
    ..registerFactory(() => GetResourcesByCourse(serviceLocator()))
    ..registerFactory(() => GetResourceById(serviceLocator()))
    ..registerLazySingleton(
      () => ResourceBloc(
        getResourcesByCourse: serviceLocator(),
        getResourceById: serviceLocator(),
      ),
    );
}

Future<void> _initHive() async {
  // 2. FIX: Only ask for the directory on Mobile (Android/iOS)
  if (!kIsWeb) {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
  }
  // On Web, Hive uses IndexedDB automatically and doesn't need a path.
}

Future<void> _initSupabase() async {
  await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );

  serviceLocator.registerLazySingleton(() => Supabase.instance.client);
}

void _initAuth() {
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(serviceLocator()),
    )
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(serviceLocator()),
    )
    ..registerFactory(() => UserSignUp(serviceLocator()))
    ..registerFactory(() => UserLogin(serviceLocator()))
    ..registerFactory(() => CurrentUser(serviceLocator()))
    ..registerLazySingleton(
      () => AuthBloc(
        userSignUp: serviceLocator(),
        userLogin: serviceLocator(),
        currentUser: serviceLocator(),
        appUserCubit: serviceLocator(),
      ),
    );
}

void _initCourses() {
  serviceLocator
    ..registerFactory<CourseRemoteDataSource>(
      () => CourseRemoteDataSourceImpl(serviceLocator()),
    )
    ..registerFactory<CourseRepository>(
      () => CourseRepositoryImpl(serviceLocator()),
    )
    ..registerFactory(() => GetAvailableCourses(serviceLocator()))
    ..registerFactory(() => GetStudentCourses(serviceLocator()))
    ..registerFactory(() => RegisterCourses(serviceLocator()))
    ..registerLazySingleton(
      () => CourseBloc(
        getAvailableCourses: serviceLocator(),
        getStudentCourses: serviceLocator(),
        registerCourses: serviceLocator(),
      ),
    );
}
