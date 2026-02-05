class AuthModel {
  String? access;
  String? refresh;

  AuthModel({required this.access, required this.refresh});

  AuthModel.fromJson(Map<String, dynamic> json){
    access = json['access'];
    refresh = json['refresh'];
  }
}