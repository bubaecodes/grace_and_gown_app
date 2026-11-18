import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grace_and_gown_app/features/home/controllers/home_controller.dart';
import 'package:grace_and_gown_app/utils/constants/colors.dart';
import 'package:grace_and_gown_app/utils/routes/routes.dart';

/// Search field + filter button, sitting between the home header and the promo
/// carousel.
///
/// The field is a read-only tap target: tapping it pushes the full Search
/// screen (focused input, recent searches, live results). It still displays
/// the shared [HomeController.query], so a search made on the Search screen
/// is visible here — and the X clears it, dropping the grid back to the full
/// catalogue. The button opens the sort sheet.
class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    // One Obx around the whole row: the field text and the filter button's
    // sort dot both read reactive state, so both rebuild together.
    return Obx(() {
      final home = HomeController.instance;
      final typed = home.query.value;

      // `stretch` pins the filter button to the field's exact height, so the
      // two can never drift apart (different font scales, density, etc.).
      //
      // The [IntrinsicHeight] is what makes that legal: this row sits in a
      // Column inside a SingleChildScrollView, so its height constraint is
      // unbounded. Stretching to an unbounded height is a layout error
      // ("BoxConstraints forces an infinite height") that kills the frame and
      // leaves the home screen blank. IntrinsicHeight measures the row first
      // and hands it a real height to stretch to — same trick as [ProductGrid].
      return IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: _SearchField(
                text: typed,
                showClear: typed.isNotEmpty,
                onClear: () => home.query.value = '',
                onTap: () => Get.toNamed(Routes.searchScreen),
              ),
            ),
            SizedBox(width: 10.w),
            _FilterButton(
              highlighted: home.hasSort,
              onTap: () => _openSortSheet(context),
            ),
          ],
        ),
      );
    });
  }

  /// Sort options — applies on tap and closes.
  Future<void> _openSortSheet(BuildContext context) {
    final home = HomeController.instance;

    return showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.elevatedSurface(context),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22.r)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(18.w, 10.h, 18.w, 16.h),
            child: Obx(
              () => Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40.w,
                      height: 4.h,
                      decoration: BoxDecoration(
                        color:
                            AppColors.secondary(context).withValues(alpha: 0.4),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Sort by',
                    style: TextStyle(
                      fontFamily: 'Prata',
                      fontSize: 18.sp,
                      letterSpacing: 0.6.sp,
                      color: AppColors.heading(context),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  for (final option in HomeSort.values)
                    InkWell(
                      onTap: () {
                        home.sort.value = option;
                        Navigator.of(sheetContext).pop();
                      },
                      borderRadius: BorderRadius.circular(12.r),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 13.h,
                          horizontal: 4.w,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                option.label,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: home.sort.value == option
                                      ? FontWeight.w700
                                      : FontWeight.w500,
                                  color: home.sort.value == option
                                      ? AppColors.accentText(context)
                                      : AppColors.strong(context),
                                ),
                              ),
                            ),
                            if (home.sort.value == option)
                              Icon(
                                Icons.check_rounded,
                                size: 20.sp,
                                color: AppColors.accentText(context),
                              ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

/// The field itself — styled exactly like the old TextField but read-only:
/// it renders the shared query (or the hint) and forwards taps to the Search
/// screen. The X is a nested tap target that clears the query without also
/// navigating (the inner InkWell wins the gesture arena).
class _SearchField extends StatelessWidget {
  const _SearchField({
    required this.text,
    required this.showClear,
    required this.onClear,
    required this.onTap,
  });

  final String text;
  final bool showClear;
  final VoidCallback onClear;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final hasText = text.isNotEmpty;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: AppColors.fieldFill(context),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            width: 0.7.sp,
            color: AppColors.accent(context),
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.search_rounded,
              size: 21.sp,
              color: AppColors.accent(context),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                // Keep this exact string — it doubles as the test finder.
                hasText ? text : 'Search by name or category',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: hasText
                    ? TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.strong(context),
                      )
                    : TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.secondary(context),
                      ),
              ),
            ),
            if (showClear)
              InkWell(
                onTap: onClear,
                customBorder: const CircleBorder(),
                child: Padding(
                  padding: EdgeInsets.all(4.w),
                  child: Icon(
                    Icons.close_rounded,
                    size: 18.sp,
                    color: AppColors.accent(context),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _FilterButton extends StatelessWidget {
  const _FilterButton({required this.highlighted, required this.onTap});

  /// Lights the dot when a non-default sort is active.
  final bool highlighted;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        // Vertical padding is dropped on purpose: the row stretches this box to
        // the search field's height, and [Center] keeps the icon in the middle.
        padding: EdgeInsets.symmetric(horizontal: 13.w),
        decoration: BoxDecoration(
          color: AppColors.fieldFill(context),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            width: 0.7.sp,
            color: AppColors.accent(context),
          ),
        ),
        child: Center(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Icon(
                Icons.tune_rounded,
                size: 22.sp,
                color: AppColors.accent(context),
              ),
              if (highlighted)
                Positioned(
                  right: -1.w,
                  top: -1.h,
                  child: Container(
                    width: 8.sp,
                    height: 8.sp,
                    decoration: BoxDecoration(
                      color: AppColors.success,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
