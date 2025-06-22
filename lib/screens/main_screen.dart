import 'package:flutter/material.dart';
import 'package:neo_day/constants.dart';
import 'package:neo_day/main_provider.dart';
import 'package:provider/provider.dart';
import '../widgets/day_night_switch_widget.dart';
import '../widgets/day_widgets/habits_list_widget.dart';
import '../widgets/night_widgets/night_widget.dart';
import '../widgets/day_widgets/motivation_widget.dart';
import '../widgets/notepad_widget.dart';
import '../widgets/day_widgets/start_task_widget.dart';
import '../widgets/day_widgets/today_target_widget.dart';
import '../widgets/day_widgets/top_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  @override
  void initState() {
    final data = Provider.of<MainProvider>(context, listen: false);
    data.initDay();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
        builder: (context, data, _){
          return SafeArea(
            child: Scaffold(
              backgroundColor: kBlack,
                key: data.notesKey,
                drawer: NotepadWidget(),
                body: GestureDetector(
                  onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      children: [
                        TopWidget(),
                        DaySwitchWidget(),
                        TodayTargetWidget(),
                        const SizedBox(height: 8,),
                        MotivationWidget(),
                        const SizedBox(height: 8,),
                        StartTaskWidget(),
                        const SizedBox(height: 8,),
                        data.isDay
                            ? HabitsListWidget()
                            : NightWidget(),
                      ],
                    ),
                  )
                )
            ),
          );
        }
    );
  }
}
