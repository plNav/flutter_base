import 'package:flutter/material.dart';

enum DocumentStatus {
  draft(0, 'Draft', Colors.orange),
  review(1, 'In Review', Colors.yellow),
  approved(2, 'Approved', Colors.green),
  rejected(3, 'Rejected', Colors.red),
  archived(4, 'Archived', Colors.blue);

  final int level;
  final String label;
  final Color displayColor;

  Color get defaultColor => Colors.grey;

  const DocumentStatus(this.level, this.label, this.displayColor);
}
