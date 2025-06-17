import 'package:flutter/material.dart';
import 'package:neo_day/main_provider.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';
import '../../models/habits_model.dart';

class GoalWidget extends StatelessWidget {
  const GoalWidget({
    super.key,
    required this.goals,
  });

  final List<HabitsModel> goals;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Consumer<MainProvider>(
        builder: (context, data, _){
          return Visibility(
            visible: data.isDay,
            child: Container(
              width: size.width,
              height: 16,
              padding: const EdgeInsets.symmetric(vertical: 2),
              decoration: BoxDecoration(
                color: kGrey,
                borderRadius: BorderRadius.all(Radius.circular(6)),
              ),
              child: ListView.builder(
                  itemCount: goals.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, i){
                    return Container(
                      width: 12,
                      margin: EdgeInsets.only(left: 4),
                      decoration: BoxDecoration(
                          color: goals[i].status ? kTangerine : kWhite,
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        border: Border.all(color: kBlack, width: 1)
                      ),
                    );
                  }
              ),
            ),
          );
        }
    );
  }
}