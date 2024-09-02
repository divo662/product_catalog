import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_catalog_app/core/res/app_images.dart';
import 'package:product_catalog_app/core/res/app_strings.dart';
import 'package:product_catalog_app/core/utils/app_color.dart';

class PromoBanner extends StatelessWidget {
  const PromoBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 170.h,
      padding: EdgeInsets.all(8.sp),
      decoration: BoxDecoration(
        color: AppColor.primaryColor,
        borderRadius: BorderRadius.circular(25.r),
      ),
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                'Clearance Sale \n50% OFF!',
                style: TextStyle(
                  color: AppColor.whiteTextColor,
                  fontFamily: AppStrings.poppins,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Image.asset(AppImages.promoBannerImg)
          ],
        ),
      ),
    );
  }
}
