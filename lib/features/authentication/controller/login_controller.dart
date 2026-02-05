import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/data_state.dart';
import '../../dashboard/view/screens/dashboard_view.dart';
import '../data/repository/auth_repository.dart';

class LoginController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<double> fadeAnimation;
  late final Animation<Offset> slideAnimation;

  final AuthRepository _repository;

  LoginController(this._repository);

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    fadeAnimation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    );

    slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeOut,
      ),
    );

    animationController.forward();
  }

  @override
  void onClose() {
    animationController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  Future<void> login() async {
    isLoading.value = true;
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    if (username.isNotEmpty && password.isNotEmpty) {

      DataState dataState = await _repository.loginUser(username, password);
      if(dataState is DataSuccess){
        Get.offAll(DashboardPage());
        isLoading.value = false;
      }else{
        isLoading.value = false;
        Get.snackbar(
          'خطا',
          'مشکلی پیش آمده است',
          snackPosition: SnackPosition.TOP,
        );
      }

    }else{
      isLoading.value = false;
      Get.snackbar(
        'خطا',
        'لطفا نام کاربری و رمز عبور را وارد کنید',
        snackPosition: SnackPosition.TOP,
      );
    }


  }
}
