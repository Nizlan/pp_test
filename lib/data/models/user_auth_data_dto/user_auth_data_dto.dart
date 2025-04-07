import 'dart:convert';

import 'package:pp_test/domain/entities/user_auth_data.dart';

class UserAuthDataDto extends UserAuthData {
  UserAuthDataDto({required super.email, required super.password});

  String toJson() {
    return jsonEncode({'email': email, 'password': password});
  }

  static UserAuthDataDto fromJson(String json) {
    final Map<String, dynamic> data = jsonDecode(json);
    return UserAuthDataDto(email: data['email'], password: data['password']);
  }
}
