import 'package:flutter/material.dart';

enum AnalysisResult {
  negative(Icons.thumb_down, 'Negative Review', Color(0xFFD93F33)),
  positive(Icons.thumb_up, 'Positive Review', Color(0xFF43A047));

  const AnalysisResult(this.icon, this.label, this.color);
  final IconData icon;
  final String label;
  final Color color;
}
