import 'dart:math';

Random _rand = Random();

int increasing = -9223372036854775807;

String uuid() {
  return _rand.nextInt(9223372036854775807).toString() + DateTime.now().toString() + (increasing++).toString();
}
