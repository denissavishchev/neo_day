import 'package:flutter/material.dart';
import 'package:neo_day/main_provider.dart';
import 'package:neo_day/widgets/night_widgets/rating_widget.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';
import 'end_text_widget.dart';

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
                Visibility(
                  visible: data.isRatingWidget,
                    child: RatingWidget()),
                const SizedBox(height: 24,),
                EndTextWidget(),
              ],
            ),
          );
        }
    );
  }
}





