import 'dart:math';
import 'package:location_tracker/models/location_collection.dart';

class DistanceService {
  // Earth's radius in kilometers
  final double R = 6371.0;

  // Static method for compute
  static double calculateTotalDistanceSync(List<LocationCollection> locations) {
    double totalDistance = 0.0;

    for (var i = 0; i < locations.length - 1; i++) {
      final start = locations[i];
      final end = locations[i + 1];

      totalDistance += _calculateDistanceBetweenPoints(
        start.latitude!,
        start.longitude!,
        end.latitude!,
        end.longitude!,
      );
    }

    return totalDistance;
  }

  // Helper function to calculate the distance between two points using the Haversine formula
  static double _calculateDistanceBetweenPoints(
      double lat1, double lon1, double lat2, double lon2) {
    // Convert degrees to radians
    double lat1Rad = _degToRad(lat1);
    double lon1Rad = _degToRad(lon1);
    double lat2Rad = _degToRad(lat2);
    double lon2Rad = _degToRad(lon2);

    // Haversine formula
    double dlat = lat2Rad - lat1Rad;
    double dlon = lon2Rad - lon1Rad;

    double a = pow(sin(dlat / 2), 2) +
        cos(lat1Rad) * cos(lat2Rad) * pow(sin(dlon / 2), 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    // Distance in kilometers
    return 6371 * c;  // R can be accessed directly since this is a static method
  }

  // Convert degrees to radians
  static double _degToRad(double degree) {
    return degree * pi / 180.0;
  }
}
