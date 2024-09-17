import 'package:flutter/material.dart';

import 'domain/clients/isar_client.dart';
import 'project_name_app.dart';

/// ## ⚠ Check on pubspec.yaml Must be the same
const projectVersion = '0.0.0';

/// The width threshold for considering a layout as mobile.
const mobileWidthBreak = 600.0;

/// The width threshold for considering a layout as tablet.
const tabletWidthBreak = 1200.0;

void main() async {
  const isTestingMode = true;
  WidgetsFlutterBinding.ensureInitialized();
  // ignore: dead_code - Initialize Isar only if is not testing mode
  // if(!isTestingMode)
  await IsarClient().init();
  runApp(const ProjectNameApp(isTestingMode: isTestingMode));
}
