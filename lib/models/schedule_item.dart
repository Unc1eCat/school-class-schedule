import 'package:flutter/material.dart';

class ScheduleItem {
  final String id;
  final String title;
  final DateTime begins;
  final Color color;

  ScheduleItem({
    this.color = Colors.blue,
    String? id,
    this.title = "",
    required this.begins,
  }) : id = id ?? DateTime.now().toString();
}
