import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../main_provider.dart';
import '../models/boxes.dart';
import '../models/habits_model.dart';
import 'task_switch_button_widget.dart';

class HabitsListWidget extends StatelessWidget {
  const HabitsListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Consumer<MainProvider>(
        builder: (context, data, _){
          return Center(
            child: Column(
              children: [
                Expanded(
                  child: SizedBox(
                    width: size.width,
                    child: ValueListenableBuilder<Box<HabitsModel>>(
                        valueListenable: Boxes.addHabitToBase().listenable(),
                        builder: (context, box, _){
                          final habits = box.values.toList().cast<HabitsModel>();
                          return ListView.builder(
                              itemCount: habits.length,
                              itemBuilder: (context, index){
                                return GestureDetector(
                                  onLongPress: () => data.deleteHabit(box, index),
                                  child: Container(
                                    width: size.width,
                                    margin: const EdgeInsets.only(bottom: 4),
                                    padding: const EdgeInsets.fromLTRB(18, 6, 18, 12),
                                    decoration: BoxDecoration(
                                        color: kNavy.withValues(alpha: 0.3),
                                        borderRadius: const BorderRadius.all(Radius.circular(24))
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            Text(habits[index].name,
                                              style: const TextStyle(
                                                  color: kWhite,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18
                                              ),),
                                            const SizedBox(height: 8,),
                                            SizedBox(
                                              width: 240,
                                              child: Wrap(
                                                runAlignment: WrapAlignment.center,
                                                runSpacing: 4,
                                                children: List.generate(habits[index].days, (i){
                                                  List<int> converted = habits[index].progress.split('')
                                                      .map((v) => int.parse(v)).toList();
                                                  data.convertedLength = habits[index].days - (habits[index].days - converted.length);
                                                  converted.addAll(List.filled(habits[index].days - converted.length, 3));
                                                  data.zeros = converted.where((e) => e == 0).length;
                                                  data.ones = converted.where((e) => e == 1).length;
                                                  return Container(
                                                    margin: const EdgeInsets.only(right: 4),
                                                    width: 12,
                                                    height: 12,
                                                    decoration: BoxDecoration(
                                                        color: converted[i] == 1
                                                            ? kGreen
                                                            : converted[i] == 0
                                                            ? kNavy.withValues(alpha: 0.2)
                                                            : kIndigo.withValues(alpha: 0.2),
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
                                                          color: kGreen,
                                                          borderRadius: const BorderRadius.all(Radius.circular(3)),
                                                          border: Border.all(width: 1, color: kBlack)
                                                      ),
                                                    ),
                                                    const Text('- ', style: kTextStyle,),
                                                    Text(data.ones.toString(), style: kTextStyle,),
                                                    const Text(' / ', style: kTextStyle,),
                                                    Container(
                                                      margin: const EdgeInsets.only(right: 4),
                                                      width: 12,
                                                      height: 12,
                                                      decoration: BoxDecoration(
                                                          color: kNavy.withValues(alpha: 0.2),
                                                          borderRadius: const BorderRadius.all(Radius.circular(3)),
                                                          border: Border.all(width: 1, color: kBlack)
                                                      ),
                                                    ),
                                                    const Text('- ', style: kTextStyle,),
                                                    Text(data.zeros.toString(), style: kTextStyle,),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text(data.convertedLength.toString(), style: kTextStyle,),
                                                    const Text(' / ', style: kTextStyle,),
                                                    Text(habits[index].days.toString(), style: kTextStyle,),
                                                    const Text(' days', style: kTextStyle,),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                        TaskSwitchButtonWidget(
                                          onTap: () => data.switchHabit(box, index, habits),
                                          checked: habits[index].status,
                                          index: index,),
                                      ],
                                    ),
                                  ),
                                );
                              }
                          );
                        }
                    ),
                  ),
                ),
              ],
            ),
          );
        }
    );
  }
}