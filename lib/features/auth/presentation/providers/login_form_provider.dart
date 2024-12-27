import 'package:appteslo/features/auth/presentation/providers/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:appteslo/features/shared/shared.dart';
import 'package:formz/formz.dart';

class LoginFormState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final Email email;
  final Password password;

  LoginFormState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.email = const Email.pure(),
    this.password = const Password.pure(),
  });

  LoginFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    Email? email,
    Password? password,
  }) =>
     LoginFormState(
      isPosting: isPosting ?? this.isPosting,
      isFormPosted: isFormPosted ?? this.isFormPosted,
      isValid: isValid ?? this.isValid,
      email: email ?? this.email,
      password: password ?? this.password,
    );


  @override
  String toString() {
    return '''
         LoginFormState:
            isPosting: $isPosting,
            isFormPosted: $isFormPosted,
            isValid: $isValid,
            email: $email,
            password: $password,
''';
  }
}


// Todo stateNotifier para el snippet
class LoginFormNotifier extends StateNotifier<LoginFormState> {
  final Function (String , String) loginUserCallBack;

  LoginFormNotifier({
    required this.loginUserCallBack
}) : super(  LoginFormState()  );

  onEmailChange ( String value ) {
    final newEmail = Email.dirty(value);
    state = state.copyWith(
      email : newEmail,
      isValid : Formz.validate([ newEmail , state.password ])
    );
  }

  onPasswordChange ( String value ) {
    final newPassword = Password.dirty(value);
    state = state.copyWith(
      password : newPassword,
      isValid : Formz.validate([ state.email , newPassword ])
    );
  }

  onFormSubmit () async {
    _touchEveryField();

    if ( !state.isValid ) return;

    await loginUserCallBack( state.email.value , state.password.value );
  }

  _touchEveryField (){
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);

    state = state.copyWith(
      isFormPosted:true,
      email: email,
      password: password,
      isValid: Formz.validate([email, password])
    );
  }


}

final LoginFormProvider = StateNotifierProvider.autoDispose<LoginFormNotifier, LoginFormState>((ref) {
final loginUserCallBack = ref.watch(authProvider.notifier).loginUser;

return LoginFormNotifier(
loginUserCallBack: loginUserCallBack
);
});