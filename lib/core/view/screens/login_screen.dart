import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solar_web/constants/app_colors.dart';
import 'package:solar_web/constants/constant.dart';
import 'package:solar_web/core/contrroller/login_controller.dart';

class SolarLoginPage extends GetView<LoginController> {
  const SolarLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = context.width;
    final height = context.height;
    final isWide = width > 900;

    return Scaffold(
      body: Stack(
        children: [
          Image.asset(AppConstants.loginBackground, fit: BoxFit.fill, height: height, width: width),

          Center(
            child: FadeTransition(
              opacity: controller.fadeAnimation,
              child: SlideTransition(
                position: controller.slideAnimation,
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 420),
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.all(32),
                  decoration: _cardDecoration(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 24),
                      const Text(
                        'مانیتورینگ پنل های خورشیدی',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1B5E20)),
                      ),
                      const SizedBox(height: 24),
                      _InputField(
                        controller: controller.usernameController,
                        label: 'نام کاربری',
                        icon: Icons.person_outline,
                      ),
                      const SizedBox(height: 16),
                      _InputField(
                        controller: controller.passwordController,
                        label: 'رمز عبور',
                        icon: Icons.lock_outline,
                        obscure: true,
                      ),
                      const SizedBox(height: 28),
                      _LoginButton(onTap: controller.login),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration _cardDecoration() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(20),
    boxShadow: [
      BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 25, offset: const Offset(0, 10)),
    ],
  );
}

class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final bool obscure;

  const _InputField({
    required this.controller,
    required this.label,
    required this.icon,
    this.obscure = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: const Color(0xFF2E7D32)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFF2E7D32), width: 2),
        ),
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  final VoidCallback onTap;

  const _LoginButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2E7D32),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          elevation: 6,
        ),
        child: Text(
          'ورود',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: CustomAppColors.backgroundColor),
        ),
      ),
    );
  }
}
