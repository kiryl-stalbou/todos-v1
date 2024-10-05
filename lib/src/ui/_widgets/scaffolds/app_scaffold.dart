import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    required this.body,
    this.resizeToAvoidBottomInset = false,
    this.extendBodyBehindTop = false,
    this.extendBodyBehindBottom = false,
    this.color,
    this.top,
    this.bottom,
    this.statusBar,
    super.key,
  });

  final Widget body;
  final bool extendBodyBehindTop;
  final bool extendBodyBehindBottom;
  final bool resizeToAvoidBottomInset;
  final Color? color;
  final Widget? top;
  final Widget? bottom;
  final Widget? statusBar;

  void _addIfNotNull(
    BuildContext context,
    List<LayoutId> children,
    Widget? child,
    Object childId, {
    required bool removeTopPadding,
    required bool removeBottomPadding,
    bool removeBottomViewInset = false,
    bool maintainBottomViewPadding = false,
  }) {
    if (child == null) return;

    var data = MediaQuery.of(context).removePadding(
      removeLeft: true,
      removeRight: true,
      removeTop: removeTopPadding,
      removeBottom: removeBottomPadding,
    );

    if (removeBottomViewInset) data = data.removeViewInsets(removeBottom: true);

    if (maintainBottomViewPadding && data.viewInsets.bottom != 0.0) {
      data = data.copyWith(padding: data.padding.copyWith(bottom: data.viewPadding.bottom));
    }

    children.add(LayoutId(id: childId, child: MediaQuery(data: data, child: child)));
  }

  @override
  Widget build(BuildContext context) {
    final children = <LayoutId>[];

    _addIfNotNull(
      context,
      children,
      body,
      _ScaffoldSlot.body,
      removeTopPadding: top != null,
      removeBottomPadding: bottom != null,
      removeBottomViewInset: resizeToAvoidBottomInset,
      maintainBottomViewPadding: !resizeToAvoidBottomInset,
    );

    if (top != null) {
      _addIfNotNull(
        context,
        children,
        top,
        _ScaffoldSlot.top,
        removeTopPadding: false,
        removeBottomPadding: true,
      );
    }

    if (bottom != null) {
      _addIfNotNull(
        context,
        children,
        bottom,
        _ScaffoldSlot.bottom,
        removeTopPadding: true,
        removeBottomPadding: false,
        maintainBottomViewPadding: !resizeToAvoidBottomInset,
      );
    }

    if (statusBar != null) {
      _addIfNotNull(
        context,
        children,
        statusBar,
        _ScaffoldSlot.statusBar,
        removeTopPadding: true,
        removeBottomPadding: true,
      );
    }

    final padding = MediaQuery.paddingOf(context).copyWith(
      bottom: resizeToAvoidBottomInset ? MediaQuery.viewInsetsOf(context).bottom : 0,
    );

    return ColoredBox(
      color: color ?? Theme.of(context).scaffoldBackgroundColor,
      child: CustomMultiChildLayout(
        delegate: _ScaffoldLayout(
          padding: padding,
          extendBodyBehindTop: extendBodyBehindTop,
          extendBodyBehindBottom: extendBodyBehindBottom,
        ),
        children: children,
      ),
    );
  }
}

enum _ScaffoldSlot { statusBar, top, body, bottom }

class _ScaffoldLayout extends MultiChildLayoutDelegate {
  _ScaffoldLayout({
    required this.padding,
    required this.extendBodyBehindTop,
    required this.extendBodyBehindBottom,
  });

  final EdgeInsets padding;
  final bool extendBodyBehindTop;
  final bool extendBodyBehindBottom;

  @override
  void performLayout(Size size) {
    final safeWidthConstraints = BoxConstraints(
      minWidth: size.width - padding.horizontal,
      maxWidth: size.width - padding.horizontal,
      minHeight: 0,
      maxHeight: size.height,
    );

    double bodyHeight = size.height;
    double bodyYOffset = 0;

    if (hasChild(_ScaffoldSlot.top)) {
      final topHeight = layoutChild(_ScaffoldSlot.top, safeWidthConstraints).height;
      bodyHeight -= extendBodyBehindTop ? 0 : topHeight;
      bodyYOffset += extendBodyBehindTop ? 0 : topHeight;
      positionChild(_ScaffoldSlot.top, Offset(padding.left, 0));
    }

    if (hasChild(_ScaffoldSlot.bottom)) {
      final bottomHeight = layoutChild(_ScaffoldSlot.bottom, safeWidthConstraints).height;
      bodyHeight -= extendBodyBehindBottom ? 0 : bottomHeight;
      positionChild(_ScaffoldSlot.bottom, Offset(padding.left, size.height - bottomHeight - padding.bottom));
    }

    if (hasChild(_ScaffoldSlot.body)) {
      layoutChild(_ScaffoldSlot.body, safeWidthConstraints.tighten(height: bodyHeight - padding.bottom));
      positionChild(_ScaffoldSlot.body, Offset(padding.left, bodyYOffset));
    }

    if (hasChild(_ScaffoldSlot.statusBar)) {
      layoutChild(_ScaffoldSlot.statusBar, safeWidthConstraints.tighten(height: padding.top));
      positionChild(_ScaffoldSlot.statusBar, Offset(padding.left, 0));
    }
  }

  @override
  bool shouldRelayout(_ScaffoldLayout oldDelegate) =>
      oldDelegate.padding != padding || oldDelegate.extendBodyBehindTop != extendBodyBehindTop || oldDelegate.extendBodyBehindBottom != extendBodyBehindBottom;
}
