import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'loading_indicator_widget.dart';
import '../../providers/product_provider.dart';
import '../res/app_strings.dart';
import '../utils/app_color.dart';

class WidgetComponents{

  Widget iconContainer(BuildContext context, IconData iconData,
      VoidCallback onTap, Color color) {
    return Container(
      height: 38.h,
      width: 38.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColor.greyColor3,
      ),
      child: IconButton(
        icon: Icon(iconData, color: color),
        onPressed: onTap,
      ),
    );
  }

  Widget textFieldWidget(TextEditingController controller, String text) {
    return TextField(
      controller: controller,
      style: TextStyle(
        fontSize: 13.sp,
        fontFamily: AppStrings.poppins,
        color: AppColor.greyColor8,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        labelText: text,
        labelStyle: TextStyle(
          fontSize: 13.sp,
          fontFamily: AppStrings.poppins,
          color: AppColor.greyColor8,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget buildLoadingState(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: AppColor.bg.withOpacity(0.9),
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      child: const Center(
          child: EcommerceLoadingIndicator(
            color: AppColor.primaryColor,
            size: 80.0, // Adjust size as needed
          )),
    );
  }

  Widget buildErrorState(String error, BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: AppColor.bg.withOpacity(0.9),
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      child: Center(
        child: Text(
          'Error: $error',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: AppStrings.poppins,
            fontSize: 18.sp,
          ),
        ),
      ),
    );
  }

  Widget buildProductNotFoundState(BuildContext context) {
    Future.microtask(() => Navigator.of(context).pop());
    return Center(
      child: Text(
        'Product not found',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontFamily: AppStrings.poppins,
          fontSize: 18.sp,
        ),
      ),
    );
  }

  Widget iconButtonWidget(VoidCallback onTap, ProductProvider productProvider, IconData iconData) {
    return  Container(
      height: 40.h,
      width: 40.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.transparent,
        border: Border.all(color: AppColor.greyColor5, width: 1.6),
      ),
      child: Center(
        child: IconButton(
          icon: Icon(iconData),
          onPressed: onTap,
        ),
      ),
    );

  }

  void alertdialog(BuildContext context, String subtitle, String title) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
         title,
          style: TextStyle(
            fontSize: 16.sp,
            fontFamily: AppStrings.poppins,
            color: AppColor.greyColor9,
            fontWeight: FontWeight.w500,
          ),
        ),
        content: Text(
         subtitle,
          style: TextStyle(
            fontSize: 13.sp,
            fontFamily: AppStrings.poppins,
            color: AppColor.greyColor8,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          TextButton(
            onPressed: ()  {
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text(
              'Ok',
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
  Widget buildHeader(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: TextStyle(
                fontSize: 20.sp,
                fontFamily: AppStrings.poppins,
                color: AppColor.greyColor9,
                fontWeight: FontWeight.bold),
          ),
          WidgetComponents().iconContainer(
            context,
            CupertinoIcons.xmark,
                () => Navigator.pop(context),
            Colors.black,
          ),
        ],
      ),
    );
  }

}