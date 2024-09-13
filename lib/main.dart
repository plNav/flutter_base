import 'package:baccus_kitchen/domain/clients/isar_client.dart';
import 'package:baccus_kitchen/project_name_app.dart';
import 'package:flutter/material.dart';

/// ## ⚠ Check on pubspec.yaml Must be the same
const projectVersion = '0.0.0';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await IsarClient().init();
  runApp(const ProjectNameApp(isLocalMode: true));
}
