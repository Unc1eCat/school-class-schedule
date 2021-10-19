import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:school_class_schedule/screens/home_screen.dart';

void main()
{
  runApp(TheApp());
}

class TheApp extends StatelessWidget {
  const TheApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(),
      routes: {
        '/': (ctx) => HomeScreen(),
      },
    );
  }
}