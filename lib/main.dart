import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_class_schedule/bloc/app_bloc.dart';
import 'package:school_class_schedule/screens/home_screen.dart';
void main()
{
  runApp(TheApp());
}

class TheApp extends StatefulWidget {
  const TheApp({Key? key}) : super(key: key);

  @override
  State<TheApp> createState() => _TheAppState();
}

class _TheAppState extends State<TheApp> {
  AppBloc bloc = AppBloc();

  @override
  void initState() {
    super.initState();  
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppBloc>(
      create: (ctx) => bloc..loadFromAssets(DefaultAssetBundle.of(ctx)),
      child: MaterialApp(
        themeMode: ThemeMode.dark,
        darkTheme: ThemeData.dark(),
        routes: {
          '/': (ctx) => HomeScreen(),
        },
      ),
    );
  }
}