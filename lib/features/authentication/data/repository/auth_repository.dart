import 'package:solar_web/constants/data_state.dart';
import 'package:solar_web/features/authentication/data/mode/auth_model.dart';

abstract class AuthRepository{

  Future<DataState<AuthModel>> loginUser(String username, String password);

}