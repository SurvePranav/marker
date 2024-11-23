import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
// import 'package:marker/hive/hive_init.dart';
import 'package:marker/src/home/bloc/home_bloc.dart';
import 'package:marker/src/home/views/home_view.dart';

void main() async {
  // HiveInitilizer.initilizeHiveAdapters();
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  final hiveBox = await Hive.openBox<String>('HiveBox');
  runApp(
    MyApp(hiveBox: hiveBox),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.hiveBox,
  });
  final Box<String> hiveBox;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(hiveBox),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
          colorScheme: const ColorScheme.dark(
            primary: Colors.red,
            surfaceTint: Colors.white,
          ),
          scaffoldBackgroundColor: Colors.black,
        ),
        home: const HomeView(),
      ),
    );
  }
}
