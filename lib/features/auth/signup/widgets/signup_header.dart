// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:grace_and_gown_app/utils/constants/colors.dart';
// import 'package:grace_and_gown_app/utils/constants/image_strings.dart';
//
// class LoginHeader extends StatelessWidget {
//   const LoginHeader({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Row(
//           children: [
//             Expanded(
//               child: Column(
//                 children: [
//                   Image.asset(
//                     AppImages.appLogo3,
//                     width: 120.w,
//                     fit: BoxFit.contain,
//                   ),
//                   Text(
//                     'GOWN & GRACE',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontFamily: 'Prata',
//                       fontSize: 25.sp,
//                       letterSpacing: 1.sp,
//                       fontWeight: FontWeight.w500,
//                       color: AppColors.primaryGreen,
//                     ),
//                   ),
//                   SizedBox(height: 2.sp,),
//                   Text(
//                     'Rent your dream',
//                     style: (Theme.of(context).textTheme.bodyMedium ?? const TextStyle())
//                         .copyWith(color: AppColors.grey, fontSize: 15.4.sp, fontWeight: FontWeight.w500),
//                     textAlign: TextAlign.center,
//                     softWrap: true,
//                   ),
//                   SizedBox(height: 5.sp,),
//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 14.w),
//                     child: Row(
//                       children: [
//                         const Expanded(
//                           child: Divider(
//                             thickness: 0.34,
//                             color: AppColors.darkSageGreen,
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 10.w),
//                           child: Icon(
//                             Icons.favorite_outline_rounded,
//                             color: AppColors.oliveGreen,
//                             size: 24.w,
//                           ),
//                         ),
//                         const Expanded(
//                           child: Divider(
//                             thickness: 0.34,
//                             color: AppColors.darkSageGreen,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               width: 200.w,
//               height: 250.h,
//               child: Image.asset(
//                 AppImages.loginHeaderImg,
//                 fit: BoxFit.contain,
//               ),
//             ),
//           ],
//         ),
//         SizedBox(height: 8.h,),
//
//         Column(
//           children: [
//             Text(
//               'Welcome Back',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontFamily: 'Prata',
//                 fontSize: 30.sp,
//                 letterSpacing: 1.sp,
//                 fontWeight: FontWeight.w500,
//                 color: AppColors.primaryGreen,
//               ),
//             ),
//             SizedBox(height: 4.sp,),
//             Text(
//               'Login to find your perfect gown',
//               style: (Theme.of(context).textTheme.bodyMedium ?? const TextStyle())
//                   .copyWith(color: AppColors.grey, fontSize: 15.4.sp, fontWeight: FontWeight.w500),
//               textAlign: TextAlign.center,
//               softWrap: true,
//             ),
//           ],
//         )
//       ],
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grace_and_gown_app/utils/constants/colors.dart';
import 'package:grace_and_gown_app/utils/constants/image_strings.dart';

class SignupHeader extends StatelessWidget {
  const SignupHeader({super.key});

