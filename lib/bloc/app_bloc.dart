import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_class_schedule/models/schedule_item.dart';
import 'package:school_class_schedule/utils/model_parsing.dart' as mp;

class AppBloc extends Cubit {
  static AppBloc of(BuildContext context) => BlocProvider.of<AppBloc>(context);

  // The ones that are displayed in the Timebar for each day of a week starting on Monday
  late List<List<ScheduleItem>> scheduleItems;
  
  AppBloc() : super(AppState());

  
  void loadFromAssets(AssetBundle assets) async
  {
    scheduleItems = mp.readScheduleItems(await assets.loadString('assets/models/shedule_items.json'));

    emit(AppStateScheduleItemsLoaded());
  }

  ScheduleItem? getScheduleItemOfId(String id)
  {
    for (var i in scheduleItems)
    {
      var it = i.where((e) => e.id == id);

      if (it.isNotEmpty) return it.first;
    }
    
    return null;
  }
}

class AppState
{
  // TODO: Equatable... 
  @override
  bool operator ==(Object other) => false;
}

class AppStateScheduleItemsLoaded extends AppState
{
  
}