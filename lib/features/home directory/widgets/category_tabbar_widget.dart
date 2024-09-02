import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_catalog_app/core/utils/app_color.dart';
import 'package:provider/provider.dart';
import '../../../core/res/app_strings.dart';
import '../../../providers/product_provider.dart';

class CategoryTabBar extends StatelessWidget {
  const CategoryTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return SizedBox(
      height: 60.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: productProvider.categories.length + 1,
        itemBuilder: (context, index) {
          final isSelected = productProvider.selectedCategoryIndex == index;
          return GestureDetector(
            onTap: () {
              productProvider.setSelectedCategoryIndex(index);
              productProvider.fetchProducts(
                categoryId: index == 0
                    ? null
                    : productProvider.categories[index - 1].id,
              );
            },
            child: AnimatedContainer(
              margin: EdgeInsets.all(6.sp),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? AppColor.primaryColor : Colors.transparent,
                borderRadius: BorderRadius.circular(15.r),
                border: Border.all(
                  color: isSelected ? Colors.transparent : AppColor.greyColor9,
                  width: 1.6,
                ),
              ),
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: Center(
                child: Text(
                  index == 0
                      ? 'All'
                      : productProvider.categories[index - 1].name,
                  style: TextStyle(
                    color: isSelected
                        ? AppColor.whiteTextColor
                        : AppColor.greyColor9,
                    fontFamily: AppStrings.poppins,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
