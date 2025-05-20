import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:neo_day/models/start_task_history_model.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';
import '../../main_provider.dart';

class StartTaskHistoryContainerWidget extends StatelessWidget {
  const StartTaskHistoryContainerWidget({
    super.key,
    required this.history,
    required this.index,
    required this.box,
  });

  final List<StartTaskHistoryModel> history;
  final int index;
  final Box<StartTaskHistoryModel> box;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Consumer<MainProvider>(
        builder: (context, data, _){
          return GestureDetector(
            // onLongPress: () => data.deleteHistoryHabit(box, index),
            child: Container(
                margin: const EdgeInsets.fromLTRB(8, 0, 12, 8),
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
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
                  spacing: 8,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(history[index].name,
                      style: kBlackTextStyle.copyWith(fontSize: 32.sp),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(history[index].history.length, (i){
                        List<int> converted = history[index].history.split('')
                            .map((v) => int.parse(v)).toList();
                        data.convertedLength = history[index].history.length - (history[index].history.length - converted.length);
                        converted.addAll(List.filled(history[index].history.length - converted.length, 3));
                        data.zeros = converted.where((e) => e == 0).length;
                        data.ones = converted.where((e) => e == 1).length;
                        return Container(
                          margin: EdgeInsets.only(right: size.width * 0.0033),
                          width: size.width * 0.026,
                          height: size.width * 0.026,
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
                  ],
                )
            ),
          );
        }
    );
  }
}


