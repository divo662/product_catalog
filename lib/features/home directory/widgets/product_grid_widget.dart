import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_catalog_app/features/home%20directory/widgets/product_card_widget.dart';
import 'package:product_catalog_app/features/home%20directory/widgets/product_details_bottomsheet_widget.dart';
import 'package:provider/provider.dart';

import '../../../core/res/app_strings.dart';
import '../../../core/utils/app_color.dart';
import '../../../providers/product_provider.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    if (productProvider.products.isEmpty) {
      return Center(
          child: Text(
        'No products found.',
        style: TextStyle(
          color: AppColor.greyColor9,
          fontFamily: AppStrings.poppins,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
      ));
    }

    return Column(
      children: [
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(8.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 18,
              mainAxisSpacing: 6,
              childAspectRatio: 0.63,
            ),
            itemCount: productProvider.products.length,
            itemBuilder: (context, index) {
              final product = productProvider.products[index];
              return GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      useRootNavigator: true,
                      builder: (_) =>ProductDetailsBottomSheet(productId: product.id!));
                },
                child: Column(
                  children: [
                    ProductCard(product: product),
                  ],
                ),
              );
            },
          ),
        ),
        SizedBox(height: 40.h),
      ],
    );
  }
}
