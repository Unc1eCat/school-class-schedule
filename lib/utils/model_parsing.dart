import 'dart:ui';

import 'package:school_class_schedule/models/schedule_item.dart';
import 'dart:convert' as cnv;

List<List<ScheduleItem>> readScheduleItems(String input) {
    var json = cnv.jsonDecode(input);
    var ret = [<ScheduleItem>[], <ScheduleItem>[], <ScheduleItem>[], <ScheduleItem>[], <ScheduleItem>[], <ScheduleItem>[], <ScheduleItem>[]];

    if (json['scheduleItems'].length != 7) throw ArgumentError('The JSON top level list length is not equal to amount of days in a week though the list represents a week');

    try {
      for (var j = 0; j < 7; j++) {
        for (var i in json['scheduleItems'][j]) {
          var id = i['id'] ?? DateTime.now().toString();
          var title = i['title'];
          var color = Color(i['color']);
          var begins = DateTime.parse("1970-01-01 " + i['begins'] + ":00");

          ret[j].add(ScheduleItem(id: id, begins: begins, color: color, title: title));
        }
      }
    } catch (e) {
      print("Unable to parse schedule items from file.");
      rethrow;
    }

    return ret;
  }