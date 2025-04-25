import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
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
          return Stack(
            children: [
              Column(
                children: [
                  SizedBox(
                    width: size.width,
                    height: 300,
                  ),
                  Text('last day tasks: ${data.doneTasks}/${data.totalTasks}', style: kTextStyle,),
                  Text('last day duration: ${data.previousDayDuration}', style: kTextStyle,),
                  Text('Quality of the last day: Good', style: kTextStyle,),
                  Text('Mood of the last day: Good', style: kTextStyle,),
                  const SizedBox(height: 50,),
                  ElevatedButton(
                      onPressed: (){},
                      child: Text('Go to sleep...')
                  )
                ],
              ),
              Positioned(
                  top: -100,
                  right: 0,
                  child: Lottie.asset('assets/images/panda.json', width: size.width)),
            ],
          );
        }
    );
  }
}