import 'package:formz/formz.dart';

// define input validators enum

enum EmailError { empty, format  }


// extender formzInput y proveer el tipo de dato y el error
class Email extends FormzInput<String , EmailError>{
    // expresion regular para Email
  static final RegExp emailRegExp = RegExp( r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');


  // revisar si no a sido tocado el input
const Email.pure() : super.pure('');

// revisar que el input fue tocado

const Email.dirty(String value): super.dirty(value);

//  Metodo para validad el input

String? get errorMessage {
  if (isValid || isPure) return null;

  if (displayError == EmailError.empty) return "El campo es requerido";

  if (displayError == EmailError.format) return "No tiene formato de correo electronico";

  return null;
}

@override
  EmailError? validator(String value){

  if(value.isEmpty || value.trim().isEmpty) return EmailError.empty;
  if( !emailRegExp.hasMatch(value) ) return EmailError.format;

}


}