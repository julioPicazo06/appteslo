import 'package:formz/formz.dart';


enum PasswordError { empty, format  , length }

class Password extends FormzInput <String , PasswordError> {

    static final RegExp passwordRegExp = RegExp(
      r'(?:(?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$',
    );

  const Password.pure() : super.pure('');

  const Password.dirty(String value) : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == PasswordError.empty) return "El campo es requerido";

    if (displayError == PasswordError.format) return "La contraseña debe contener al menos una letra mayúscula, una letra minúscula y un número";

    if (displayError == PasswordError.length) return "La contraseña debe tener al menos 8 caracteres";

    return null;
  }

  @override

  PasswordError? validator(String value){
    if(value.isEmpty || value.trim().isEmpty) return PasswordError.empty;
    if(value.length < 8) return PasswordError.length;
    if( !passwordRegExp.hasMatch(value) ) return PasswordError.format;
    return null;
  }


}