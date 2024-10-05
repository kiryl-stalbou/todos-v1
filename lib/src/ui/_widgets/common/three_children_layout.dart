// ignore_for_file: prefer_int_literals

import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../constants/sizes.dart';

class ThreeChildrenLayout extends StatelessWidget {
  const ThreeChildrenLayout({
    this.middleSpacing,
    this.leading,
    this.middle,
    this.trailing,
    super.key,
  });

  final Widget? leading;
  final Widget? middle;
  final Widget? trailing;
  final double? middleSpacing;

  @override
  Widget build(BuildContext context) {
    final leading = this.leading;
    final middle = this.middle;
    final trailing = this.trailing;

    return CustomMultiChildLayout(
      delegate: _ThreeChildrenLayoutDelegate(middleSpacing: middleSpacing ?? Insets.s),
      children: <Widget>[
        if (leading != null) LayoutId(id: _Slot.leading, child: leading),
        if (middle != null) LayoutId(id: _Slot.middle, child: middle),
        if (trailing != null) LayoutId(id: _Slot.trailing, child: trailing),
      ],
    );
  }
}

enum _Slot { leading, middle, trailing }

class _ThreeChildrenLayoutDelegate extends MultiChildLayoutDelegate {
  _ThreeChildrenLayoutDelegate({required this.middleSpacing});

  final double middleSpacing;

  double _center(double max, double value) => (max - value) / 2.0;

  @override
  void performLayout(Size size) {
    final looseConstraints = BoxConstraints.loose(size);

    double leadingWidth = 0;
    double trailingWidth = 0;

    if (hasChild(_Slot.leading)) {
      final leadingSize = layoutChild(_Slot.leading, looseConstraints);
      leadingWidth = leadingSize.width;
      const leadingX = 0.0;
      final leadingY = _center(size.height, leadingSize.height);
      positionChild(_Slot.leading, Offset(leadingX, leadingY));
    }

    if (hasChild(_Slot.trailing)) {
      final trailingMaxWidth = math.max(size.width - leadingWidth, 0.0);
      final trailingSize = layoutChild(_Slot.trailing, looseConstraints.copyWith(maxWidth: trailingMaxWidth));
      trailingWidth = trailingSize.width;
      final trailingX = size.width - trailingSize.width;
      final trailingY = _center(size.height, trailingSize.height);
      positionChild(_Slot.trailing, Offset(trailingX, trailingY));
    }

    if (hasChild(_Slot.middle)) {
      final middleMaxWidth = math.max(size.width - leadingWidth - trailingWidth - middleSpacing * 2.0, 0.0);
      final middleSize = layoutChild(_Slot.middle, looseConstraints.copyWith(maxWidth: middleMaxWidth));

      final middleStartMargin = leadingWidth + middleSpacing;

      double middleX = _center(size.width, middleSize.width);
      if (middleX + middleSize.width > size.width - trailingWidth) {
        middleX = size.width - trailingWidth - middleSize.width - middleSpacing;
      } else if (middleX < middleStartMargin) {
        middleX = middleStartMargin;
      }

      final middleY = _center(size.height, middleSize.height);

      positionChild(_Slot.middle, Offset(middleX, middleY));
    }
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) => false;
}
