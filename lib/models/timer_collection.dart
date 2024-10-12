import 'package:isar/isar.dart';

part 'timer_collection.g.dart';

@collection
class TimerCollection {
  
  @Index(unique: true)
  Id id = 1;

  late int seconds; // Store the total accumulated seconds
}
