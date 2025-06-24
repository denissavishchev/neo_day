import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:neo_day/widgets/day_widgets/goal_widget.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';
import '../../main_provider.dart';
import '../../models/boxes.dart';
import '../../models/habits_model.dart';
import 'task_switch_button_widget.dart';

class HabitsListWidget extends StatelessWidget {
  const HabitsListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Consumer<MainProvider>(
        builder: (context, data, _){
          return SizedBox(
            width: size.width,
            height: size.height * 0.5,
            child: ValueListenableBuilder<Box<HabitsModel>>(
                valueListenable: Boxes.addHabitToBase().listenable(),
                builder: (context, box, _){
                  final habits = box.values.toList().cast<HabitsModel>();
                  return Row(
                    spacing: 4,
                    children: [
                      Expanded(
                        child: Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(8))
                          ),
                          child: ListView.builder(
                            padding: const EdgeInsets.only(top: 2),
                              itemCount: habits.length,
                              itemBuilder: (context, index){
                                return GestureDetector(
                                  // onLongPress: () => data.deleteHabit(box, index),
                                  child: Container(
                                    width: size.width,
                                    margin: const EdgeInsets.only(bottom: 4),
                                    padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
                                    decoration: BoxDecoration(
                                        color: kGrey,
                                        borderRadius: const BorderRadius.all(Radius.circular(8))
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(habits[index].name,
                                              style: kBlackTextStyle.copyWith(fontSize: 32.sp),),
                                            const SizedBox(height: 8,),
                                            SizedBox(
                                              width: size.width * 0.67,
                                              child: Wrap(
                                                runAlignment: WrapAlignment.center,
                                                runSpacing: 3,
                                                children: List.generate(habits[index].days, (i){
                                                  List<int> converted = habits[index].progress.split('')
                                                      .map((v) => int.parse(v)).toList();
                                                  data.convertedLength = habits[index].days - (habits[index].days - converted.length);
                                                  converted.addAll(List.filled(habits[index].days - converted.length, 3));
                                                  data.zeros = converted.where((e) => e == 0).length;
                                                  data.ones = converted.where((e) => e == 1).length;
                                                  return Container(
                                                    margin: EdgeInsets.only(right: size.width * 0.007),
                                                    width: size.width * 0.026,
                                                    height: size.width * 0.026,
                                                    decoration: BoxDecoration(
                                                        color: converted[i] == 1
                                                            ? kTangerine
                                                            : converted[i] == 0
                                                            ? kWhite
                                                            : kGrey,
                                                        borderRadius: const BorderRadius.all(Radius.circular(3)),
                                                        border: Border.all(width: 1, color: kBlack)
                                                    ),
                                                  );
                                                }),
                                              ),
                                            ),
                                            const SizedBox(height: 8,),
                                            Row(
                                              spacing: 40,
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                      margin: const EdgeInsets.only(right: 4),
                                                      width: 12,
                                                      height: 12,
                                                      decoration: BoxDecoration(
                                                          color: kTangerine,
                                                          borderRadius: const BorderRadius.all(Radius.circular(3)),
                                                          border: Border.all(width: 1, color: kBlack)
                                                      ),
                                                    ),
                                                    Text('- ', style: kBlackTextStyle,),
                                                    Text(data.ones.toString(), style: kBlackTextStyle,),
                                                    Text(' / ', style: kBlackTextStyle,),
                                                    Container(
                                                      margin: const EdgeInsets.only(right: 4),
                                                      width: 12,
                                                      height: 12,
                                                      decoration: BoxDecoration(
                                                          color: kWhite,
                                                          borderRadius: const BorderRadius.all(Radius.circular(3)),
                                                          border: Border.all(width: 1, color: kBlack)
                                                      ),
                                                    ),
                                                    Text('- ', style: kBlackTextStyle,),
                                                    Text(data.zeros.toString(), style: kBlackTextStyle,),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text(data.convertedLength.toString(), style: kBlackTextStyle,),
                                                    Text(' / ', style: kBlackTextStyle,),
                                                    Text(habits[index].days.toString(), style: kBlackTextStyle,),
                                                    Text(' days', style: kBlackTextStyle,),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                        habits[index].days == habits[index].progress.length
                                            ? GestureDetector(
                                            onTap: () => data.addHabitHistoryToBase(box, index, habits),
                                            child: const Icon(Icons.history, color: kTangerine, size: 32,))
                                            : TaskSwitchButtonWidget(
                                          onTap: () => data.switchHabit(box, index, habits),
                                          checked: habits[index].status,
                                          index: index,),
                                      ],
                                    ),
                                  ),
                                );
                              }
                          ),
                        ),
                      ),
                      GoalWidget(goals: habits)
                    ],
                  );
                }
            ),
          );
        }
    );
  }
}