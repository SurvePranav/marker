import 'package:hive_flutter/hive_flutter.dart';

final class LocalDatabaseService {
  // Private constructor to prevent instantiation outside of this class.
  LocalDatabaseService._();

  // Singleton instance
  static final LocalDatabaseService _instance =
      LocalDatabaseService._(); // creating the instance

  late Box<String> _hiveBox;

  // Getter for the singleton instance
  static LocalDatabaseService get instance => _instance;

  // Initialization function to open the boxes and register adapters
  //* This method should be (Explicitly) only once when starting the app
  //* Here will the initilization of the variables will happen
  static Future<void> initilize() async {
    await Hive.initFlutter(); // Initialize Hive

    // Open boxes and assign to the variables
    _instance._hiveBox = await Hive.openBox<String>('HiveBox');
  }

  // Getter to access zineModelBox
  Box<String> get getBox => _hiveBox;
}
