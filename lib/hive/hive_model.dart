import 'package:hive/hive.dart';

part 'hive_model.g.dart'; // This file is generated when you run the build_runner

@HiveType(typeId: 0)
class MyHiveModel {
  @HiveField(0)
  final DateTime date;

  @HiveField(1)
  final List<bool> values;

  MyHiveModel({
    required this.date,
    required this.values,
  });
}
