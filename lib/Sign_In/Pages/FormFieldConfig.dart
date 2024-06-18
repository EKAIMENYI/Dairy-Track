import 'package:flutter/material.dart';

class FormFieldConfig {
  final String key;
  final String label;
  final TextInputType inputType;

  FormFieldConfig({
    required this.key,
    required this.label,
    this.inputType = TextInputType.text,
  });
}
