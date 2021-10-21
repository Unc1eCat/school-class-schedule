import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:school_class_schedule/bloc/app_bloc.dart';

class TimeBarChunk extends StatelessWidget {
  final String id;
  final double pixelsPerMinute;
  final Color backgroundColor;

  const TimeBarChunk({Key? key, required this.id, required this.pixelsPerMinute, required this.backgroundColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bloc = AppBloc.of(context);
    var day = bloc.getDayOfWeekWithItemOfId(id)!;
    var model = day.firstWhere((e) => e.id == id);
    var index = day.indexOf(model);

    return SizedBox(
      height: day[index + 1].begins.difference(model.begins).inMinutes * pixelsPerMinute,
      // width: 90,
      child: Stack(
        // clipBehavior: Clip.none,
        // mainAxisSize: MainAxisSize.min,
        // crossAxisAlignment: CrossAxisAlignment.start,
        fit: StackFit.loose,
        children: [
          Positioned(
            // padding: const EdgeInsets.only(bottom: 4.0, left: 64),
            right: 0,
            top: 0,
            bottom: 0,
            left: 68,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: model.color,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5)),
                ),
                child: SizedBox(
                  width: 80,
                  height: double.infinity,
                  child: Align(
                    alignment: Alignment(0, 0),
                    child: Text(model.title, style: Theme.of(context).textTheme.headline4),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            child: Transform.translate(
              offset: Offset(0, -10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(2),
                child: ColoredBox(
                  color: backgroundColor,
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text(
                      "${model.begins.hour.toString().padLeft(2, "0")}:${model.begins.minute.remainder(60).toString().padLeft(2, "0")}",
                      style: Theme.of(context).textTheme.headline6!.copyWith(color: model.color),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 46,
            right: 0,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: model.color,
                borderRadius: BorderRadiusDirectional.circular(8),
              ),
              child: SizedBox(
                width: double.infinity,
                height: 4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
