import 'dart:ui';

import 'package:school_class_schedule/models/schedule_item.dart';
import 'dart:convert' as cnv;

List<List<ScheduleItem>> readScheduleItems(String input) {
    var json = cnv.jsonDecode(input);
    var ret = const [<ScheduleItem>[], <ScheduleItem>[], <ScheduleItem>[], <ScheduleItem>[], <ScheduleItem>[], <ScheduleItem>[], <ScheduleItem>[]];

    if (json['scheduleItems'].length != 7) throw ArgumentError('The JSON top level list length is not equal to amount of days in a week though the list represents a week');

    try {
      for (var j in ret) {
        for (var i in json['scheduleItems'][j]) {
          var id = i['id'] ?? DateTime.now().toString();
          var title = i['title'];
          var color = Color(i['color']);
          var begins = DateTime.parse(i['begins']);

          j.add(ScheduleItem(id: id, begins: begins, color: color, title: title));
        }
      }
    } catch (e) {
      print("Unable to parse schedule items from file.");
      rethrow;
    }

    return ret;
  }