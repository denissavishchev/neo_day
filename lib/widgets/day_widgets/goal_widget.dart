import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:neo_day/main_provider.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';
import '../../models/boxes.dart';
import '../../models/habits_model.dart';

class GoalWidget extends StatelessWidget {
  const GoalWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Consumer<MainProvider>(
        builder: (context, data, _){
          return Visibility(
            visible: data.isDay,
            child: Container(
              width: size.width,
              height: 14,
              padding: const EdgeInsets.symmetric(vertical: 2),
              decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: ValueListenableBuilder<Box<HabitsModel>>(
                  valueListenable: Boxes.addHabitToBase().listenable(),
                  builder: (context, box, _){
                    final goals = box.values.toList().cast<HabitsModel>();
                    return ListView.builder(
                        itemCount: goals.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, i){
                          return Container(
                            width: 10,
                            margin: EdgeInsets.only(left: 4),
                            decoration: BoxDecoration(
                                color: goals[i].status ? kTangerine : kBlack,
                                borderRadius: BorderRadius.all(Radius.circular(5))
                            ),
                          );
                        }
                    );
                  }
              ),
            ),
          );
        }
    );
  }
}