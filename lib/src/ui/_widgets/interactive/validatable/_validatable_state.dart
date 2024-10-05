import 'package:flutter/material.dart';

abstract class ValidatableState<S extends StatefulWidget> extends State<S> {
  bool isValid();
}
