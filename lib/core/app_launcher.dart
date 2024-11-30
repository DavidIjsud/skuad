import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'app.dart';
import 'bootstrapper.dart';
import 'flavor.dart';

class AppLauncher {
  static void launchApp({required Flavor flavor}) async {
    await runZonedGuarded<Future<void>>(() async {
      WidgetsFlutterBinding.ensureInitialized();

      await SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp]);

      runApp(
        App(
          bootstrapper: Bootstrapper.fromFlavor(flavor),
        ),
      );
    }, (Object error, StackTrace stackTrace) {});
  }
}
