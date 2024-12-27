import 'package:appteslo/features/auth/domain/domain.dart';


class UserMaper {
  static User  userJsonToEntity(Map<String , dynamic > json) => User (
    id: json['id'],
    email: json['email'],
    fullName: json['full_name'],
    token: json['token'],
    roles: List<String>.from(json['role'].map((role)=>role)),
  );
}