import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grace_and_gown_app/common/widgets/app_text_form_field.dart';
import 'package:grace_and_gown_app/features/authentication/controllers/login/login_controller.dart';
import 'package:grace_and_gown_app/features/authentication/screens/login/widgets/login_footer.dart';
import 'package:grace_and_gown_app/utils/constants/colors.dart';
import 'package:grace_and_gown_app/utils/constants/image_strings.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 6.h,),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Email',
            textAlign: TextAlign.center,
            style: (Theme.of(context).textTheme.bodyMedium ??
                const TextStyle())
                .copyWith(
              color: AppColors.grey,
              fontSize: 15.4.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          AppFormTextField(
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
              color: AppColors.grey,
              fontSize: 15.4.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          Obx(
            ()=> AppFormTextField(
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Forgot Password',
                  style: (Theme.of(context).textTheme.headlineLarge ?? const TextStyle())
                      .copyWith(color: AppColors.darkGreen, fontSize: 14.sp, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          SizedBox(height: 14.h,),

          InkWell(
            //onTap: ()=> Get.to(()=> BottomNavMenu()),
            child: Container(
              height: 65.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.sageGreen,
                border: Border.all(color: AppColors.primaryGreen,),
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
          SizedBox(height: 14.h,),

          Row(
            children: [
              Expanded(child: Divider(thickness: 1, color: AppColors.grey)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  'or',
                  style:
                  (Theme.of(context).textTheme.bodySmall ??
                      const TextStyle())
                      .copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Expanded(child: Divider(thickness: 1, color: AppColors.grey)),
            ],
          ),
          SizedBox(height: 14.h,),

          Row(
            children: [
              Expanded(
                child: Container(
                  height: 47.h,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.oliveGreen, width: 0.5.h),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(AppImages.googleIcon, width: 20.sp, height: 20.sp,),
                      SizedBox(width: 8.w,),
                      Text(
                        'Continue with Google',
                        style: (Theme.of(context).textTheme.headlineLarge ?? const TextStyle())
                            .copyWith(color: AppColors.primaryGreen, fontSize: 14.5.sp, fontWeight: FontWeight.w700),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 8.w,),
              Expanded(
                child: Container(
                  height: 47.h,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.oliveGreen, width: 0.5.h),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppImages.appleIcon,
                        width: 21.sp,
                        height: 21.sp,
                        color: Colors.black,
                      ),
                      SizedBox(width: 8.w,),
                      Text(
                        'Continue with Apple',
                        style: (Theme.of(context).textTheme.headlineLarge ?? const TextStyle())
                            .copyWith(color: AppColors.primaryGreen, fontSize: 14.5.sp, fontWeight: FontWeight.w700),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 40.h,),

          LoginFooter(),
        ],
      ),
    );
  }
}
