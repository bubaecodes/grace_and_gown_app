import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grace_and_gown_app/common/widgets/app_state_views.dart';
import 'package:grace_and_gown_app/features/home/controllers/home_controller.dart';
import 'package:grace_and_gown_app/features/home/widgets/product_grid.dart';
import 'package:grace_and_gown_app/features/search/controllers/search_screen_controller.dart';
import 'package:grace_and_gown_app/utils/constants/colors.dart';

/// Full-screen search — pushed by tapping the field on Home.
///
/// Typing drives the shared [HomeController.query], so results come from the
/// exact same filter the home grid uses and stay consistent when you pop back
/// (the home field shows whatever you typed here). An empty query shows the
/// recent searches; committing a query — keyboard action or tapping a result
/// — files it at the top of the recents.
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final TextEditingController _text;
  late final HomeController _home;

  @override
  void initState() {
    super.initState();
    // Registered here too so the screen works even when pumped on its own
    // (Get.put returns the live instance once Home has created it).
    _home = Get.put(HomeController());
    Get.put(SearchScreenController());
    // Seed the field from the shared query — re-opening search after a
    // previous visit shows the query (and its results) exactly as left.
    _text = TextEditingController(text: _home.query.value);
  }

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    _home.query.value = value;
    // Rebuild so the clear button appears/disappears with the text.
    setState(() {});
  }

  void _clear() {
    _text.clear();
    _onChanged('');
  }

  /// Files the query in the recents and lets the keyboard action finish.
  void _commit(String value) {
    SearchScreenController.instance.addRecent(value);
  }

  /// Applying a recent query: fill the field, drive the shared filter, and
  /// move the query to the top of the recents.
  void _applyRecent(String query) {
    _text.text = query;
    _home.query.value = query;
    SearchScreenController.instance.addRecent(query);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.authScaffold(context),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(18.w, 12.h, 18.w, 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () => Get.back(),
                    customBorder: const CircleBorder(),
                    child: Padding(
                      padding: EdgeInsets.all(6.w),
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 18.sp,
                        color: AppColors.strong(context),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(child: _field(context)),
                ],
              ),
              SizedBox(height: 18.h),
              Expanded(
                child: Obx(() => _results(context)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// The live input — same styling as the home field, but focusable.
  Widget _field(BuildContext context) {
    final hasText = _text.text.isNotEmpty;

    return TextField(
      controller: _text,
      autofocus: true,
      onChanged: _onChanged,
      onSubmitted: _commit,
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
        suffixIcon: hasText
            ? IconButton(
                onPressed: _clear,
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

  /// Switches on the shared query: recents when empty, live results
  /// otherwise. One [Obx] so the count, the grid and the recents all follow
  /// the query without a manual rebuild.
  Widget _results(BuildContext context) {
    final query = _home.query.value.trim();

    if (query.isEmpty) {
      final recents = SearchScreenController.instance.recents;
      if (recents.isEmpty) {
        return const AppEmptyView(
          icon: Icons.search_rounded,
          title: 'Search the catalogue',
          subtitle: 'Find gowns by name or category — try "lace" or "A-line".',
        );
      }
      return _RecentsList(recents: recents, onSelected: _applyRecent);
    }

    final results = _home.visibleProducts;
    if (results.isEmpty) {
      return AppEmptyView(
        icon: Icons.search_off_rounded,
        title: 'No gowns match "$query"',
        subtitle: 'Try another name, or clear the search to see everything.',
      );
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            results.length == 1
                ? '1 result for "$query"'
                : '${results.length} results for "$query"',
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.secondary(context),
            ),
          ),
          SizedBox(height: 12.h),
          // Tapping a result files the query in the recents first.
          ProductGrid(
            products: results,
            onSelected: () => _commit(query),
          ),
        ],
      ),
    );
  }
}

/// Past queries, newest first — tapping one re-runs it.
class _RecentsList extends StatelessWidget {
  const _RecentsList({required this.recents, required this.onSelected});

  final List<String> recents;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Recent searches',
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.3.sp,
                    color: AppColors.heading(context),
                  ),
                ),
              ),
              InkWell(
                onTap: SearchScreenController.instance.clearRecents,
                borderRadius: BorderRadius.circular(8.r),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
                  child: Text(
                    'Clear all',
                    style: TextStyle(
                      fontSize: 11.5.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.link(context),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          for (final query in recents)
            InkWell(
              onTap: () => onSelected(query),
              borderRadius: BorderRadius.circular(10.r),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                child: Row(
                  children: [
                    Icon(
                      Icons.history_rounded,
                      size: 18.sp,
                      color: AppColors.secondary(context),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        query,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.strong(context),
                        ),
                      ),
                    ),
                    Icon(
                      Icons.north_west_rounded,
                      size: 15.sp,
                      color: AppColors.secondary(context),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
