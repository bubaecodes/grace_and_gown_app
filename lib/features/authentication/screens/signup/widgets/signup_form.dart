import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grace_and_gown_app/common/widgets/app_text_form_field.dart';
import 'package:grace_and_gown_app/features/authentication/screens/signup/widgets/signup_footer.dart';
import 'package:grace_and_gown_app/utils/constants/colors.dart';
import 'package:grace_and_gown_app/utils/constants/image_strings.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 2.h,),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Full Name',
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
            hintText: 'Enter your full name',
            prefixIcon: Icons.mail,
          ),
          SizedBox(height: 5.sp,),

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
            'Phone Number',
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
            hintText: 'Enter your phone number',
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
          AppFormTextField(
            hintText: 'Create a password',
            prefixIcon: Icons.mail,
          ),
          SizedBox(height: 5.sp,),

          Text(
            'Confirm Password',
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
            hintText: 'Confirm your password',
            prefixIcon: Icons.lock,
          ),
          SizedBox(height: 14.sp,),

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
                  'Sign Up',
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
                  'or sign up with',
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
          SizedBox(height: 20.h,),

          SignupFooter(),
        ],
      ),
    );
  }
}
