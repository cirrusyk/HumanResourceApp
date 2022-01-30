import 'package:flutter/material.dart';

extension ColorHelper on Color {
  Color operator +(Color other) => Color.alphaBlend(this, other);
}
