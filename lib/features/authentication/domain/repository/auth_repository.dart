import 'package:solar_web/constants/data_state.dart';
import 'package:solar_web/features/authentication/domain/entities/user_info_entity.dart';

import '../entities/auth_entity.dart';

abstract class AuthRepository{

  Future<DataState<AuthEntity>> loginUser(String username, String password);

  Future<DataState<UserInfoEntity>> getUserInfo();

}