import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neo_day/screens/main_screen.dart';
import 'package:provider/provider.dart';
import 'main_provider.dart';
import 'models/habit_history_model.dart';
import 'models/habits_model.dart';
import 'package:hive_flutter/adapters.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(HabitsModelAdapter());
  Hive.registerAdapter(HabitHistoryModelAdapter());
  await Hive.openBox<HabitsModel>('habit');
  await Hive.openBox<HabitHistoryModel>('habitHistory');
  await Hive.openBox('day');
  await EasyLocalization.ensureInitialized();
  runApp(
      EasyLocalization(
          supportedLocales: const [
            Locale('en', 'US'),
            Locale('pl', 'PL'),
            Locale('ru', 'RU'),],
          path: 'assets/translations',
          fallbackLocale: const Locale('en', 'US'),
          child: MultiProvider(
              providers: [
                ChangeNotifierProvider<MainProvider>(create: (_) => MainProvider()),
              ],
              builder: (context, child) {
                return ScreenUtilInit(
                  designSize: const Size(720, 1560),
                  builder: (_, child) => MaterialApp(
                    debugShowCheckedModeBanner: false,
                    localizationsDelegates: context.localizationDelegates,
                    supportedLocales: context.supportedLocales,
                    locale: context.locale,
                    home: MainScreen(),
                  ),
                );
              }
          )
      )
  );
}



