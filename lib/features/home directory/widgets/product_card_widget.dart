import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_catalog_app/core/res/app_strings.dart';
import 'package:product_catalog_app/core/utils/app_color.dart';

import '../../../models/product_models.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 160.h,
          width: double.infinity,
          padding: EdgeInsets.all(6.sp),
          decoration: BoxDecoration(
            color: AppColor.greyColor3,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: CachedNetworkImage(
            imageUrl: product.imageUrl,
            fit: BoxFit.contain,
            placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
        SizedBox(height: 8.h,),
        Text(
          product.name,
          style:  TextStyle(
            fontSize: 14.sp,
            fontFamily: AppStrings.poppins,
            color: AppColor.greyColor7,
            fontWeight: FontWeight.w500,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          '\$${product.price}',
          style:  TextStyle(
            fontSize: 17.sp,
            fontFamily: AppStrings.poppins,
            color: AppColor.greyColor9,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
