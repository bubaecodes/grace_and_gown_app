import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grace_and_gown_app/features/home/controllers/home_controller.dart';
import 'package:grace_and_gown_app/utils/constants/colors.dart';

/// Search field + filter button, sitting between the home header and the promo
/// carousel. Typing filters the grid below; the button opens the sort sheet.
class HomeSearchBar extends StatefulWidget {
  const HomeSearchBar({super.key});

  @override
  State<HomeSearchBar> createState() => _HomeSearchBarState();
}

class _HomeSearchBarState extends State<HomeSearchBar> {
  late final TextEditingController _text;

  /// Local copy of the query so the clear button can appear without rebuilding
  /// the whole field on every keystroke.
  String _typed = '';

  @override
  void initState() {
    super.initState();
    _text = TextEditingController(text: HomeController.instance.query.value);
    _typed = _text.text;
  }

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    HomeController.instance.query.value = value;
    setState(() => _typed = value);
  }

  void _clear() {
    _text.clear();
    _onChanged('');
  }

  @override
  Widget build(BuildContext context) {
    final home = HomeController.instance;

    // `stretch` pins the filter button to the field's exact height, so the two
    // can never drift apart (different font scales, density, etc.).
    //
    // The [IntrinsicHeight] is what makes that legal: this row sits in a
    // Column inside a SingleChildScrollView, so its height constraint is
    // unbounded. Stretching to an unbounded height is a layout error
    // ("BoxConstraints forces an infinite height") that kills the frame and
    // leaves the home screen blank. IntrinsicHeight measures the row first and
    // hands it a real height to stretch to — same trick as [ProductGrid].
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: _SearchField(
            controller: _text,
            showClear: _typed.isNotEmpty,
            onChanged: _onChanged,
            onClear: _clear,
          )),
          SizedBox(width: 10.w),
          _FilterButton(
            highlighted: home.hasSort,
            onTap: () => _openSortSheet(context),
          ),
        ],
      ),
    );
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

class _SearchField extends StatelessWidget {
  const _SearchField({
    required this.controller,
    required this.showClear,
    required this.onChanged,
    required this.onClear,
  });

  final TextEditingController controller;
  final bool showClear;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      textInputAction: TextInputAction.search,
      style: TextStyle(
        fontSize: 15.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.strong(context),
      ),
      cursorColor: AppColors.accent(context),
      decoration: InputDecoration(
        hintText: 'Search by name or category',
        hintStyle: TextStyle(
          fontSize: 13.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.secondary(context),
        ),
        prefixIcon: Icon(
          Icons.search_rounded,
          size: 21.sp,
          color: AppColors.accent(context),
        ),
        suffixIcon: showClear
            ? IconButton(
                onPressed: onClear,
                icon: Icon(
                  Icons.close_rounded,
                  size: 18.sp,
                  color: AppColors.accent(context),
                ),
              )
            : null,
        filled: true,
        fillColor: AppColors.fieldFill(context),
        isDense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(
            width: 0.7.sp,
            color: AppColors.accent(context),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(
            width: 1.7.sp,
            color: AppColors.accent(context),
          ),
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
