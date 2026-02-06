import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solar_web/features/authentication/data/model/LoginParamsModel.dart';

import '../../../../constants/data_state.dart';
import '../../../dashboard/view/screens/dashboard_view.dart';
import '../../usecase/entities/auth_entity.dart';
import '../../usecase/usecase/login_usecase.dart';

class LoginController extends GetxController with GetSingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<double> fadeAnimation;
  late final Animation<Offset> slideAnimation;

  final LoginUseCase _useCase;

  LoginController(this._useCase);

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  var isLoading = false.obs;

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
