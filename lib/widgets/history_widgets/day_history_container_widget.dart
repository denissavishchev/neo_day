import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';
import '../../main_provider.dart';
import '../../models/day_history_model.dart';

class DayHistoryContainerWidget extends StatelessWidget {
  const DayHistoryContainerWidget({
    super.key,
    required this.history,
    required this.index,
    required this.box,
  });

  final List<DayHistoryModel> history;
  final int index;
  final Box<DayHistoryModel> box;

  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
        builder: (context, data, _){
          return GestureDetector(
            // onLongPress: () => data.deleteHistoryHabit(box, index),
            child: Container(
                margin: const EdgeInsets.fromLTRB(8, 0, 12, 8),
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
                    Row(
                      children: [
                        Text('Start: ', style: kBlackTextStyle,),
                        Text(DateFormat('dd.MM.yyyy (HH:mm)').format(DateTime.parse(history[index].startTime)),
                          style: kBlackTextStyle,),
                      ],
                    ),
                    Row(
                      children: [
                        Text('End: ', style: kBlackTextStyle,),
                        Text(DateFormat('dd.MM.yyyy (HH:mm)').format(DateTime.parse(history[index].endTime)),
                          style: kBlackTextStyle,),
                      ],
                    ),
                    Row(
                      children: [
                        Text('Duration: ',
                          style: kBlackTextStyle,),
                        Text(data.formatDuration(DateTime.parse(history[index].endTime).difference(DateTime.parse(history[index].startTime))),
                          style: kBlackTextStyle,),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 4),
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                              color: history[index].target ? kTangerine : kWhite,
                              borderRadius: const BorderRadius.all(Radius.circular(3)),
                              border: Border.all(width: 1, color: kBlack)
                          ),
                        ),
                        Text(history[index].targetName, style: kBlackTextStyle,),
                      ],
                    ),
                    Row(
                      children: [
                        Text('Tasks: ', style: kBlackTextStyle,),
                        Text('${history[index].task}', style: kBlackTextStyle,),
                        Text(' / ', style: kBlackTextStyle,),
                        Text('${history[index].tasks}', style: kBlackTextStyle,),
                      ],
                    ),
                    Row(
                      children: [
                        Text('Last night duration: ', style: kBlackTextStyle,),
                        Text(history[index].sleepDuration, style: kBlackTextStyle,),
                      ],
                    ),
                  ],
                )
            ),
          );
        }
    );
  }
}


