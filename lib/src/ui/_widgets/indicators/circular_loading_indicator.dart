import 'package:flutter/material.dart';

class CircularLoadingIndicator extends StatelessWidget {
  const CircularLoadingIndicator({required this.dimension, super.key});

  final double dimension;

  @override
  Widget build(BuildContext context) => RepaintBoundary(
        child: SizedBox.square(
          dimension: dimension,
          child: CircularProgressIndicator(
            strokeWidth: dimension / 12,
            strokeCap: StrokeCap.round,
          ),
        ),
      );
}
