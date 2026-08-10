class UserInfoEntity {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? username;
  final String? mobileNumber;
  final String? address;
  final String? email;
  final bool? isStaff;

  const UserInfoEntity({
    this.id,
    this.firstName,
    this.lastName,
    this.username,
    this.mobileNumber,
    this.address,
    this.email,
    this.isStaff,
  });
}