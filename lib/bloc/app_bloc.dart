import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_class_schedule/models/schedule_item.dart';
import 'package:school_class_schedule/utils/model_parsing.dart' as mp;
import 'package:school_class_schedule/utils/ticker_provider_mixin.dart';

class AppBloc extends Cubit<AppState> with TickerProviderMixin {
  static AppBloc of(BuildContext context) => BlocProvider.of<AppBloc>(context);

  // The ones that are displayed in the Timebar for each day of a week starting on Monday
  // All items must begin in the same day
  List<List<ScheduleItem>> _scheduleItems = [[], [], [], [], [], [], []];

  AnimationController? timeController;
  Stream<void>? clockStream;

  List<List<ScheduleItem>> get scheduleItems => List.unmodifiable(_scheduleItems);

  AppBloc() : super(AppState()) {
    loadFromAssets(rootBundle);
    clockStream = Stream.periodic(Duration(seconds: 3));
    timeController = AnimationController(vsync: this, duration: Duration(seconds: 3));
    clockStream?.listen((event) {
      DateTime now = DateTime.now();
      timeController?.animateTo((now.hour * 60 * 60 + now.minute * 60 + now.second - 8 * 60 * 60 - 15 * 60).toDouble() / 60.0 / 60.0 / 24.0);
    });
  }

  void loadFromAssets(AssetBundle assets) async {
    _scheduleItems = mp.readScheduleItems(await assets.loadString('assets/models/schedule_items.json'));

    emit(AppStateScheduleItemsLoaded());
  }

  ScheduleItem? getScheduleItemOfId(String id) {
    for (var i in _scheduleItems) {
      var it = i.where((e) => e.id == id);

      if (it.isNotEmpty) return it.first;
    }

    return null;
  }

  List<ScheduleItem>? getDayOfWeekWithItemOfId(String id) {
    for (var i in _scheduleItems) {
      if (i.where((e) => e.id == id).isNotEmpty) return i;
    }
  }
}

class AppState {
  // TODO: Equatable...
  @override
  bool operator ==(Object other) => false;
}

class AppStateScheduleItemsLoaded extends AppState {}
