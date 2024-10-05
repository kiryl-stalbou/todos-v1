import 'package:flutter/material.dart';

class OverflowText extends StatelessWidget {
  const OverflowText(
    this.data, {
    this.style,
    this.maxLines,
    this.textAlign,
    this.fit,
    super.key,
  });

  final String data;
  final TextStyle? style;
  final int? maxLines;
  final FlexFit? fit;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    Widget body = Text(
      data,
      style: style,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: TextOverflow.ellipsis,
    );

    final fit = this.fit;
    if (fit != null) body = Flexible(fit: fit, child: body);

    return body;
  }
}

class OverflowRichText extends StatelessWidget {
  const OverflowRichText(
    this.data, {
    required this.maxLines,
    this.style,
    this.textAlign,
    this.fit,
    super.key,
  });

  final InlineSpan data;
  final TextStyle? style;
  final int maxLines;
  final FlexFit? fit;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    Widget body = Text.rich(
      data,
      style: style,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: TextOverflow.ellipsis,
    );

    final fit = this.fit;
    if (fit != null) body = Flexible(fit: fit, child: body);

    return body;
  }
}
