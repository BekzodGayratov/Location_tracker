import 'package:isar/isar.dart';
import 'package:location_tracker/models/timer_collection.dart';
import 'package:location_tracker/services/db_helper.dart';

class TimerCacheService {
  Future<void> init() async {
    _instance = await DbHelper.getInstance();
  }

  Isar? _instance;

  // Get the current stored seconds
  Future<int> getSeconds() async {
    final timer = await _instance?.timerCollections.get(1); // Fetch by fixed ID
    return timer?.seconds ?? 1; // Return 0 if no record exists
  }

  Stream<List<TimerCollection>>? watchLocations() {
    final query = _instance?.timerCollections.where().build();
    return query?.watch();
  }

  // Update the seconds (increment by adding new seconds)
  Future<void> incrementSeconds(int secondsToAdd) async {
    await _instance?.writeTxn(() async {
      final timer = await _instance?.timerCollections.get(1);

      if (timer != null) {
        timer.seconds += secondsToAdd; // Increment existing seconds
        await _instance?.timerCollections.put(timer); // Save the updated value
      } else {
        // Initialize if not found
        final newTimer = TimerCollection()..seconds = secondsToAdd;
        await _instance?.timerCollections.put(newTimer);
      }
    });
  }

  // Reset or delete the seconds record
  Future<void> resetSeconds() async {
    await _instance?.writeTxn(() async {
      await _instance?.timerCollections.delete(1); // Delete the fixed ID record
    });
  }
}
