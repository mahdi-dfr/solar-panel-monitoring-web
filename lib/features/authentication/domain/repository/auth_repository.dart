import 'package:solar_web/constants/data_state.dart';

import '../entities/auth_entity.dart';

abstract class AuthRepository{

  Future<DataState<AuthEntity>> loginUser(String username, String password);

}