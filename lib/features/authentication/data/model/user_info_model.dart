import '../../domain/entities/user_info_entity.dart';

class UserInfoModel extends UserInfoEntity {
  const UserInfoModel({
    super.id,
    super.firstName,
    super.lastName,
    super.username,
    super.mobileNumber,
    super.address,
    super.email,
    super.isStaff,
  });

  factory UserInfoModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return UserInfoModel(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      username: json['username'],
      mobileNumber: json['mobile_number'],
      address: json['address'],
      email: json['email'],
      isStaff: json['is_staff'],
    );
  }
}