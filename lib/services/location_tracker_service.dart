import 'dart:async';
import 'package:background_locator_2/background_locator.dart';
import 'package:background_locator_2/location_dto.dart';
import 'package:background_locator_2/settings/android_settings.dart';
import 'package:background_locator_2/settings/ios_settings.dart';
import 'package:background_locator_2/settings/locator_settings.dart';
import 'package:location_tracker/models/location_collection.dart';
import 'package:location_tracker/services/location_cache_service.dart';
import 'package:logger/logger.dart';

class LocationTrackingService {
  static final logger = Logger();
  static final LocationCacheService _locationCacheService =
      LocationCacheService();

  @pragma('vm:entry-point')
  static void backgroundLocationCallBack(LocationDto locationDto) async {
    try {
      await _locationCacheService.init();
      await _handleLocationUpdate(locationDto);
    } catch (e) {
      logger.e(e);
    }
  }

  static Future<void> _handleLocationUpdate(LocationDto locationDto) async {
    try {
      await _cacheLocation(
          lat: locationDto.latitude,
          long: locationDto.longitude,
          speed: locationDto.speed);
    } catch (e) {
      logger.e('HANDLE LOCATION UPDATE ERROR: ${e.toString()}');
    }
  }

  Future<void> initPlatformState() async {
    try {
      await BackgroundLocator.initialize();
      await BackgroundLocator.registerLocationUpdate(backgroundLocationCallBack,
          autoStop: false,
          androidSettings: const AndroidSettings(
              accuracy: LocationAccuracy.NAVIGATION,
              distanceFilter: 5,
              androidNotificationSettings: AndroidNotificationSettings(
                  notificationTitle: 'Location tracking is active'),
              interval: 5,
              wakeLockTime: 600),
          iosSettings: const IOSSettings(
            stopWithTerminate: false,
            accuracy: LocationAccuracy.NAVIGATION,
            distanceFilter: 5,
            showsBackgroundLocationIndicator: true,
          ));
    } catch (e) {
      logger.e('INIT PLATFORM STATE ERROR: ${e.toString()}');
    }
  }

  Future<void> stop() async {
    try {
      await BackgroundLocator.unRegisterLocationUpdate();
    } catch (e) {
      logger.e('STOP ERROR: ${e.toString()}');
    }
  }

  static Future<void> _cacheLocation(
      {required double lat,
      required double long,
      required double speed}) async {
    try {
      logger.i('RECEIVED UPDATE: $lat $long $speed');
      final currentTime = DateTime.now().toUtc();

      final cachedLocation = LocationCollection()
        ..latitude = lat
        ..longitude = long
        ..speed = speed
        ..createdAt = currentTime;

      await _locationCacheService.insertLocation(cachedLocation);
    } catch (e) {
      logger.e('CACHE LOCATION ERROR: ${e.toString()}');
    }
  }
}
