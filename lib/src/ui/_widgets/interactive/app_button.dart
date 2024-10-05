import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../../constants/sizes.dart';
import '../../../utils/mixins/theme_state_mixin.dart';
import '../../_loading/local/local_loading.dart';
import '../indicators/circular_loading_indicator.dart';

class AppButton extends StatefulWidget {
  const AppButton({
    required this.child,
    this.listenLocalLoading = false,
    this.width = Buttons.lWidth,
    this.height = Buttons.lHeight,
    this.borderSide = BorderSide.none,
    this.splashColor = AppColors.white26,
    this.disabledColor = AppColors.disabled,
    this.borderRadius = Corners.sBorderRadius,
    this.color,
    this.onTap,
    this.margin,
    super.key,
  });

  final Widget child;
  final double height;
  final double width;
  final bool listenLocalLoading;
  final Color disabledColor;
  final BorderSide borderSide;
  final BorderRadius borderRadius;
  final Color? color;
  final Color? splashColor;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? margin;

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> with ThemeStateMixin {
  @override
  Widget build(BuildContext context) {
    final isLoading = widget.listenLocalLoading && LocalLoading.isLoadingOf(context);
    final isDisabled = isLoading || widget.onTap == null;
    final color = isDisabled ? widget.disabledColor : (widget.color ?? colorScheme.primary);
    final onTap = isDisabled ? null : widget.onTap;

    final child = isLoading ? CircularLoadingIndicator(dimension: widget.height * 0.55) : widget.child;

    Widget body = SizedBox(
      width: widget.width,
      height: widget.height,
      child: RepaintBoundary(
        child: Material(
          color: color,
          shape: RoundedRectangleBorder(borderRadius: widget.borderRadius, side: widget.borderSide),
          child: InkWell(
            onTap: onTap,
            borderRadius: widget.borderRadius,
            splashColor: widget.splashColor,
            highlightColor: widget.splashColor,
            focusColor: widget.splashColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Insets.l),
              child: Center(
                child: DefaultTextStyle(
                  style: textTheme.bodyMedium?.copyWith(color: colorScheme.onPrimary, fontWeight: FontWeight.w600) ?? const TextStyle(),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  child: child,
                ),
              ),
            ),
          ),
        ),
      ),
    );

    final padding = widget.margin;
    if (padding != null) body = Padding(padding: padding, child: body);

    return body;
  }
}
