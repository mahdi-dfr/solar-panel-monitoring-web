import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:solar_web/features/authentication/data/model/LoginParamsModel.dart';
import 'package:solar_web/features/authentication/domain/entities/user_info_entity.dart';
import 'package:solar_web/features/authentication/domain/usecase/user_info_usecase.dart';

import '../../../../constants/constant.dart';
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
    try {
      final result = await _userInfoUseCase.call(null);

      if (result is DataSuccess && result.data != null) {
        userInfo.value = result.data!;

        final username = userInfo.value?.username;

        if (username != null && username.trim().isNotEmpty) {
          await GetStorage().write(
            AppConstants.userName,
            username,
          );
        } else {
          return DataFailed(
            'نام کاربری از سرور دریافت نشد',
          );
        }

        print('isStaff: ${userInfo.value!.isStaff}');
        print('username: $username');

        return DataSuccess('');
      }

      return DataFailed(
        result.error ?? 'دریافت اطلاعات کاربر ناموفق بود',
      );
    } catch (e) {
      print('getUserInfo error: $e');

      return DataFailed(
        'خطا در دریافت اطلاعات کاربر',
      );
    }
  }



  @override
  void onClose() {
    animationController.dispose();
    usernameController.dispose();
    usernameController.clear();
    passwordController.dispose();
    passwordController.clear();
    super.onClose();
  }

  Future<DataState> login() async {
    isLoading.value = true;

    try {
      final result = await _useCase(
        LoginParamsModel(
          username: usernameController.text.trim(),
          password: passwordController.text,
        ),
      );

      if (result is DataSuccess<AuthEntity>) {
        return DataSuccess('');
      }

      return DataFailed(
        result.error ?? 'ورود ناموفق بود',
      );
    } catch (e) {

      return DataFailed(
        'خطا در ارتباط با سرور',
      );
    }finally{
      isLoading.value = false;
    }
  }
}
