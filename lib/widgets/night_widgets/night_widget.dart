import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:neo_day/main_provider.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';

class NightWidget extends StatelessWidget {
  const NightWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Consumer<MainProvider>(
        builder: (context, data, _){
          return Container(
            height: size.height * 0.78,
            color: kBlack,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('last day target: ${data.todayTarget}', style: kTextStyle,),
                    const SizedBox(width: 4,),
                    Container(
                      width: 18,
                      height: 18,
                      decoration: BoxDecoration(
                          color: data.isTodayTarget ? kTangerine : kBlack.withValues(alpha: 0.8),
                          borderRadius: BorderRadius.all(Radius.circular(7)),
                          border: Border.all(color: data.isTodayTarget ? Colors.transparent : kTangerine, width: 2)
                      ),
                    )
                  ],
                ),
                Text('last day tasks: ${data.doneTasks}/${data.totalTasks}', style: kTextStyle,),
                Text('last day duration: ${data.previousDayDuration}', style: kTextStyle,),
                Text('last day ended at: ${data.endTime}', style: kTextStyle,),
                const SizedBox(height: 24,),
                RatingWidget(),
                const SizedBox(height: 24,),
                EndTextWidget(),
              ],
            ),
          );
        }
    );
  }
}

class EndTextWidget extends StatelessWidget {
  const EndTextWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Consumer<MainProvider>(
        builder: (context, data, _){
          return Container(
            width: size.width,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.all(Radius.circular(8))
            ),
            child: Column(
              spacing: 8,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('puzzleTitle${data.dayTaskCount}'.tr(), style: kBlackTextStyle.copyWith(fontSize: 22),),
                Text('puzzleQuestion${data.dayTaskCount}'.tr(), style: kBlackTextStyle,),
                Text('puzzleBody${data.dayTaskCount}'.tr(), style: kBlackTextStyle,),
                const SizedBox(height: 20,),
                Text('puzzleFooter${data.dayTaskCount}'.tr(),
                  style: kBlackTextStyle, textAlign: TextAlign.center,),
              ],
            ),
          );
        }
    );
  }
}

class RatingWidget extends StatelessWidget {
  const RatingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
        builder: (context, data, _){
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (i){
              return GestureDetector(
                onTap: () => data.selectStars(i),
                child: Icon(Icons.star,
                    color: i < data.selectedStars ? kTangerine : kWhite,
                    size: 50,
                    shadows: [
                      BoxShadow(
                          color: i < data.selectedStars ? kWhite : kTangerine,
                          blurRadius: 9,
                          spreadRadius: 6,
                          offset: Offset(1, 1)
                      ),
                    ]),
              );
            }),
          );
        }
    );
  }
}