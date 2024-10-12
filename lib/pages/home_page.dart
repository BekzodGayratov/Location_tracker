import 'dart:async';

import 'package:background_locator_2/background_locator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:location_tracker/models/location_collection.dart';
import 'package:location_tracker/services/distance_service.dart';
import 'package:location_tracker/services/foreground_service.dart';
import 'package:location_tracker/services/location_cache_service.dart';
import 'package:location_tracker/services/location_tracker_service.dart';
import 'package:location_tracker/services/timer_cache_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final LocationTrackingService _locationTrackingService =
      LocationTrackingService();

  final LocationCacheService _locationCacheService = LocationCacheService();
  final TimerCacheService _timerCacheService = TimerCacheService();
  StreamSubscription<List<LocationCollection>>? _locationSubscription;

  num _currentSpeed = 0;

  num _totalKm = 0;

  Duration _timer = const Duration();

  void _startLocationTracking() async {
    await _locationTrackingService.initPlatformState();
  }

  void _stopLocationTracking() async {
    await BackgroundLocator.unRegisterLocationUpdate();
    await _locationTrackingService.stop();
  }

  void handleSpeed() {
   
    if (_currentSpeed > 30) {
      _stopTimerService();
    } else {
      _startTimerService();
    }
  }

  Future<void> listenLocationUpdate() async {
    _locationSubscription =
        _locationCacheService.watchLocations().listen((locations) async {
      if (locations.isNotEmpty) {
        _currentSpeed = (locations.last.speed ?? 0) * 3.6;
        handleSpeed();
      }
      final total =
          await compute(DistanceService.calculateTotalDistanceSync, locations);
      _totalKm = double.parse(total.toStringAsFixed(
          2)); // USED compute method TO PREVENT UI FREE WHEN CALCULATE TONS OF LOCATIONS
      setState(() {});
    });
  }

  void _onReceiveTaskData(Object data) async {
    if (data is int) {
      setState(() {
        _timer = Duration(seconds: data);
      });
    }
  }

  Future<void> initDB() async {
    await _locationCacheService.init();
    await _timerCacheService.init();
  }

  Future<void> getSeconds() async {
    final seconds = await _timerCacheService.getSeconds();
    _timer = Duration(seconds: seconds);
    setState(() {});
  }

  Future<void> getLocations() async {
    final locations = await _locationCacheService.getLocations();
    final total =
        await compute(DistanceService.calculateTotalDistanceSync, locations);
    _totalKm = double.parse(total.toStringAsFixed(
        2)); // USED compute method TO PREVENT UI FREE WHEN CALCULATE TONS OF LOCATIONS
    setState(() {});
  }

  @override
  void initState() {
    initDB().then((v) {
      if (_currentSpeed < 30) {
        _startTimerService();
      }
      listenLocationUpdate();
      getSeconds();
      getLocations();
      FlutterForegroundTask.addTaskDataCallback(_onReceiveTaskData);
    });

    super.initState();
  }

  @override
  void dispose() {
    FlutterForegroundTask.removeTaskDataCallback(_onReceiveTaskData);
    _locationSubscription?.cancel().then((v) => _locationSubscription = null);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location tracker'),
        actions: [
          TextButton(
              onPressed: () {
                _currentSpeed = 0;
                _locationCacheService.deleteLocations();
                _timerCacheService.resetSeconds();
                _timer = const Duration();
                setState(() {});
              },
              child: const Text('RESET'))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            ListTile(
              title:
                  Text('Current speed: ${_currentSpeed.toStringAsFixed(2)} KM'),
            ),
            const SizedBox(height: 20),
            ListTile(
              title: Text('Total distance: $_totalKm KM'),
            ),
            const SizedBox(height: 20),
            ListTile(
              title: Text(
                'Total waiting time: '
                '${_timer.inHours.toString().padLeft(2, '0')}:'
                '${(_timer.inMinutes % 60).toString().padLeft(2, '0')}:'
                '${(_timer.inSeconds % 60).toString().padLeft(2, '0')}',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white),
                onPressed: _startTimerService,
                child: const Text('START WAITING')),
            const SizedBox(height: 20),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red, foregroundColor: Colors.white),
                onPressed: _stopTimerService,
                child: const Text('STOP WAITING')),
            const SizedBox(height: 20),
            const Divider(),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white),
                onPressed: _startLocationTracking,
                child: const Text('START LOCATION TRACKING')),
            const SizedBox(height: 20),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red, foregroundColor: Colors.white),
                onPressed: _stopLocationTracking,
                child: const Text('STOP LOCATION TRACKING')),
          ],
        ),
      ),
    );
  }

  Future<void> _startTimerService() async {
    if (await FlutterForegroundTask.isRunningService) {
      await FlutterForegroundTask.restartService();
    } else {
      await FlutterForegroundTask.startService(
        serviceId: -1,
        notificationTitle: 'Waiting',
        notificationText:
            'Total waiting time: ${_timer.inHours.toString().padLeft(2, '0')}:${(_timer.inMinutes % 60).toString().padLeft(2, '0')}:${(_timer.inSeconds % 60).toString().padLeft(2, '0')}',
        notificationIcon: null,
        callback: startCallback,
      );
    }
  }

  Future<void> _stopTimerService() async {
    if (await FlutterForegroundTask.isRunningService) {
      await FlutterForegroundTask.stopService();
    }
  }
}
