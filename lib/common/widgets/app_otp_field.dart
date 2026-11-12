import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grace_and_gown_app/utils/constants/colors.dart';


class AppOtpField extends StatelessWidget {
  const AppOtpField({
    super.key,
    required this.controller,
    this.length = 6,
    this.autofocus = false,
  });

  final TextEditingController controller;
  final int length;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56.h,
      child: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0,
              child: TextField(
                controller: controller,
                autofocus: autofocus,
                maxLength: length,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  counterText: '',
                  isCollapsed: true,
                  border: InputBorder.none,
                ),
              ),
            ),
          ),

          /// Visible digit boxes.
          Positioned.fill(
            child: IgnorePointer(
              child: ListenableBuilder(
                listenable: controller,
                builder: (_, _) {
                  final digits = controller.text.split('');
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(length, (index) {
                      final char =
                      index < digits.length ? digits[index] : '';
                      final isActive = index == digits.length;
                      return Container(
                        width: 48.w,
                        height: 56.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.fieldFill(context),
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(
                            width: 0.7.sp,
                            color: isActive
                                ? AppColors.accent(context)
                                : AppColors.accent(context)
                                .withValues(alpha: 0.45),
                          ),
                        ),
                        child: Text(
                          char,
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.strong(context),
                          ),
                        ),
                      );
                    }),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}