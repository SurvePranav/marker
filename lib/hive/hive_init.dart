import 'package:hive_flutter/hive_flutter.dart';

class HiveInitilizer {
  HiveInitilizer._();

  late final Box<String> _hiveBox;
  static final HiveInitilizer _instance = HiveInitilizer._();

  static HiveInitilizer get instance => _instance;
  Box<String> get hiveBox => _hiveBox;

  static Future<void> initilizeHiveAdapters() async {
    await Hive.initFlutter();
    instance._hiveBox = await Hive.openBox<String>('HiveBox');
  }
}
