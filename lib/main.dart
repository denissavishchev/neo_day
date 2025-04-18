import 'package:flutter/material.dart';
import 'package:neo_day/screens/main_screen.dart';
import 'package:provider/provider.dart';
import 'main_provider.dart';
import 'models/habits_model.dart';
import 'package:hive_flutter/adapters.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(HabitsModelAdapter());
  await Hive.openBox<HabitsModel>('habit');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MainProvider>(
      create: (context) => MainProvider(),
      builder: (context, _){
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: MainScreen(),
        );
      }
    );
  }
}

