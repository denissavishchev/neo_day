import 'package:flutter/material.dart';
import 'package:neo_day/constants.dart';
import 'package:neo_day/main_provider.dart';
import 'package:provider/provider.dart';
import '../widgets/day_button.dart';
import '../widgets/day_night_switch_widget.dart';
import '../widgets/habits_list_widget.dart';
import '../widgets/languages/language_widget.dart';
import '../widgets/night_widget.dart';
import '../widgets/motivation_widget.dart';
import '../widgets/notepad_widget.dart';
import '../widgets/today_target_widget.dart';

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
    Size size = MediaQuery.sizeOf(context);
    return Consumer<MainProvider>(
        builder: (context, data, _){
          return Scaffold(
              key: data.notesKey,
              drawer: NotepadWidget(),
              body: GestureDetector(
                onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                child: Container(
                  width: size.width,
                  height: size.height,
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  color: kBlack,
                  child: Column(
                      spacing: 12,
                      children: [
                        const SizedBox(height: 40,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            DayButton(icon: Icons.note_alt,
                                onTap: () => data.readNote()),
                            LanguageWidget(),
                            DayButton(icon: Icons.history, onTap: () {  },),
                            DayButton(icon: Icons.add, onTap: () => data.showToAddHabit(context),)
                          ],
                        ),
                        DaySwitchWidget(),
                        TodayTargetWidget(),
                        MotivationWidget(),
                        Expanded(
                            child: data.isDay
                                ? HabitsListWidget()
                                : NightWidget())
                      ]
                  ),
                ),
              )
          );
        }
    );
  }
}










