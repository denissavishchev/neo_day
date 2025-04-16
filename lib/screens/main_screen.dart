import 'package:flutter/material.dart';
import 'package:neo_day/constants.dart';
import '../widgets/day_night_switch_widget.dart';
import '../widgets/habits_list_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        color: kBlack,
        child: Column(
            children: [
              const SizedBox(height: 40,),
              DaySwitchWidget(),
              Expanded(child: HabitsListWidget())
            ]
        ),
      ),
    );
  }
}
