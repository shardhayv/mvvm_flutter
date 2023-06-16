import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/app.dart';
import 'core/network/local/hive_service.dart';

void main() {
  // initialize Hive before running flutter app
  WidgetsFlutterBinding.ensureInitialized();
  HiveService().init();
  runApp(const ProviderScope(child: App()));
}
