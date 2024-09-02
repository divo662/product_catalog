import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_catalog_app/core/res/app_strings.dart';
import 'package:product_catalog_app/core/utils/app_color.dart';
import 'package:product_catalog_app/features/home%20directory/widgets/add_product_widget.dart';
import 'package:product_catalog_app/features/home%20directory/widgets/search_product_bottomsheet_widget.dart';
import 'package:provider/provider.dart';
import 'package:remixicon/remixicon.dart';
import '../../../providers/product_provider.dart';
import '../widgets/cart_bottomsheet_widget.dart';
import '../widgets/category_tabbar_widget.dart';
import '../widgets/product_grid_widget.dart';
import '../widgets/promo_banner_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bg,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Discover',
          style: TextStyle(
            fontFamily: AppStrings.poppins,
            fontWeight: FontWeight.w500,
            fontSize: 22.sp,
            color: AppColor.greyColor9,
          ),
        ),
        actions: [
          Stack(
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.transparent,
                  border: Border.all(color: AppColor.greyColor5, width: 1.6),
                ),
                child: IconButton(
                  icon: const Icon(
                    Remix.shopping_bag_4_line,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      useRootNavigator: true,
                      builder: (context) => const CartBottomSheet(),
                    );
                  },
                ),
              ),
              Consumer<ProductProvider>(
                builder: (context, productProvider, child) {
                  int cartCount = productProvider.cartProductIds.length;
                  return Positioned(
                    right: 1,
                    top: 1,
                    child: CircleAvatar(
                      radius: 10,
                      backgroundColor: AppColor.primaryColor,
                      child: Text(
                        cartCount.toString(),
                        style:
                            const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          SizedBox(
            width: 5.w,
          ),
          appbarActionButtons(context, Remix.search_line, () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              useRootNavigator: true,
              builder: (context) => const SearchProductBottomsheetWidget(),
            );
          }),
          SizedBox(
            width: 5.w,
          ),
          appbarActionButtons(context, Remix.add_circle_line, () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              useRootNavigator: true,
              builder: (context) => AddProductBottomSheet(),
            );
          }),
          SizedBox(
            width: 5.w,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 10.h),
            const PromoBanner(),
            SizedBox(height: 10.h),
            const CategoryTabBar(),
            const Expanded(child: ProductGrid()),
          ],
        ),
      ),
    );
  }

  Widget appbarActionButtons(
      BuildContext context, IconData iconData, VoidCallback onTap) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.transparent,
        border: Border.all(color: AppColor.greyColor5, width: 1.6),
      ),
      child: IconButton(
          icon: Icon(
            iconData,
            color: Colors.black,
          ),
          onPressed: onTap),
    );
  }
}
