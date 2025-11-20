import 'package:supabase_flutter/supabase_flutter.dart' hide AuthException;
import 'package:ub_t/core/error/exceptions.dart';
import 'package:ub_t/features/auth/data/models/user_model.dart';

abstract interface class AuthRemoteDataSource {
  Session? get currentUserSession;
  
  Future<UserModel> signUpWithMatricule({
    required String matriculeNumber,
    required String password,
    required String department,
    required int level,
  });

  Future<UserModel> loginWithMatricule({
    required String matriculeNumber,
    required String password,
  });

  Future<UserModel?> getCurrentUserData();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;

  AuthRemoteDataSourceImpl(this.supabaseClient);

  @override
  Session? get currentUserSession => supabaseClient.auth.currentSession;

  @override
  Future<UserModel> signUpWithMatricule({
    required String matriculeNumber,
    required String password,
    required String department,
    required int level,
  }) async {
    try {
      final email = '${matriculeNumber.toLowerCase()}@ub.edu.cm';
      
      final authResponse = await supabaseClient.auth.signUp(
        email: email,
        password: password,
      );

      if (authResponse.user == null) {
        throw const AuthException('Sign up failed');
      }

      final userId = authResponse.user!.id;
      
      final profileData = {
        'id': userId,
        'matricule': matriculeNumber.toUpperCase(),
        'department': department,
        'level': level,
        'subscription_status': 'trial',
        'trial_start_date': DateTime.now().toIso8601String(),
        'created_at': DateTime.now().toIso8601String(),
      };

      await supabaseClient.from('profiles').insert(profileData);

      return UserModel.fromJson({
        ...profileData,
        'id': userId,
      });
    } on AuthException catch (e) {
      throw AuthException(e.message);
    } catch (e) {
      throw AuthException(e.toString());
    }
  }

  @override
  Future<UserModel> loginWithMatricule({
    required String matriculeNumber,
    required String password,
  }) async {
    try {
      final email = '${matriculeNumber.toLowerCase()}@ub.edu.cm';
      
      final authResponse = await supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (authResponse.user == null) {
        throw const AuthException('Login failed');
      }

      final userData = await getCurrentUserData();
      
      if (userData == null) {
        throw const AuthException('User data not found');
      }

      return userData;
    } on AuthException catch (e) {
      throw AuthException(e.message);
    } catch (e) {
      throw AuthException(e.toString());
    }
  }

  @override
  Future<UserModel?> getCurrentUserData() async {
    try {
      final userId = currentUserSession?.user.id;
      
      if (userId == null) {
        return null;
      }

      final response = await supabaseClient
          .from('profiles')
          .select()
          .eq('id', userId)
          .single();

      return UserModel.fromJson(response);
    } catch (e) {
      return null;
    }
  }
}
