import 'package:baccus_kitchen/project_name_app.dart';
import 'package:flutter/material.dart';

/// ## ⚠ Check on pubspec.yaml Must be the same
const projectVersion = '0.0.0';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProjectNameApp(isLocalMode: true));
}


