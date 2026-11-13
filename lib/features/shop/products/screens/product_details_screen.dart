// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:grace_and_gown_app/common/widgets/app_primary_button.dart';
// import 'package:grace_and_gown_app/features/shop/products/controllers/product_detail_controller.dart';
// import 'package:grace_and_gown_app/utils/constants/colors.dart';
//
// class ProductDetailScreen extends StatelessWidget {
//   const ProductDetailScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(ProductDetailController());
//     final product = controller.product;
//
//     Widget specRow(IconData icon, String label, String value) {
//       return Padding(
//         padding: EdgeInsets.only(bottom: 12.h),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               width: 38.sp,
//               height: 38.sp,
//               decoration: BoxDecoration(
//                 color: AppColors.fieldFill(context),
//                 shape: BoxShape.circle,
//               ),
//               child: Icon(icon, size: 18.sp, color: AppColors.accent(context)),
//             ),
//             SizedBox(width: 12.w),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     label,
//                     style: TextStyle(
//                       fontSize: 11.5.sp,
//                       fontWeight: FontWeight.w500,
//                       color: AppColors.secondary(context),
//                     ),
//                   ),
//                   SizedBox(height: 2.h),
//                   Text(
//                     value,
//                     style: TextStyle(
//                       fontSize: 14.sp,
//                       fontWeight: FontWeight.w700,
//                       color: AppColors.heading(context),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       );
//     }
//
//     return Scaffold(
//       backgroundColor: AppColors.authScaffold(context),
//       body: SafeArea(
//         child: Column(
//           children: [
//             /// Top bar
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 6.h),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   IconButton(
//                     onPressed: () => Get.back(),
//                     icon: Icon(
//                       Icons.arrow_back_ios_new_rounded,
//                       size: 20.sp,
//                       color: AppColors.accent(context),
//                     ),
//                   ),
//                   Text(
//                     'Product Details',
//                     style: TextStyle(
//                       fontFamily: 'Prata',
//                       fontSize: 17.sp,
//                       letterSpacing: 0.5.sp,
//                       color: AppColors.heading(context),
//                     ),
//                   ),
//                   Obx(() => IconButton(
//                     onPressed: controller.toggleFavourite,
//                     icon: Icon(
//                       controller.isFavourite.value
//                           ? Icons.favorite_rounded
//                           : Icons.favorite_outline_rounded,
//                       size: 22.sp,
//                       color: controller.isFavourite.value
//                           ? AppColors.error
//                           : AppColors.accent(context),
//                     ),
//                   )),
//                 ],
//               ),
//             ),
//
//             Expanded(
//               child: SingleChildScrollView(
//                 //padding: EdgeInsets.fromLTRB(18.w, 6.h, 18.w, 20.h),
//                 padding: EdgeInsets.fromLTRB(0, 6.h, 0, 20.h),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Hero(
//                     //   tag: 'product-${product.id}',
//                     //   child: ClipRRect(
//                     //     borderRadius: BorderRadius.circular(16.r),
//                     //     child: Image.asset(
//                     //       product.image,
//                     //       width: double.infinity,
//                     //       height: 360.h,
//                     //       fit: BoxFit.cover,
//                     //     ),
//                     //   ),
//                     // ),
//                     Hero(
//                       tag: 'product-${product.id}',
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(16.r),
//                         child: Image.asset(
//                           product.image,
//                           width: double.infinity,
//                           height: 460.h,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 16.h),
//
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Expanded(
//                           child: Text(
//                             product.name,
//                             style: TextStyle(
//                               fontFamily: 'Prata',
//                               fontSize: 23.sp,
//                               height: 1.25,
//                               letterSpacing: 0.4.sp,
//                               color: AppColors.heading(context),
//                             ),
//                           ),
//                         ),
//                         SizedBox(width: 10.w),
//                         Text(
//                           product.price,
//                           style: TextStyle(
//                             fontSize: 15.sp,
//                             fontWeight: FontWeight.w800,
//                             color: AppColors.accentText(context),
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 10.h),
//
//                     Container(
//                       padding: EdgeInsets.symmetric(
//                         horizontal: 12.w,
//                         vertical: 6.h,
//                       ),
//                       decoration: BoxDecoration(
//                         color: AppColors.fieldFill(context),
//                         borderRadius: BorderRadius.circular(30.r),
//                         border: Border.all(
//                           color: AppColors.accent(context)
//                               .withValues(alpha: 0.5),
//                         ),
//                       ),
//                       child: Text(
//                         product.category,
//                         style: TextStyle(
//                           fontSize: 11.5.sp,
//                           fontWeight: FontWeight.w700,
//                           color: AppColors.accentText(context),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 18.h),
//
//                     Text(
//                       'Description',
//                       style: TextStyle(
//                         fontSize: 15.sp,
//                         fontWeight: FontWeight.w700,
//                         color: AppColors.heading(context),
//                       ),
//                     ),
//                     SizedBox(height: 6.h),
//                     Text(
//                       product.description,
//                       style: TextStyle(
//                         fontSize: 13.5.sp,
//                         height: 1.55,
//                         fontWeight: FontWeight.w400,
//                         color: AppColors.secondary(context),
//                       ),
//                     ),
//                     SizedBox(height: 20.h),
//
//                     specRow(Icons.style_outlined, 'Fabric', product.fabric),
//                     specRow(
//                       Icons.straighten_outlined,
//                       'Sizes available',
//                       product.sizes.join('  ·  '),
//                     ),
//                     specRow(
//                       Icons.event_available_outlined,
//                       'Availability',
//                       product.availability,
//                     ),
//                     specRow(
//                       Icons.category_outlined,
//                       'Category',
//                       product.category,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//
//             /// Bottom action bar
//             Container(
//               padding: EdgeInsets.fromLTRB(18.w, 12.h, 18.w, 12.h),
//               decoration: BoxDecoration(
//                 color: AppColors.elevatedSurface(context),
//                 border: Border(
//                   top: BorderSide(
//                     color: AppColors.accent(context).withValues(alpha: 0.35),
//                     width: 0.8,
//                   ),
//                 ),
//               ),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: InkWell(
//                       onTap: controller.addToCart,
//                       borderRadius: BorderRadius.circular(12.r),
//                       child: Container(
//                         height: 60.h,
//                         alignment: Alignment.center,
//                         decoration: BoxDecoration(
//                           color: AppColors.fieldFill(context),
//                           border: Border.all(color: AppColors.accent(context)),
//                           borderRadius: BorderRadius.circular(12.r),
//                         ),
//                         child: Text(
//                           'Add to Cart',
//                           style: TextStyle(
//                             fontSize: 15.sp,
//                             fontWeight: FontWeight.w700,
//                             color: AppColors.accentText(context),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 10.w),
//                   Expanded(
//                     child: AppPrimaryButton(
//                       text: 'Book Now',
//                       onTap: controller.bookNow,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grace_and_gown_app/common/widgets/app_primary_button.dart';
import 'package:grace_and_gown_app/features/shop/products/controllers/product_detail_controller.dart';
import 'package:grace_and_gown_app/utils/constants/colors.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductDetailController());
    final product = controller.product;

    Widget specRow(IconData icon, String label, String value) {
      return Padding(
        padding: EdgeInsets.only(bottom: 12.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 38.sp,
              height: 38.sp,
              decoration: BoxDecoration(
                color: AppColors.fieldFill(context),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 18.sp, color: AppColors.accent(context)),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 11.5.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.secondary(context),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.heading(context),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.authScaffold(context),
      body: SafeArea(
        child: Column(
          children: [
            /// Top bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 6.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 20.sp,
                      color: AppColors.accent(context),
                    ),
                  ),
                  Text(
                    'Product Details',
                    style: TextStyle(
                      fontFamily: 'Prata',
                      fontSize: 17.sp,
                      letterSpacing: 0.5.sp,
                      color: AppColors.heading(context),
                    ),
                  ),
                  Obx(() => IconButton(
                    onPressed: controller.toggleFavourite,
                    icon: Icon(
                      controller.isFavourite.value
                          ? Icons.favorite_rounded
                          : Icons.favorite_outline_rounded,
                      size: 22.sp,
                      color: controller.isFavourite.value
                          ? AppColors.error
                          : AppColors.accent(context),
                    ),
                  )),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                // No side padding so the hero image runs full-bleed;
                // the text below gets its own 18.w padding instead.
                padding: EdgeInsets.fromLTRB(0, 6.h, 0, 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Full-bleed hero image. The box matches the photo's own
                    /// aspect ratio, so `cover` shows the whole image edge to
                    /// edge — no cropping, no letterbox bands. Height follows
                    /// the photo (the page scrolls).
                    Hero(
                      tag: 'product-${product.id}',
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.r),
                        child: SizedBox(
                          width: double.infinity,
                          child: AspectRatio(
                            aspectRatio: product.imageAspect,
                            child: Container(
                              color: AppColors.fieldFill(context),
                              alignment: Alignment.center,
                              child: Image.asset(
                                product.image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.fromLTRB(18.w, 16.h, 18.w, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  product.name,
                                  style: TextStyle(
                                    fontFamily: 'Prata',
                                    fontSize: 23.sp,
                                    height: 1.25,
                                    letterSpacing: 0.4.sp,
                                    color: AppColors.heading(context),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Text(
                                product.price,
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.accentText(context),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),

                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 6.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.fieldFill(context),
                              borderRadius: BorderRadius.circular(30.r),
                              border: Border.all(
                                color:
                                AppColors.accent(context).withValues(alpha: 0.5),
                              ),
                            ),
                            child: Text(
                              product.category,
                              style: TextStyle(
                                fontSize: 11.5.sp,
                                fontWeight: FontWeight.w700,
                                color: AppColors.accentText(context),
                              ),
                            ),
                          ),
                          SizedBox(height: 18.h),

                          Text(
                            'Description',
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.heading(context),
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            product.description,
                            style: TextStyle(
                              fontSize: 13.5.sp,
                              height: 1.55,
                              fontWeight: FontWeight.w400,
                              color: AppColors.secondary(context),
                            ),
                          ),
                          SizedBox(height: 20.h),

                          specRow(Icons.style_outlined, 'Fabric', product.fabric),
                          specRow(
                            Icons.straighten_outlined,
                            'Sizes available',
                            product.sizes.join('  ·  '),
                          ),
                          specRow(
                            Icons.event_available_outlined,
                            'Availability',
                            product.availability,
                          ),
                          specRow(
                            Icons.category_outlined,
                            'Category',
                            product.category,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /// Bottom action bar
            Container(
              padding: EdgeInsets.fromLTRB(18.w, 12.h, 18.w, 12.h),
              decoration: BoxDecoration(
                color: AppColors.elevatedSurface(context),
                border: Border(
                  top: BorderSide(
                    color: AppColors.accent(context).withValues(alpha: 0.35),
                    width: 0.8,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: controller.addToCart,
                      borderRadius: BorderRadius.circular(12.r),
                      child: Container(
                        height: 60.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.fieldFill(context),
                          border: Border.all(color: AppColors.accent(context)),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Text(
                          'Add to Cart',
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.accentText(context),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: AppPrimaryButton(
                      text: 'Book Now',
                      onTap: controller.bookNow,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}