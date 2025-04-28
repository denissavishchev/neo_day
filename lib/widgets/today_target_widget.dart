import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../main_provider.dart';

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
            visible: data.todayTarget != '',
            child: Container(
              width: size.width,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
              decoration: BoxDecoration(
                color: kRed,
                borderRadius: BorderRadius.all(Radius.circular(18)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(data.todayTarget, style: kTextStyle,),
                  Container(
                    width: 32,
                    height: 32,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: kBlue,
                      borderRadius: BorderRadius.all(Radius.circular(12))
                    ),
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                          color: kRed,
                          borderRadius: BorderRadius.all(Radius.circular(8))
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