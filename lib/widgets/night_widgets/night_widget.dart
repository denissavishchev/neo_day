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
            height: size.height * 0.7,
            color: kBlack,
            child: Column(
              children: [
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






