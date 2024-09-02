import 'package:flutter/material.dart';
import 'dart:math' as math;

class EcommerceLoadingIndicator extends StatefulWidget {
  final Color color;
  final double size;

  const EcommerceLoadingIndicator({super.key, required this.color, required this.size});

  @override
  State<EcommerceLoadingIndicator> createState() => _EcommerceLoadingIndicatorState();
}

class _EcommerceLoadingIndicatorState extends State<EcommerceLoadingIndicator> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    _rotationAnimation = Tween<double>(begin: 0, end: 2 * math.pi).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 1.0, curve: Curves.linear),
      ),
    );

    _bounceAnimation = Tween<double>(begin: 0, end: 10).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 1.0, curve: Curves.easeInOut),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, -_bounceAnimation.value),
            child: Transform.rotate(
              angle: _rotationAnimation.value,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Icon(
                    Icons.shopping_bag_outlined,
                    size: widget.size,
                    color: widget.color,
                  ),
                  Positioned(
                    top: widget.size * 0.2,
                    child: Icon(
                      Icons.add_shopping_cart,
                      size: widget.size * 0.4,
                      color: widget.color.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}