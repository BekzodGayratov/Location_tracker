import 'package:isar/isar.dart';
import 'package:location_tracker/models/location_collection.dart';
import 'package:location_tracker/services/db_helper.dart';

class LocationCacheService {
  Isar? _instance;

  Future<void> init() async {
    _instance = await DbHelper.getInstance();
  }

  Stream<List<LocationCollection>> watchLocations() {
    final query = _instance?.locationCollections.where().build();
    return query!.watch();
  }

  Future<int> getCount() async {
    final count = await _instance!.locationCollections.count();
    return count;
  }

  Future<List<LocationCollection>> getLocations() async {
    final locations = await _instance!.locationCollections.where().findAll();
    return locations;
  }

  Future<void> insertLocation(LocationCollection location) async {
    await _instance!.writeTxn(() async {
      await _instance!.locationCollections.put(location);
    });
  }

  Future<void> deleteLocations() async {
    await _instance!.writeTxn(() async {
      await _instance!.locationCollections.where().deleteAll();
    });
  }

  Future<void> deleteById(int id) async {
    await _instance!.writeTxn(() async {
      await _instance!.locationCollections.delete(id);
    });
  }
}
