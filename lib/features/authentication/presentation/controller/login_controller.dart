import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solar_web/features/authentication/data/model/LoginParamsModel.dart';
import 'package:solar_web/features/authentication/domain/entities/user_info_entity.dart';
import 'package:solar_web/features/authentication/domain/usecase/user_info_usecase.dart';

import '../../../../constants/data_state.dart';
import '../../domain/entities/auth_entity.dart';
import '../../domain/usecase/login_usecase.dart';

class LoginController extends GetxController with GetSingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<double> fadeAnimation;
  late final Animation<Offset> slideAnimation;

  final LoginUseCase _useCase;
  final UserInfoUseCase _userInfoUseCase;

  LoginController(this._useCase, this._userInfoUseCase);

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  var isLoading = false.obs;

  final Rxn<UserInfoEntity> userInfo = Rxn<UserInfoEntity>();

  @override
  void onInit() {
    super.onInit();

    animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 900));

    fadeAnimation = CurvedAnimation(parent: animationController, curve: Curves.easeInOut);

    slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: animationController, curve: Curves.easeOut));

    animationController.forward();
  }




  Future<DataState<String>> getUserInfo() async {
    final result = await _userInfoUseCase.call(null);
    userInfo.value = result.data!;
    print(userInfo.value!.isStaff);
    return DataSuccess('');
  }



  @override
  void onClose() {
    animationController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  Future<DataState<String>> login() async {
    isLoading.value = true;

    final result = await _useCase(
      LoginParamsModel(username: usernameController.text, password: passwordController.text),
    );

    isLoading.value = false;

    if (result is DataSuccess<AuthEntity>) {
      return DataSuccess('');
    }
    return DataFailed(result.error ?? '');
  }
}
