

import 'package:appteslo/features/auth/domain/domain.dart';
import '../infraestructure.dart';

class AuthRepositoryImp extends AuthRepository {
  final AuthDataSourse dataSourse;

  AuthRepositoryImp(
      AuthDataSourse ? dataSourse
       ) : dataSourse = dataSourse ?? AuthDataSourceImpl();

  @override
  Future<User> checkAuthStatus(String token) {
    return dataSourse.checkAuthStatus(token);
  }


  @override
  Future<User> login(String email, String password) {
    return dataSourse.login(email, password);
  }

  @override
  Future<User> register(String email, String password, String fullName) {
   return dataSourse.register(email, password, fullName);
  }


}