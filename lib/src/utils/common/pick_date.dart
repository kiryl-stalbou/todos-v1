import 'package:flutter/material.dart';

Future<DateTime?> pickDate(BuildContext context) => showDatePicker(
      context: context,
      firstDate: DateTime.parse('2024-00-00'),
      lastDate: DateTime.parse('9999-00-00'),
    );
