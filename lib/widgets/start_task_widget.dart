import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../main_provider.dart';

class StartTaskWidget extends StatelessWidget {
  const StartTaskWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Consumer<MainProvider>(
        builder: (context, data, _){
          return Visibility(
            visible: data.isDay,
            child: Container(
              width: size.width,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
              decoration: BoxDecoration(
                color: kRed,
                borderRadius: BorderRadius.all(Radius.circular(18)),
              ),
              child: Column(
                children: [
                  Text('bodyEnergy'.tr(args: ['${data.dayTaskCount + 1}']),
                    style: kTextStyle.copyWith(color: kWhite.withValues(alpha: 0.8)),),
                  Text('start${data.dayTaskCount}'.tr(), style: kTextStyle,),
                  Text('task${data.dayTaskCount}'.tr(), style: kTextStyle,),
                ],
              ),
            ),
          );
        }
    );
  }
}