import 'package:flutter/widgets.dart';
import 'package:school_class_schedule/bloc/app_bloc.dart';

class TimeBarChunk extends StatelessWidget {
  final String id;

  const TimeBarChunk({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var model = AppBloc.of(context).getScheduleItemOfId(id)!;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: model.color,
        borderRadius: BorderRadiusDirectional.circular(8),
      ),
      child: SizedBox(
        width: 90,
        height: model.begins,
      ),
    );
  }
}
