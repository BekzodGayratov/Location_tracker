import 'package:isar/isar.dart';
import 'package:location_tracker/models/location_collection.dart';
import 'package:location_tracker/models/timer_collection.dart';
import 'package:path_provider/path_provider.dart';

class DbHelper {
  static Future<Isar> getInstance() async {
    final i = Isar.getInstance();

    if (i != null && i.isOpen) {
      return i;
    }
    final dir = await getApplicationDocumentsDirectory();
    final newInstance = await Isar.open(
        [LocationCollectionSchema, TimerCollectionSchema],
        directory: dir.path);

    return newInstance;
  }
}
