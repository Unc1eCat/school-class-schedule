import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:school_class_schedule/bloc/app_bloc.dart';
import 'package:school_class_schedule/screens/home_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void main() {
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
      create: (ctx) => bloc,
      child: MaterialApp(
        themeMode: ThemeMode.dark,
        darkTheme: ThemeData.dark().copyWith(
          textTheme: TextTheme(
            headline4: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            headline6: TextStyle(fontSize: 18),
            bodyText2: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
          primaryColor: Colors.blueAccent[700],
        ),
        routes: {
          '/': (ctx) => HomeScreen(),
        },
      ),
    );
  }
}
