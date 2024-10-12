import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location_tracker/pages/home_page.dart';
import 'package:location_tracker/services/foreground_service.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:timezone/timezone.dart' as tz;

DateTime getCentralTime() {
  // Get the Central Time Zone (America/Chicago)
  final centralTimeZone = tz.getLocation('America/Chicago');

  // Get the current time in Central Time Zone
  final currentCentralTime = tz.TZDateTime.now(centralTimeZone);

  return currentCentralTime; // Return the Central Time
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Permission.location.request();
  await Permission.locationWhenInUse.request();
  await Permission.locationAlways.request();
  await Geolocator.requestPermission();
  if (!await Geolocator.isLocationServiceEnabled()) {
    await Geolocator.openLocationSettings();
  }
  AwesomeNotifications().initialize(
  // set the icon to null if you want to use the default app icon
  'resource://drawable/res_app_icon',
  [
    NotificationChannel(
        channelGroupKey: 'basic_channel_group',
        channelKey: 'basic_channel',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic tests',
        defaultColor: const Color(0xFF9D50DD),
        ledColor: Colors.white)
  ],
  // Channel groups are only visual and are not required
  channelGroups: [
    NotificationChannelGroup(
        channelGroupKey: 'basic_channel_group',
        channelGroupName: 'Basic group')
  ],
  debug: kDebugMode
);

AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
  if (!isAllowed) {
    // This is just a basic example. For real apps, you must show some
    // friendly dialog box before call the request method.
    // This is very important to not harm the user experience
    AwesomeNotifications().requestPermissionToSendNotifications();
  }
});


  FlutterForegroundTask.initCommunicationPort();

  // await requestForegroundPermissions();
  initForegroundTask();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Location Tracker',
        home: HomePage());
  }
}


