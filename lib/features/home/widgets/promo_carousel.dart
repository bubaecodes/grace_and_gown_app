import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grace_and_gown_app/utils/constants/colors.dart';
import 'package:grace_and_gown_app/utils/toasts/custom_snackbar.dart';
import 'package:toastification/toastification.dart';

class _Promo {
  const _Promo({
    required this.title,
    required this.subtitle,
    required this.action,
    required this.image,
  });

  final String title;
  final String subtitle;
  final String action;
  final String image;
}

class PromoCarousel extends StatefulWidget {
  const PromoCarousel({super.key});

  @override
  State<PromoCarousel> createState() => _PromoCarouselState();
}

class _PromoCarouselState extends State<PromoCarousel> {
  static final List<_Promo> _promos = [
    _Promo(
      title: 'New Arrivals',
      subtitle: 'The spring bridal collection just landed.',
      action: 'Shop Now',
      image: 'assets/images/category/gown_5.png',
    ),
    const _Promo(
      title: 'Court Ready',
      subtitle: 'Tailored looks for your registry day.',
      action: 'Explore',
      image: 'assets/images/courts/court_2.jpg',
    ),
    const _Promo(
      title: 'Trad Favorites',
      subtitle: 'Colour, george and lace for the big day.',
      action: 'View More',
      image: 'assets/images/courts/court_7.jpg',
    ),
    const _Promo(
      title: 'Bouquets',
      subtitle: 'Hand-tied bouquets to finish the look.',
      action: 'See Collection',
      image: 'assets/images/bouquets/bouquet_1.jpg',
    ),
  ];

  final PageController _controller = PageController();
  int _current = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 175.h,
          child: PageView.builder(
            controller: _controller,
            itemCount: _promos.length,
            onPageChanged: (i) => setState(() => _current = i),
            itemBuilder: (_, i) => _PromoCard(promo: _promos[i]),
          ),
        ),
        SizedBox(height: 12.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_promos.length, (i) {
            final active = i == _current;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: EdgeInsets.symmetric(horizontal: 3.w),
              width: active ? 18.w : 7.w,
              height: 7.sp,
              decoration: BoxDecoration(
                color: active
                    ? AppColors.accentText(context)
                    : AppColors.secondary(context).withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(4.r),
              ),
            );
          }),
        ),
      ],
    );
  }
}

class _PromoCard extends StatelessWidget {
  const _PromoCard({required this.promo});

  final _Promo promo;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 1.w),
      decoration: BoxDecoration(
        color: AppColors.elevatedSurface(context),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.accent(context).withValues(alpha: 0.35),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.w, 18.h, 8.w, 18.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    promo.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'Prata',
                      fontSize: 18.sp,
                      letterSpacing: 0.5.sp,
                      color: AppColors.heading(context),
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    promo.subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12.sp,
                      height: 1.35,
                      fontWeight: FontWeight.w500,
                      color: AppColors.secondary(context),
                    ),
                  ),
                  SizedBox(height: 14.h),
                  InkWell(
                    onTap: () => CustomSnackBar.showSafe(
                      title: promo.title,
                      message: 'Coming soon — this promo isn\'t live yet.',
                      type: ToastificationType.info,
                    ),
                    borderRadius: BorderRadius.circular(30.r),
                    child: Container(
                      padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: AppColors.sageGreen,
                        border: Border.all(color: AppColors.accent(context)),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        promo.action,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 135.w,
            height: double.infinity,
            child: ShaderMask(
              shaderCallback: (Rect bounds) {
                return const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.transparent,
                    Color(0xFFF5F5F5),
                  ],
                  stops: [0.0, 0.47],
                ).createShader(bounds);
              },
              blendMode: BlendMode.dstIn,
              child: Image.asset(
                promo.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}