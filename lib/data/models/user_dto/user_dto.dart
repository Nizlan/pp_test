import '../../../domain/entities/user.dart';

class UserDto extends User {
  UserDto({required super.email});

  factory UserDto.fromJson(String json) {
    return UserDto(email: json);
  }

  String toJson() {
    return email;
  }
}
