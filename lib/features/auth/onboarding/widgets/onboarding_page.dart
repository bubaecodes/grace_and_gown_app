import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grace_and_gown_app/utils/constants/colors.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key, required this.image, required this.title, required this.subtitle});

  final String image;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.elevatedSurface(context),
      width: double.infinity,
      height: double.infinity,
      child: Padding(
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

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              child: Column(
                children: [
                  /// header text
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Prata',
                            //fontFamily: 'Bricolage Grotesque',
                            fontSize: 31.sp,
                            letterSpacing: 1.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.heading(context),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 14.h,),

                  /// sub header text
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          subtitle,
                          style: (Theme.of(context).textTheme.bodyMedium ?? const TextStyle())
                              .copyWith(color: AppColors.secondary(context), fontSize: 15.2.sp, fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h,),

                  Row(
                    children: [
                      const Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: AppColors.darkSageGreen,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Icon(
                          Icons.favorite_outline_rounded,
                          color: AppColors.oliveGreen,
                          size: 26.w,
                        ),
                      ),
                      const Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: AppColors.darkSageGreen,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 35.h,),
          ],
        ),
      ),
    );
  }
}