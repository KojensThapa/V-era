import 'dart:io';
import 'package:v_era/data/data_sources/auth_data_source.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class AuthRepository {
  Future<dynamic> login(String email, String password, bool rememberMe);
  Future<dynamic> signup({
    required String name,
    required String email,
    required String phone,
    required String password,
    File? profileImage,
    bool agreeToTerms,
  });
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource _authDataSource;

  AuthRepositoryImpl(this._authDataSource);

  @override
  Future<dynamic> login(String email, String password, bool rememberMe) async {
    return await _authDataSource.login(email, password, rememberMe);
  }

  @override
  Future<dynamic> signup({
    required String name,
    required String email,
    required String phone,
    required String password,
    File? profileImage,
    bool agreeToTerms = true,
  }) async {
    return await _authDataSource.signup(
      name: name,
      email: email,
      phone: phone,
      password: password,
      profileImage: profileImage,
      agreeToTerms: agreeToTerms,
    );
  }
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final authDataSource = ref.watch(authDataSourceProvider);
  return AuthRepositoryImpl(authDataSource);
});