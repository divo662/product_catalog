import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:remixicon/remixicon.dart';
import '../../../core/res/app_strings.dart';
import '../../../core/utils/app_color.dart';
import '../../../core/widgets/form_text.dart';
import '../../../core/widgets/widgets_components.dart';
import '../../../providers/product_provider.dart';
import 'product_details_bottomsheet_widget.dart';

class SearchProductBottomsheetWidget extends StatefulWidget {
  const SearchProductBottomsheetWidget({super.key});

  @override
  State<SearchProductBottomsheetWidget> createState() => _SearchProductBottomsheetWidgetState();
}

class _SearchProductBottomsheetWidgetState extends State<SearchProductBottomsheetWidget> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return Container(
      padding:  EdgeInsets.all(16.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:  BorderRadius.vertical(top: Radius.circular(20.r)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(
            height: 20.h,
          ),
          WidgetComponents().buildHeader(context, "Search Product"),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FormText(
              controller: _searchController,
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  _searchController.clear();
                  productProvider.searchProducts('');  // Reset search
                },
              ),
              onFieldSubmitted: (value) => _performSearch(productProvider),
              textColor: AppColor.whiteTextColor,
              hintText: "Search products...",
              prefixIcon: const Icon(Remix.search_2_line),
            ),
          ),
          SizedBox(height: 10.h,),
          Expanded(
            child: _buildProductList(productProvider),
          ),
        ],
      ),
    );
  }

  void _performSearch(ProductProvider provider) {
    provider.searchProducts(_searchController.text.trim());
  }

  Widget _buildProductList(ProductProvider provider) {
    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (provider.error != null) {
      return Center(child: Text(provider.error!));
    } else if (provider.products.isEmpty) {
      return const Center(child: Text('No products found.'));
    } else {
      return ListView.builder(
        itemCount: provider.products.length,
        itemBuilder: (context, index) {
          final product = provider.products[index];
          return ListTile(
            leading: Container(
              width: 80,
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
                placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            title: Text(
              product.name,
              style: TextStyle(
                  fontSize: 15.sp,
                  fontFamily: AppStrings.poppins,
                  color: AppColor.greyColor9,
                  fontWeight: FontWeight.w600),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              'Price: \$${(product.price.toStringAsFixed(2))}',
              style: TextStyle(
                fontSize: 14.sp,
                fontFamily: AppStrings.poppins,
                color: AppColor.greyColor8,
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  useRootNavigator: true,
                  builder: (_) =>
                      ProductDetailsBottomSheet(
                          productId: product.id!));
            },
          );
        },
      );
    }
  }
}
