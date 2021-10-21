import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:school_class_schedule/bloc/app_bloc.dart';

class TimeBarChunk extends StatelessWidget {
  final String id;
  final double pixelsPerMinute;

  const TimeBarChunk({Key? key, required this.id, required this.pixelsPerMinute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bloc = AppBloc.of(context);
    var day = bloc.getDayOfWeekWithItemOfId(id)!;
    var model = day.firstWhere((e) => e.id == id);
    var index = day.indexOf(model);

    return SizedBox(
      height: day[index + 1].begins.difference(model.begins).inMinutes * pixelsPerMinute,
      // width: 90,
      child: Row(
        // mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: model.color,
                borderRadius: BorderRadiusDirectional.circular(8),
              ),
              child: const SizedBox(
                width: 80,
                height: double.infinity,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Stack(
              children: [
                Transform.translate(
                  offset: Offset(0, -7),
                  child: Text(
                    "${model.begins.hour.toString().padLeft(2, "0")}:${model.begins.minute.remainder(60).toString().padLeft(2, "0")}",
                    style: Theme.of(context).textTheme.headline6!.copyWith(color: model.color),
                  ),
                ),
                Align(
                  alignment: Alignment(-0.62, 0),
                  child: Text(model.title, style: Theme.of(context).textTheme.headline4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
