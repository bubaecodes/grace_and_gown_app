import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grace_and_gown_app/features/auth/splash/controllers/splash_controller.dart';
import 'package:grace_and_gown_app/utils/constants/colors.dart';
import 'package:grace_and_gown_app/utils/constants/image_strings.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SplashController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.plainScaffold(context),
      body: Center(
        child: ScaleTransition(
          scale: controller.scaleAnimation,
          child: Image.asset(
            AppImages.appLogo,
            width: 0.4.sh,
          ),
        ),
      ),
    );
  }
}
