import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';
import '../../main_provider.dart';

class TodayTargetWidget extends StatelessWidget {
  const TodayTargetWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Consumer<MainProvider>(
        builder: (context, data, _){
          return Visibility(
            visible: data.todayTarget != '' && data.isDay,
            child: Container(
              width: size.width,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
              decoration: BoxDecoration(
                color: kBlack,
                borderRadius: BorderRadius.all(Radius.circular(18)),
                  border: Border.all(color: kWhite, width: 2)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(data.todayTarget, style: kTextStyle,),
                  GestureDetector(
                    onTap: () => data.switchIsTodayTarget(),
                    child: Container(
                      width: 32,
                      height: 32,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: kBlack.withValues(alpha: 0.8),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                          border: Border.all(color: kWhite, width: 2)
                      ),
                      child: Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                            color: data.isTodayTarget ? kWhite : kBlack.withValues(alpha: 0.8),
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }
    );
  }
}