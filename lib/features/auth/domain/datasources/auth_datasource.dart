

import 'package:appteslo/features/auth/domain/entities/user.dart';

abstract class AuthDataSourse {
  Future<User> login (String email , String password);
  Future<User> register(String email , String password , String fullName);
  Future<User> checkAuthStatus (String token);
}