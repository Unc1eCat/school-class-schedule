import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ScheduleItem extends Equatable {
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

  @override
  List<Object?> get props => [id];
}
