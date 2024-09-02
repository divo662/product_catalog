import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_catalog_app/core/widgets/widgets_components.dart';
import 'package:product_catalog_app/features/home%20directory/widgets/add_to_cart_button.dart';
import 'package:provider/provider.dart';
import 'package:remixicon/remixicon.dart';
import '../../../core/res/app_strings.dart';
import '../../../core/utils/app_color.dart';
import '../../../models/product_models.dart';
import '../../../providers/product_provider.dart';

class ProductDetailsBottomSheet extends StatefulWidget {
  final int productId;

  const ProductDetailsBottomSheet({super.key, required this.productId});

  @override
  State<ProductDetailsBottomSheet> createState() =>
      _ProductDetailsBottomSheetState();
}

class _ProductDetailsBottomSheetState extends State<ProductDetailsBottomSheet> {
  late ValueNotifier<Future<Product?>> _productFuture;

  @override
  void initState() {
    super.initState();
    _productFuture = ValueNotifier(_getProduct());
  }

  Future<Product?> _getProduct() async {
    await Future.delayed(const Duration(milliseconds: 500));
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    return productProvider.products
        .cast<Product?>()
        .firstWhere((p) => p?.id == widget.productId, orElse: () => null);
  }

  void _refreshProduct() {
    _productFuture.value = _getProduct();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Future<Product?>>(
      valueListenable: _productFuture,
      builder: (context, future, child) {
        return FutureBuilder<Product?>(
          future: future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return WidgetComponents().buildLoadingState(context);
            } else if (snapshot.hasError) {
              return WidgetComponents().buildErrorState(snapshot.error.toString(), context);
            } else if (!snapshot.hasData || snapshot.data == null) {
              return WidgetComponents().buildProductNotFoundState(context);
            } else {
              return _buildProductDetails(context, snapshot.data!);
            }
          },
        );
      },
    );
  }

  Widget _buildProductDetails(BuildContext context, Product product) {
    return Consumer<ProductProvider>(
      builder: (context, productProvider, child) {
        return Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: AppColor.bg,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 25.h),
              _buildHeader(context, product, productProvider),
              _buildProductImage(product),
              Expanded(
                child: _buildProductInfo(context, product, productProvider),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader(
      BuildContext context, Product product, ProductProvider productProvider) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          WidgetComponents().iconContainer(
            context,
            CupertinoIcons.xmark,
            () => Navigator.pop(context),
            Colors.black,
          ),
          Wrap(
            spacing: 10.0,
            children: [
              WidgetComponents().iconContainer(
                context,
                Remix.edit_line,
                () => _editProduct(context, product, productProvider),
                Colors.black,
              ),
              WidgetComponents().iconContainer(
                context,
                Remix.delete_bin_line,
                () => _confirmDelete(context, product),
                Colors.black,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProductImage(Product product) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: CachedNetworkImage(
        imageUrl: product.imageUrl,
        height: 450,
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }

  Widget _buildProductInfo(
      BuildContext context, Product product, ProductProvider productProvider) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.r),
          topRight: Radius.circular(25.r),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.name,
              style: TextStyle(
                fontSize: 20.sp,
                fontFamily: AppStrings.poppins,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              product.description,
              style: TextStyle(
                fontSize: 13.sp,
                fontFamily: AppStrings.poppins,
                color: AppColor.greyColor8,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'Category: ${productProvider.getCategoryNameById(product.categoryId)}',
              style: TextStyle(
                fontSize: 15.sp,
                fontFamily: AppStrings.poppins,
                color: AppColor.greyColor9,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '\$${product.price}',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontFamily: AppStrings.poppins,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 3.w),
                AddToCartButton(
                  provider: productProvider,
                  product: product,
                ),
              ],
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  void _editProduct(
      BuildContext context, Product product, ProductProvider productProvider) {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController nameController =
            TextEditingController(text: product.name);
        TextEditingController descriptionController =
            TextEditingController(text: product.description);
        TextEditingController priceController =
            TextEditingController(text: product.price.toString());

        return AlertDialog(
          title: Text(
            'Edit Product',
            style: TextStyle(
              fontSize: 16.sp,
              fontFamily: AppStrings.poppins,
              color: AppColor.greyColor9,
              fontWeight: FontWeight.w500,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              WidgetComponents().textFieldWidget(nameController, "Name"),
              WidgetComponents().textFieldWidget(descriptionController, "Description"),
              WidgetComponents().textFieldWidget(priceController, "Price"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                await productProvider.updateProduct(
                  Product(
                    id: product.id,
                    name: nameController.text,
                    description: descriptionController.text,
                    price: double.parse(priceController.text),
                    imageUrl: product.imageUrl,
                    categoryId: product.categoryId,
                  ),
                );
                Navigator.of(context).pop();
                _refreshProduct();
              },
              child: const Text(
                'Save',
                style: TextStyle(
                  fontFamily: AppStrings.poppins,
                  color: AppColor.primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _confirmDelete(BuildContext context, Product product) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Delete Product',
          style: TextStyle(
            fontSize: 16.sp,
            fontFamily: AppStrings.poppins,
            color: AppColor.greyColor9,
            fontWeight: FontWeight.w500,
          ),
        ),
        content: Text(
          'Are you sure you want to delete this product?',
          style: TextStyle(
            fontSize: 13.sp,
            fontFamily: AppStrings.poppins,
            color: AppColor.greyColor8,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              await Provider.of<ProductProvider>(context, listen: false)
                  .deleteProduct(product.id!);
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text(
              'Delete',
              style: TextStyle(
                fontFamily: AppStrings.poppins,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'Cancel',
              style: TextStyle(
                fontFamily: AppStrings.poppins,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

}

