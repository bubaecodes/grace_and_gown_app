import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grace_and_gown_app/common/widgets/app_entrance.dart';
import 'package:grace_and_gown_app/features/auth/login/widgets/login_form.dart';
import 'package:grace_and_gown_app/features/auth/login/widgets/login_header.dart';
import 'package:grace_and_gown_app/utils/constants/colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Login is the entry to the signed-out flow: back here closes the app
    // rather than popping to a dead route (onboarding/splash behind it).
    // Forward navigation is untouched — pushing signup and coming back
    // pops the signup route, not this one.
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) SystemNavigator.pop();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColors.authScaffold(context),
        body: SafeArea(
          // The keyboard shrinks the viewport; let the column scroll
          // instead of overflowing when a field is focused.
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Two-beat entrance: header first, then the form a beat later.
                const AppEntrance(child: LoginHeader()),
                SizedBox(height: 10.h),
                const AppEntrance(
                  delay: Duration(milliseconds: 80),
                  child: LoginForm(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
