import 'package:flutter/material.dart';
import 'package:neo_day/main_provider.dart';
import 'package:provider/provider.dart';
import '../constants.dart';

class NightWidget extends StatelessWidget {
  const NightWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
        builder: (context, data, _){
          return Column(
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
                        color: data.isTodayTarget ? kRed : kBlack.withValues(alpha: 0.8),
                        borderRadius: BorderRadius.all(Radius.circular(7)),
                        border: Border.all(color: data.isTodayTarget ? Colors.transparent : kRed, width: 2)
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
              PuzzleWidget()
            ],
          );
        }
    );
  }
}

class PuzzleWidget extends StatelessWidget {
  const PuzzleWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Consumer<MainProvider>(
        builder: (context, data, _){
          return Container(
            width: size.width,
            height: 250,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.all(Radius.circular(8))
            ),
            child: Stack(
              children: [
                SizedBox(
                    width: size.width,
                    height: 250,
                    child: Image.asset('assets/images/forest.jpg', fit: BoxFit.cover,)),
                Wrap(
                  children: List.generate(30, ((i){
                    return GestureDetector(
                      onTap: () => data.openPuzzleTask(i),
                      child: Container(
                        width: (size.width - 36) / 6,
                        height: 50,
                        decoration: BoxDecoration(
                            color: data.puzzleColors[i],
                            border: Border.all(
                                color: data.puzzleColors[i] == kRed ? kBlack : Colors.transparent,
                                width: 0.5)
                        ),
                      ),
                    );
                  })),
                ),
                Visibility(
                  visible: data.isPuzzleTaskVisible,
                  child: GestureDetector(
                    onTap: () => data.hidePuzzleTask(),
                    child: Container(
                        width: size.width,
                        height: 250,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                            color: kWhite,
                            borderRadius: BorderRadius.all(Radius.circular(12))
                        )
                    ),
                  ),
                )
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