import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:neo_day/main_provider.dart';
import 'package:provider/provider.dart';
import '../constants.dart';

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
                  Text('last day ended at: ${data.endTime}', style: kTextStyle,),
                  const SizedBox(height: 24,),
                  RatingWidget(),
                  const SizedBox(height: 24,),
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