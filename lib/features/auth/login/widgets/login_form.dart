import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grace_and_gown_app/common/widgets/app_text_form_field.dart';
import 'package:grace_and_gown_app/features/auth/login/controllers/login_controller.dart';
import 'package:grace_and_gown_app/features/auth/login/widgets/login_footer.dart';
import 'package:grace_and_gown_app/utils/constants/colors.dart';
import 'package:grace_and_gown_app/utils/routes/routes.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 6.h,),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Email',
              textAlign: TextAlign.center,
              style: (Theme.of(context).textTheme.bodyMedium ??
                  const TextStyle())
                  .copyWith(
                color: AppColors.secondary(context),
                fontSize: 15.4.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            AppFormTextField(
              controller: controller.emailController,
              validator: controller.validateEmail,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              hintText: 'Enter your email',
              prefixIcon: Icons.mail,
            ),
            SizedBox(height: 5.sp,),

            Text(
              'Password',
              textAlign: TextAlign.center,
              style: (Theme.of(context).textTheme.bodyMedium ??
                  const TextStyle())
                  .copyWith(
                color: AppColors.secondary(context),
                fontSize: 15.4.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            Obx(
              ()=> AppFormTextField(
                controller: controller.passwordController,
                validator: controller.validatePassword,
                textInputAction: TextInputAction.done,
                hintText: 'Enter your password',
                prefixIcon: Icons.lock,
                obscureText: !controller.isVisible.value,
                suffixIcon: controller.isVisible.value ? Icons.visibility_off : Icons.visibility,
                iconToggle: (){
                  controller.isToggle();
                },
              ),
            ),
            SizedBox(height: 14.sp,),

            InkWell(
              onTap: () => Get.toNamed(Routes.forgotPasswordScreen),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Forgot Password',
                    style: (Theme.of(context).textTheme.headlineLarge ?? const TextStyle())
                        .copyWith(color: AppColors.link(context), fontSize: 14.sp, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            SizedBox(height: 14.h,),

            InkWell(
              onTap: () => controller.login(_formKey),
              child: Container(
                height: 65.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.sageGreen,
                  border: Border.all(color: AppColors.accent(context),),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Center(
                  child: Text(
                    'Login',
                    style: (Theme.of(context).textTheme.headlineLarge ?? const TextStyle())
                        .copyWith(color: AppColors.white, fontSize: 17.sp, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            SizedBox(height: 40.h,),

            LoginFooter(),
          ],
        ),
      ),
    );
  }
}
