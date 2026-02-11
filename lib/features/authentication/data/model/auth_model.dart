
import '../../domain/entities/auth_entity.dart';

class AuthModel extends AuthEntity {
  AuthModel({required super.access, required super.refresh});

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
      access: json['access'], refresh: json['refresh']);
}