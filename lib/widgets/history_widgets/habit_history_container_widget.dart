import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';
import '../../main_provider.dart';
import '../../models/habit_history_model.dart';

class HabitHistoryContainerWidget extends StatelessWidget {
  const HabitHistoryContainerWidget({
    super.key,
    required this.history,
    required this.index,
    required this.box,
  });

  final List<HabitHistoryModel> history;
  final int index;
  final Box<HabitHistoryModel> box;

  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
        builder: (context, data, _){
          return GestureDetector(
            // onLongPress: () => data.deleteHistoryHabit(box, index),
            child: Container(
                margin: const EdgeInsets.fromLTRB(12, 0, 12, 8),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: kGrey,
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  boxShadow: [
                    BoxShadow(
                        color: kBlack.withValues(alpha: 0.6),
                        blurRadius: 8,
                        spreadRadius: 2,
                        offset: const Offset(0, 1)
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(history[index].name,
                      style: kBlackTextStyle.copyWith(fontSize: 32.sp),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Row(
                              children: [
                                Text('Total days: ', style: kBlackTextStyle,),
                                Text(history[index].totalDays,
                                  style: kBlackTextStyle,),
                              ],
                            ),
                          ],
                        ),
                        const Spacer(),
                        SizedBox(
                          width: 130,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                children: [
                                  Text('Start: ',
                                    style: kBlackTextStyle,),
                                  Text(DateFormat('dd.MM.yyyy').format(DateTime.parse(history[index].startTime)),
                                    style: kBlackTextStyle,),
                                ],
                              ),
                              Row(
                                children: [
                                  Text('End: ',
                                    style: kBlackTextStyle,),
                                  Text(DateFormat('dd.MM.yyyy').format(DateTime.parse(history[index].endTime)),
                                    style: kBlackTextStyle,),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 60,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                  Text(history[index].goodDays, style: kBlackTextStyle,),
                                ],
                              ),
                              Row(
                                children: [
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
                                  Text(history[index].badDays, style: kBlackTextStyle,),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 280,
                      child: Wrap(
                        runAlignment: WrapAlignment.center,
                        runSpacing: 1.5,
                        children: List.generate(history[index].list.length, (i){
                          List<int> converted = history[index].list.split('')
                              .map((v) => int.parse(v)).toList();
                          data.convertedLength = history[index].list.length - (history[index].list.length - converted.length);
                          converted.addAll(List.filled(history[index].list.length - converted.length, 3));
                          data.zeros = converted.where((e) => e == 0).length;
                          data.ones = converted.where((e) => e == 1).length;
                          return Container(
                            margin: const EdgeInsets.only(right: 1.5),
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                                color: converted[i] == 1
                                    ? kTangerine
                                    : kWhite,
                                borderRadius: const BorderRadius.all(Radius.circular(3)),
                                border: Border.all(width: 1, color: kBlack)
                            ),
                          );
                        }),
                      ),
                    ),
                    SizedBox(height: 8,)
                  ],
                )
            ),
          );
        }
    );
  }
}


