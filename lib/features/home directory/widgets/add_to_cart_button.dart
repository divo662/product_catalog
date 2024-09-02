import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_catalog_app/providers/product_provider.dart';
import '../../../core/res/app_strings.dart';
import '../../../core/utils/app_color.dart';
import '../../../models/product_models.dart';

class AddToCartButton extends StatefulWidget {
  final ProductProvider provider;
  final Product product;

  const AddToCartButton({
    super.key,
    required this.provider,
    required this.product,
  });

  @override
  State<AddToCartButton> createState() => _AddToCartButtonState();
}

class _AddToCartButtonState extends State<AddToCartButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isLoading = false;
  bool _isError = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onPressed() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
      _isError = false;
    });

    try {
      await widget.provider.toggleCart(widget.product.id!);
    } catch (error) {
      setState(() {
        _isError = true;
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
      _controller.forward().then((_) => _controller.reverse());
    }
  }

  @override
  Widget build(BuildContext context) {
    final isAdded = widget.provider.isInCart(widget.product.id!);
    final color = isAdded ? Colors.black : AppColor.primaryColor;

    return GestureDetector(
      onTap: _onPressed,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 230.w,
          height: 55.h,
          decoration: BoxDecoration(
            color: _isLoading ? Colors.grey : (_isError ? Colors.red : color),
            borderRadius: BorderRadius.circular(25.r),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(25.r),
              onTap: _onPressed,
              child: Center(
                child: _isLoading
                    ? SizedBox(
                        width: 24.w,
                        height: 24.h,
                        child: const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      )
                    : Text(
                        isAdded ? "Remove from Cart" : "Add to Cart",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: AppStrings.poppins,
                            fontSize: 16.sp),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
