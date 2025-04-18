import 'package:flutter/material.dart';
import 'package:neo_day/constants.dart';
import 'package:neo_day/main_provider.dart';
import 'package:provider/provider.dart';
import '../widgets/day_night_switch_widget.dart';
import '../widgets/habits_list_widget.dart';

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
              color: kBlack,
              child: Column(
                  children: [
                    const SizedBox(height: 40,),
                    DaySwitchWidget(),
                    ElevatedButton(
                        onPressed: () => data.showToAddHabit(context),
                        child: Text('Add')),
                    Expanded(child: HabitsListWidget())
                  ]
              ),
            );
          }
      )
    );
  }
}
