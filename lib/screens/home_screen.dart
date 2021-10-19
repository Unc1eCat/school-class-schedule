import 'package:flutter/material.dart';
import 'package:school_class_schedule/widgets/timebar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: TimeBar(),
      ),
    );
  }
}