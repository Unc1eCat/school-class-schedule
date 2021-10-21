import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:school_class_schedule/bloc/app_bloc.dart';
import 'package:school_class_schedule/widgets/timebar_chunk.dart';
import 'package:intl/intl.dart' hide TextDirection;

class TimeBar extends StatefulWidget {
  const TimeBar({Key? key}) : super(key: key);

  @override
  State<TimeBar> createState() => _TimeBarState();
}

class _TimeBarState extends State<TimeBar> with TickerProviderStateMixin {
  AnimationController? _scaleController;

  @override
  void initState() {
    _scaleController = AnimationController(vsync: this, duration: Duration(milliseconds: 10));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var bloc = AppBloc.of(context);
    var timeAnimation = RelativeRectTween(begin: RelativeRect.fromLTRB(0, -5, 0, 0), end: RelativeRect.fromLTRB(0, 5 * 60 * 24 - 5, 0, 0)).animate(bloc.timeController!);
    var curTimeStyle = Theme.of(context).textTheme.headline6!.copyWith(color: Theme.of(context).primaryColor);

    return BlocBuilder<AppBloc, AppState>(
      bloc: bloc,
      builder: (context, state) => AnimatedSwitcher(
        duration: Duration(milliseconds: 600),
        transitionBuilder: (child, anim) => FadeTransition(
          opacity: anim,
          child: child,
        ),
        child: state is AppStateScheduleItemsLoaded
            ? SingleChildScrollView(
                padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 16, left: 8, right: 16, bottom: 16),
                physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                child: GestureDetector(
                  onScaleUpdate: (details) => _scaleController!.value = details.verticalScale,
                  child: AnimatedBuilder(
                    animation: _scaleController!,
                    builder: (context, state) => SizedBox(
                        width: 200,
                        height: 6000,
                        child: Stack(
                          alignment: Alignment.topLeft,
                          children: [
                            Positioned.fill(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 2.0),
                                child: CustomPaint(
                                  painter: TimeScalePainter(
                                      timePerStroke: const Duration(minutes: 5),
                                      strokesPerBigStroke: 6,
                                      pixelsPerStroke: 25,
                                      color: Colors.grey[400]!,
                                      strokesBeforeFirstBig: 3,
                                      beginningTime: const Duration(hours: 8, minutes: 15),
                                      style: Theme.of(context).textTheme.bodyText2!),
                                ),
                              ),
                            ),
                            PositionedTransition(
                              rect: timeAnimation,
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Transform.translate(
                                  offset: Offset(0, -8),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(2),
                                    child: ColoredBox(
                                      color: Theme.of(context).canvasColor,
                                      child: AnimatedBuilder(
                                        animation: timeAnimation,
                                        builder: (context, ch) => Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Text("${DateTime.now().hour.toString().padLeft(2, "0")}:${DateTime.now().minute.remainder(60).toString().padLeft(2, "0")}",
                                              style: curTimeStyle),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            PositionedTransition(
                              rect: timeAnimation,
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 44.0),
                                  child: DecoratedBox(
                                    child: SizedBox(width: double.infinity, height: 8),
                                    decoration: BoxDecoration(borderRadius: BorderRadiusDirectional.circular(3), color: Theme.of(context).primaryColor),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 12,
                              left: 60,
                              top: 0,
                              child: Column(
                                children: bloc.scheduleItems[0]
                                    .map((e) => TimeBarChunk(
                                          id: e.id,
                                          pixelsPerMinute: 5,
                                          backgroundColor: Theme.of(context).canvasColor,
                                        ))
                                    .toList()
                                  ..removeLast(),
                              ),
                            ),
                          ],
                        ),
                      )
                  ),
                ),
              )
            : SpinKitRotatingPlain(color: Theme.of(context).cardColor),
      ),
    );
  }
}

class TimeScalePainter extends CustomPainter {
  final double pixelsPerStroke;
  final Duration timePerStroke;
  final int strokesPerBigStroke;
  final int strokesBeforeFirstBig;
  final Duration beginningTime;
  final TextStyle style;
  final Color color;

  TimeScalePainter({
    required this.style,
    required this.beginningTime,
    required this.strokesBeforeFirstBig,
    required this.timePerStroke,
    required this.strokesPerBigStroke,
    required this.pixelsPerStroke,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size s) {
    var small = Paint()
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1.2
      ..color = color;
    var big = Paint()
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2.5
      ..color = color;
    var tp = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.end,
    );

    var smallUntilBig = strokesBeforeFirstBig;
    var currentTime = beginningTime;

    for (var i = 0.0; i < 24.0 * 60.0 * pixelsPerStroke / timePerStroke.inMinutes; i += pixelsPerStroke) {
      if (smallUntilBig == 0) // Draw big
      {
        canvas.drawLine(Offset(s.width - 3, i), Offset(36, i), big);
        smallUntilBig = strokesPerBigStroke - 1;

        tp.text = TextSpan(
          text: "${currentTime.inHours.toString().padLeft(2, "0")}:${currentTime.inMinutes.remainder(60).toString().padLeft(2, "0")}", // currentTime.toString().substring(0, 4),
          style: style.copyWith(color: color),
        );
        tp.layout();
        tp.paint(canvas, Offset(0, i - style.fontSize! / 2 / (style.height ?? 0.9)));
      } else {
        // Draw small
        canvas.drawLine(Offset(s.width - 3, i), Offset(46, i), small);
        smallUntilBig--;
      }
      currentTime += timePerStroke;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
