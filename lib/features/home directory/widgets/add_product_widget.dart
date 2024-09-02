import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_catalog_app/core/widgets/default_button.dart';
import 'package:provider/provider.dart';
import '../../../core/res/app_strings.dart';
import '../../../core/utils/app_color.dart';
import '../../../core/widgets/form_text.dart';
import '../../../core/widgets/widgets_components.dart';
import '../../../models/product_models.dart';
import '../../../providers/product_provider.dart';

class AddProductBottomSheet extends StatefulWidget {

  const AddProductBottomSheet({super.key});

  @override
  State<AddProductBottomSheet> createState() => _AddProductBottomSheetState();
}

class _AddProductBottomSheetState extends State<AddProductBottomSheet> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  final TextEditingController _priceController = TextEditingController();

  final TextEditingController _imageUrlController = TextEditingController();
  @override
  void dispose() {
    _imageUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, productProvider, child) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.9,
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                WidgetComponents().buildHeader(context, "Add Product"),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FormText(
                    controller: _nameController,
                    textInputAction: TextInputAction.next,
                    textColor: AppColor.whiteTextColor,
                    hintText: "Product Name",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FormText(
                    controller: _descriptionController,
                    textInputAction: TextInputAction.next,
                    textColor: AppColor.whiteTextColor,
                    hintText: "Product Description",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FormText(
                    controller: _priceController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    textColor: AppColor.whiteTextColor,
                    hintText: "Product Price",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FormText(
                    controller: _imageUrlController,
                    textInputAction: TextInputAction.next,
                    textColor: AppColor.whiteTextColor,
                    hintText: "Product Image URL",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    height: 50.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: AppColor.greyColor4),
                    child: DropdownButtonFormField<int>(
                      value: productProvider.selectedCategoryIndex > 0
                          ? productProvider.selectedCategoryIndex - 1
                          : null,
                      items: productProvider.categories.map((category) {
                        return DropdownMenuItem<int>(
                          value: productProvider.categories.indexOf(category),
                          child: Text(category.name),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          productProvider.setSelectedCategoryIndex(value + 1);
                        }
                      },
                      style: TextStyle(
                          color: AppColor.greyColor9,
                          fontWeight: FontWeight.w500,
                          fontFamily: AppStrings.poppins,
                          fontSize: 14.sp),
                      decoration:  InputDecoration(
                          hintText: 'Select Category',
                          hintStyle: TextStyle(
                          color: AppColor.greyColor5,
                          fontWeight: FontWeight.w500,
                          fontFamily: AppStrings.poppins,
                          fontSize: 14.sp),
                          contentPadding: EdgeInsets.all(8.sp),
                          border: InputBorder.none),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                productProvider.isLoading
                    ? const Center(child:  CircularProgressIndicator(color: AppColor.primaryColor,))
                    : DefaultButton(
                        onpressed: () =>
                            _handleAddProduct(context, productProvider),
                        title: "Add Product",
                        buttonWidth: double.infinity),
              ],
            ),
          ),
        );
      },
    );
  }

  void _handleAddProduct(
      BuildContext context, ProductProvider productProvider) async {
    final String name = _nameController.text.trim();
    final String description = _descriptionController.text.trim();
    final double? price = double.tryParse(_priceController.text.trim());
    final String imageUrl = _imageUrlController.text.trim();

    if (name.isNotEmpty &&
        description.isNotEmpty &&
        price != null &&
        imageUrl.isNotEmpty &&
        productProvider.selectedCategoryIndex > 0) {
      Product newProduct = Product(
        name: name,
        description: description,
        price: price,
        imageUrl: imageUrl,
        categoryId: productProvider
            .categories[productProvider.selectedCategoryIndex - 1].id,
        id: null,
      );
      await productProvider.addProduct(newProduct);
      Navigator.pop(context);
    } else {
      WidgetComponents().alertdialog(
          context, "Please fill in all information.", "Missing Entry");
    }
  }

}
