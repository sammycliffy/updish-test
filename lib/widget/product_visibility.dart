import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ProductVisibilityDetector extends StatelessWidget {
  final int index;
  final void Function(int index) onVisibilityChanged;
  final Widget child;

  const ProductVisibilityDetector({
    super.key,
    required this.index,
    required this.onVisibilityChanged,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('product-$index'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.1) {
          onVisibilityChanged(index);
        }
      },
      child: child,
    );
  }
}
