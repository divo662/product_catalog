import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_catalog_app/core/res/app_strings.dart';
import 'package:product_catalog_app/core/utils/app_color.dart';
import 'package:product_catalog_app/core/widgets/default_button.dart';
import 'package:product_catalog_app/features/home%20directory/widgets/product_details_bottomsheet_widget.dart';
import 'package:provider/provider.dart';
import '../../../core/widgets/widgets_components.dart';
import '../../../providers/product_provider.dart';

class CartBottomSheet extends StatelessWidget {
  const CartBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, productProvider, child) {
        final cartProducts = productProvider.cartProductIds;
        double totalCost = 0.0;

        for (var productId in cartProducts) {
          final product = productProvider.getProductById(productId);
          totalCost +=
              product.price * productProvider.getProductQuantity(productId);
        }

        const discount = 0.3;
        final discountedTotal = totalCost * (1 - discount);

        return Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.h,
              ),
              WidgetComponents().buildHeader(context, "My cart"),
              Expanded(
                child: cartProducts.isEmpty
                    ? Center(
                        child: Text(
                          "Cart is empty, please add a product to cart.",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontFamily: AppStrings.poppins,
                            color: AppColor.greyColor7,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 2,
                        ),
                      )
                    : ListView.builder(
                        itemCount: cartProducts.length,
                        itemBuilder: (context, index) {
                          final productId = cartProducts[index];
                          final product =
                              productProvider.getProductById(productId);
                          final quantity =
                              productProvider.getProductQuantity(productId);
                          return Column(
                            children: [
                              if (cartProducts.isEmpty)
                                Center(
                                  child: Text(
                                    "Cart is empty, please add product to cart.",
                                    style: TextStyle(
                                        fontSize: 15.sp,
                                        fontFamily: AppStrings.poppins,
                                        color: AppColor.greyColor9,
                                        fontWeight: FontWeight.w600),
                                    maxLines: 2,
                                  ),
                                ),
                              ListTile(
                                leading: Container(
                                  width: 80.w,
                                  height: 150.h,
                                  padding: EdgeInsets.all(8.sp),
                                  decoration: BoxDecoration(
                                    color: AppColor.greyColor3,
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: product.imageUrl,
                                    fit: BoxFit.contain,
                                    height: 50.h,
                                    width: 50.w,
                                    placeholder: (context, url) => const Center(
                                        child: CircularProgressIndicator()),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                ),
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        product.name,
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            fontFamily: AppStrings.poppins,
                                            color: AppColor.greyColor9,
                                            fontWeight: FontWeight.w600),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(CupertinoIcons.xmark,
                                          color: AppColor.greyColor5),
                                      onPressed: () {
                                        productProvider
                                            .removeFromCart(productId);
                                      },
                                    ),
                                  ],
                                ),
                                subtitle: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Price: \$${(product.price * quantity).toStringAsFixed(2)}',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontFamily: AppStrings.poppins,
                                        color: AppColor.greyColor8,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(width: 3.w,),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        WidgetComponents().iconButtonWidget(() {
                                          productProvider
                                              .decreaseQuantity(productId);
                                        }, productProvider, Icons.remove),
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        Text(
                                          quantity.toString(),
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w600,
                                              color: AppColor.greyColor9),
                                        ),
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        WidgetComponents().iconButtonWidget(() {
                                          productProvider
                                              .increaseQuantity(productId);
                                        }, productProvider, Icons.add),
                                      ],
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      backgroundColor: Colors.transparent,
                                      useRootNavigator: true,
                                      builder: (_) => ProductDetailsBottomSheet(
                                          productId: product.id!));
                                },
                              ),
                              const Divider(),
                            ],
                          );
                        },
                      ),
              ),
              Column(
                children: [
                  rowTextWidget(
                    "Subtotal:",
                    '\$${totalCost.toStringAsFixed(2)}',
                  ),
                  rowTextWidget(
                    "Total(after 30% discount):",
                    '\$${discountedTotal.toStringAsFixed(2)}',
                  )
                ],
              ),
              const SizedBox(height: 10),
              DefaultButton(
                  onpressed: () {
                    WidgetComponents().alertdialog(
                        context,
                        "This button doesn't do anything at the moment",
                        "Warning!");
                  },
                  title: "Checkout",
                  buttonWidth: double.infinity)
            ],
          ),
        );
      },
    );
  }

  Widget rowTextWidget(String text, String priceText) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: TextStyle(
              fontSize: 16.sp,
              fontFamily: AppStrings.poppins,
              color: AppColor.greyColor7,
              fontWeight: FontWeight.w500),
        ),
        Text(
          priceText,
          style: TextStyle(
              fontSize: 17.sp,
              fontFamily: AppStrings.poppins,
              color: AppColor.greyColor9,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
