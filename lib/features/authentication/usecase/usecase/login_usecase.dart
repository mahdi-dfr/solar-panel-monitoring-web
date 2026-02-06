import 'package:solar_web/constants/usecase.dart';
import 'package:solar_web/features/authentication/usecase/entities/auth_entity.dart';
import 'package:solar_web/features/authentication/usecase/repository/auth_repository.dart';

import '../../../../constants/data_state.dart';
import '../../data/model/LoginParamsModel.dart';

class LoginUseCase extends UseCase<AuthEntity, LoginParamsModel> {
  final AuthRepository _repository;

  LoginUseCase(this._repository);

  @override
  Future<DataState<AuthEntity>> call(LoginParamsModel params) {

    if (params.username.trim().isEmpty) {
      return Future.value(
        DataFailed<AuthEntity>("لطفا نام کاربری را وارد کنید"),
      );
    }

    if (params.password.trim().isEmpty) {
      return Future.value(
        DataFailed<AuthEntity>("لطفا رمز عبور را وارد کنید"),
      );
    }


    return _repository.loginUser(params.username, params.password);
  }
}
