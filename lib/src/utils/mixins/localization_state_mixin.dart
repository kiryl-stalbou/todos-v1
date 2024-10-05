import 'package:flutter/material.dart';

import '../../l10n/s.dart';

mixin LocalizationStateMixin<T extends StatefulWidget> on State<T> {
  late S _s;
  S get s => _s;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _s = S.of(context);
  }
}
