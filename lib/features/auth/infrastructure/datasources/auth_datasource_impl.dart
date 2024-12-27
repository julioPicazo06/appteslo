
import 'package:appteslo/config/config.dart';
import 'package:appteslo/features/auth/domain/domain.dart';
import 'package:appteslo/features/auth/infrastructure/infraestructure.dart';
import 'package:dio/dio.dart';

class AuthDataSourceImpl  extends AuthDataSourse {

  final dio = Dio(
      BaseOptions(
          baseUrl: Environment.apiUrl
      )
  );

  @override
  Future<User> checkAuthStatus(String token) {
    // TODO: implement checkAuthStatus
    throw UnimplementedError();
  }

  @override
  Future<User> login(String email, String password) async {
    // TODO: implement login
    try {
      final response = await dio.post('/auth/login', data: {
        'email': email,
        'password': password
      });
      final user = UserMaper.userJsonToEntity(response.data);
      return user;
    } catch (e) {
      throw WrongCredencials();
    }
  }

  @override
  Future<User> register(String email, String password, String fullName) {
    // TODO: implement register
    throw UnimplementedError();
  }
}
