import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grace_and_gown_app/features/authentication/screens/onboarding/widgets/onboarding_dot_navigation.dart';
import 'package:grace_and_gown_app/utils/constants/colors.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key, required this.image, required this.title, required this.subtitle});

  final String image;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    // return Padding(
    //   padding: EdgeInsets.symmetric(horizontal: 4.w),
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: [
    //       /// img
    //       Flexible(
    //         flex: 6,
    //         child: Image.asset(
    //           image,
    //           fit: BoxFit.contain,
    //         ),
    //       ),
    //
    //       /// dots
    //       SizedBox(height: 45.h,),
    //       OnboardingDotNavigation(),
    //       SizedBox(height: 30.h,),
    //
    //       /// header text
    //       Row(
    //         children: [
    //           Expanded(
    //             child: Text(
    //               title,
    //               style: (Theme.of(context).textTheme.headlineLarge ?? const TextStyle())
    //                   .copyWith(color: isDark ? AppColors.homeLightGrey : AppColors.black, fontSize: 32.sp, fontWeight: FontWeight.w600),
    //               textAlign: TextAlign.start,
    //               maxLines: 2,
    //               softWrap: true,
    //             ),
    //           ),
    //         ],
    //       ),
    //       SizedBox(height: 20.h,),
    //
    //       /// sub header text
    //       Row(
    //         children: [
    //           Expanded(
    //             child: Text(
    //               subtitle,
    //               style: (Theme.of(context).textTheme.bodyMedium ?? const TextStyle())
    //                   .copyWith(color: isDark ? AppColors.lightGreyText : AppColors.grey, fontSize: 14.sp, fontWeight: FontWeight.w500),
    //               textAlign: TextAlign.start,
    //               maxLines: 2,
    //               softWrap: true,
    //             ),
    //           ),
    //         ],
    //       ),
    //     ],
    //   ),
    // );

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /// img
          Flexible(
            flex: 4,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.asset(
                image,
                fit: BoxFit.contain,
              ),
            ),
          ),

          /// header text
          Row(
            children: [
              Expanded(
                // child: Text(
                //   title,
                //   textAlign: TextAlign.center,
                //   maxLines: 2,
                //   softWrap: true,
                //   // style: (Theme.of(context).textTheme.headlineLarge ?? const TextStyle())
                //   //     .copyWith(color: AppColors.black, fontSize: 32.sp, fontWeight: FontWeight.w600, fontFamily: 'Bricolage Grotesque'),
                //   // textAlign: TextAlign.center,
                //   // maxLines: 2,
                //   // softWrap: true,
                //   style: TextStyle(
                //     color: AppColors.black,
                //     fontSize: 32.sp,
                //     fontWeight: FontWeight.w600,
                //     fontFamily: 'Bricolage Grotesque',
                //   ),
                // ),

                child: Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Playfair Display',
                    //fontFamily: 'Bricolage Grotesque',
                    fontSize: 31.sp,
                    letterSpacing: 1.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryGreen,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h,),

          /// sub header text
          Row(
            children: [
              Expanded(
                child: Text(
                  subtitle,
                  style: (Theme.of(context).textTheme.bodyMedium ?? const TextStyle())
                      .copyWith(color: AppColors.grey, fontSize: 14.sp, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  softWrap: true,
                ),
              ),
            ],
          ),
          SizedBox(height: 30.h,),

          /// dots
          SizedBox(height: 45.h,),
          OnboardingDotNavigation(),
        ],
      ),
    );
  }
}