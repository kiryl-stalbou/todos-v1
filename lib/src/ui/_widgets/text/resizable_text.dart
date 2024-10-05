import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/widgets.dart';

class ResizableText extends StatelessWidget {
  const ResizableText(
    this.data, {
    required this.minFontSize,
    required this.style,
    this.fit,
    this.maxLines,
    this.textAlign,
    super.key,
  });

  final String data;
  final double minFontSize;
  final TextStyle? style;
  final FlexFit? fit;
  final int? maxLines;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    Widget body = AutoSizeText(
      data,
      style: style,
      maxLines: maxLines,
      maxFontSize: style?.fontSize ?? double.infinity,
      minFontSize: minFontSize,
      textAlign: textAlign,
      overflow: TextOverflow.ellipsis,
    );

    final fit = this.fit;
    if (fit != null) body = Flexible(fit: fit, child: body);

    return body;
  }
}
