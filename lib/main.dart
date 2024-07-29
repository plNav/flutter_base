import 'package:baccus_kitchen/baccus_kitchen.dart';
import 'package:flutter/material.dart';

/// ## ⚠ Check on pubspec.yaml
const baccusKitchenVersion = '0.0.0.0';

/// ## true->LocalRepos  false->DioRepos
const bool isLocalMode = true;

/// ## Auto inserts valid credentials in debug.env
const bool isAutoLogin = true;
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const BaccusKitchen());
}