  @override
  Widget build(BuildContext context) {
    // return Column(
    //   children: [
    //     Row(
    //       crossAxisAlignment: CrossAxisAlignment.center,
    //       children: [
    //         Expanded(
    //           flex: 3,
    //           child: ShaderMask(
    //             shaderCallback: (Rect bounds) {
    //               return const LinearGradient(
    //                 begin: Alignment.centerLeft,
    //                 end: Alignment.centerRight,
    //                 colors: [
    //                   Colors.black,
    //                   Colors.black,
    //                   Colors.black87,
    //                   Colors.black54,
    //                   Colors.black26,
    //                   Colors.transparent,
    //                 ],
    //                 stops: [
    //                   0.0,
    //                   0.45,
    //                   0.60,
    //                   0.75,
    //                   0.90,
    //                   1.0,
    //                 ],
    //               ).createShader(bounds);
    //             },
    //             blendMode: BlendMode.dstIn,
    //             child: Column(
    //               children: [
    //                 Image.asset(
    //                   AppImages.appLogo3,
    //                   width: 120.w,
    //                   fit: BoxFit.contain,
    //                 ),
    //                 Text(
    //                   'GOWN & GRACE',
    //                   textAlign: TextAlign.center,
    //                   style: TextStyle(
    //                     fontFamily: 'Prata',
    //                     fontSize: 25.sp,
    //                     letterSpacing: 1.sp,
    //                     fontWeight: FontWeight.w500,
    //                     color: AppColors.primaryGreen,
    //                   ),
    //                 ),
    //                 SizedBox(height: 2.h),
    //                 Text(
    //                   'Rent your dream',
    //                   textAlign: TextAlign.center,
    //                   style: (Theme.of(context).textTheme.bodyMedium ??
    //                       const TextStyle())
    //                       .copyWith(
    //                     color: AppColors.grey,
    //                     fontSize: 15.4.sp,
    //                     fontWeight: FontWeight.w500,
    //                   ),
    //                 ),
    //                 SizedBox(height: 5.h),
    //                 Padding(
    //                   padding: EdgeInsets.symmetric(horizontal: 14.w),
    //                   child: Row(
    //                     children: [
    //                       const Expanded(
    //                         child: Divider(
    //                           thickness: 0.34,
    //                           color: AppColors.darkSageGreen,
    //                         ),
    //                       ),
    //                       Padding(
    //                         padding:
    //                         EdgeInsets.symmetric(horizontal: 10.w),
    //                         child: Icon(
    //                           Icons.favorite_outline_rounded,
    //                           color: AppColors.oliveGreen,
    //                           size: 24.w,
    //                         ),
    //                       ),
    //                       const Expanded(
    //                         child: Divider(
    //                           thickness: 0.34,
    //                           color: AppColors.darkSageGreen,
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ),
    //         SizedBox(width: 8.w),
    //
    //         ShaderMask(
    //           blendMode: BlendMode.dstIn,
    //           shaderCallback: (bounds) => const LinearGradient(
    //             begin: Alignment.centerLeft,
    //             end: Alignment.centerRight,
    //             colors: [
    //               Colors.black,
    //               Colors.black,
    //               Colors.black87,
    //               Colors.transparent,
    //             ],
    //             stops: [
    //               0.0,
    //               0.80,
    //               0.95,
    //               1.0,
    //             ],
    //           ).createShader(bounds),
    //           child: ShaderMask(
    //             blendMode: BlendMode.dstIn,
    //             shaderCallback: (bounds) => const LinearGradient(
    //               begin: Alignment.topCenter,
    //               end: Alignment.bottomCenter,
    //               colors: [
    //                 Colors.black,
    //                 Colors.black,
    //                 Colors.black54,
    //                 Colors.transparent,
    //               ],
    //               stops: [
    //                 0.0,
    //                 0.70,
    //                 0.88,
    //                 1.0,
    //               ],
    //             ).createShader(bounds),
    //             child: SizedBox(
    //               width: 190.w,
    //               height: 240.h,
    //               child: Image.asset(
    //                 AppImages.loginHeaderImg2,
    //                 fit: BoxFit.contain,
    //               ),
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //
    //     SizedBox(height: 12.h),
    //
    //     Column(
    //       children: [
    //         Text(
    //           'Create Your Account',
    //           textAlign: TextAlign.center,
    //           style: TextStyle(
    //             fontFamily: 'Prata',
    //             fontSize: 30.sp,
    //             letterSpacing: 1.sp,
    //             fontWeight: FontWeight.w500,
    //             color: AppColors.primaryGreen,
    //           ),
    //         ),
    //         SizedBox(height: 2.h),
    //         Text(
    //           'Sign up to get started',
    //           textAlign: TextAlign.center,
    //           style: (Theme.of(context).textTheme.bodyMedium ??
    //               const TextStyle())
    //               .copyWith(
    //             color: AppColors.grey,
    //             fontSize: 15.4.sp,
    //             fontWeight: FontWeight.w500,
    //           ),
    //         ),
    //       ],
    //     ),
    //   ],
    // );

    return Column(
      children: [
        Image.asset(
          AppImages.appLogo3,
          width: 80.w,
          fit: BoxFit.contain,
        ),
        Text(
          'GOWN & GRACE',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Prata',
            fontSize: 22.sp,
            letterSpacing: 1.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.primaryGreen,
          ),
        ),
        SizedBox(height: 4.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 28.w),
          child: Row(
            children: [
              const Expanded(
                child: Divider(
                  thickness: 0.34,
                  color: AppColors.darkSageGreen,
                ),
              ),
              Padding(
                padding:
                EdgeInsets.symmetric(horizontal: 10.w),
                child: Icon(
                  Icons.favorite_outline_rounded,
                  color: AppColors.oliveGreen,
                  size: 24.w,
                ),
              ),
              const Expanded(
                child: Divider(
                  thickness: 0.34,
                  color: AppColors.darkSageGreen,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}