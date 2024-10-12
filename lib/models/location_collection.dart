import 'package:isar/isar.dart';

part 'location_collection.g.dart';

@collection
class LocationCollection {
  Id id = Isar.autoIncrement;

  double? latitude;

  double? longitude;

  double? speed;

  DateTime? createdAt;
}
