
import 'package:appteslo/features/auth/infrastructure/infraestructure.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:appteslo/features/auth/domain/domain.dart';


final authProvider = StateNotifierProvider<AuthProvider, AuthState>((ref) {
  final authRepository = AuthRepositoryImp();
  return AuthProvider(
    authRepository: authRepository
  );
});


class AuthProvider extends StateNotifier<AuthState> {
  final AuthRepository authRepository;

  AuthProvider({
    required this.authRepository
}) : super( AuthState() );

  Future<void> loginUser(String email , String password) async{

    await Future.delayed(const Duration(microseconds: 500));

    try {
      final user = await authRepository.login(
          email , password
      );
      _setLoggerUser(user);
    } on WrongCredencials {
      logout('Credenciales no son correctas ');
    }catch(e){
      logout('Error inesperado');
    }
  }

  void registerUser(String email , String password) async {

  }

  void checkAuthStatus ( String email , String password  ) async {

  }

  void _setLoggerUser( User user ){
    //TODO: necesito guardar el token en el dispositivo fisicamente

    state = state.copyWith(
      user : user ,
      authStatus: AuthStatus.authenticated,
    );
  }

  Future<void> logout( [String? errorMessage ] ) async{
    //TODO limpiar Token
    state = state.copyWith(
      authStatus: AuthStatus.notAuthenticated,
      user : null ,
      errorMessage: errorMessage
    );
  }

}

enum AuthStatus {
  checking,
  authenticated,
  notAuthenticated
}

class AuthState {
  final AuthStatus authStatus;
  final User? user;
  final String errorMessage;

  AuthState({
    this.authStatus = AuthStatus.checking,
    this.user,
    this.errorMessage = ''
  });

  AuthState copyWith({
    AuthStatus? authStatus,
    User? user,
    String? errorMessage
  }) {
    return AuthState(
      authStatus: authStatus ?? this.authStatus,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage
    );
  }
}