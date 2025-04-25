import 'package:flutter/material.dart';
import 'package:neo_day/constants.dart';
import 'package:neo_day/main_provider.dart';
import 'package:provider/provider.dart';
import '../widgets/day_button.dart';
import '../widgets/day_night_switch_widget.dart';
import '../widgets/habits_list_widget.dart';
import '../widgets/languages/language_widget.dart';
import '../widgets/languages/night_widget.dart';
import '../widgets/motivation_widget.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Consumer<MainProvider>(
          builder: (context, data, _){
            return Container(
              width: size.width,
              height: size.height,
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              color: kBlack,
              child: Column(
                spacing: 20,
                  children: [
                    const SizedBox(height: 40,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DayButton(icon: Icons.note_alt, onTap: () {  },),
                        LanguageWidget(),
                        DayButton(icon: Icons.history, onTap: () {  },),
                        DayButton(icon: Icons.add, onTap: () => data.showToAddHabit(context),)
                      ],
                    ),
                    DaySwitchWidget(),
                    MotivationWidget(),
                    Expanded(
                        child: data.isDay
                         ? HabitsListWidget()
                         : NightWidget())
                  ]
              ),
            );
          }
      )
    );
  }
}






