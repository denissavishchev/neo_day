import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:neo_day/widgets/day_widgets/day_button.dart';
import '../constants.dart';
import '../models/boxes.dart';
import '../models/habit_history_model.dart';
import '../widgets/history_widgets/habit_history_container_widget.dart';
import 'main_screen.dart';

class HabitHistoryScreen extends StatelessWidget {
  const HabitHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: kBlack,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 18,),
              DayButton(
                onTap: () => Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) =>
                    const MainScreen())),
                icon: Icons.home,
              ),
              const SizedBox(height: 18,),
              SizedBox(
                width: size.width,
                height: size.height * 0.8,
                child: ValueListenableBuilder<Box<HabitHistoryModel>>(
                    valueListenable: Boxes.addHabitHistoryToBase().listenable(),
                    builder: (context, box, _){
                      final history = box.values.toList().cast<HabitHistoryModel>().reversed.toList();
                      return ListView.builder(
                          itemCount: history.length,
                          itemBuilder: (context, index){
                            return HabitHistoryContainerWidget(
                              history: history,
                              index: index,
                              box: box,
                            );
                          }
                      );
                    }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


