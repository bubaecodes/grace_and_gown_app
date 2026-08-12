import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grace_and_gown_app/features/authentication/screens/login/widgets/login_form.dart';
import 'package:grace_and_gown_app/features/authentication/screens/login/widgets/login_header.dart';
import 'package:grace_and_gown_app/utils/constants/colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.cardBg,
      body: SafeArea(
        child: Column(
          children: [
            LoginHeader(),
            SizedBox(height: 10.h,),
            LoginForm(),
          ],
        ),
      ),
    );
  }
}
