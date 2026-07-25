import 'package:solar_web/features/authentication/domain/entities/user_info_entity.dart';

import '../../../../constants/data_state.dart';
import '../../../../constants/usecase.dart';
import '../repository/auth_repository.dart';

class UserInfoUseCase extends UseCase<UserInfoEntity, void> {
  final AuthRepository _repository;

  UserInfoUseCase(this._repository);

  @override
  Future<DataState<UserInfoEntity>> call(void params) {
    return _repository.getUserInfo();
  }
}