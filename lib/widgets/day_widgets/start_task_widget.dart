import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';
import '../../main_provider.dart';

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
              padding: const EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: data.isStartInProgress
              ? Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Stack(
                          children: [
                            SizedBox(
                              width: size.width,
                              height: 26,
                              child: SvgPicture.asset('assets/images/stripe.svg',
                                fit: BoxFit.fill,
                                colorFilter: const ColorFilter.mode(kBlack, BlendMode.srcIn),
                              ),
                            ),
                            Center(
                              child: Text('bodyEnergy'.tr(args: ['${data.dayTaskCount + 1}']),
                                style: kTextStyle,),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () => data.switchIsStartTask(),
                        child: Container(
                          width: 33,
                          height: 33,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: kWhite,
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                              border: Border.all(color: kBlack, width: 3)
                          ),
                          child: Container(
                            width: 23,
                            height: 23,
                            decoration: BoxDecoration(
                              color: data.isStartTask ? kBlack : kWhite,
                              borderRadius: BorderRadius.all(Radius.circular(4)),
                            ),
                          ),
                        ),
                      ),const SizedBox(width: 12,),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18, ),
                    child: Column(
                      children: [
                        Text('start${data.dayTaskCount}'.tr(), style: kBlackTextStyle,),
                        Text('task${data.dayTaskCount}'.tr(), style: kBlackTextStyle,),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4,),
                  SizedBox(
                    width: size.width * 0.5,
                    child: Wrap(
                      runAlignment: WrapAlignment.center,
                      runSpacing: 3,
                      children: List.generate(30, (i){
                        return Container(
                          margin: EdgeInsets.only(right: size.width * 0.007),
                          width: size.width * 0.026,
                          height: size.width * 0.026,
                          decoration: BoxDecoration(
                              color: kWhite,
                              borderRadius: const BorderRadius.all(Radius.circular(3)),
                              border: Border.all(width: 1, color: kBlack)
                          ),
                        );
                      }),
                    ),
                  )
                ],
              )
              : GestureDetector(
                onTap: () => data.showToAddStartTask(context),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                          child: Text(
                            'chooseOneOfStartTasks'.tr(),
                            style: kBlackTextStyle,
                            textAlign: TextAlign.center,)),
                      Icon(Icons.add, size: 40,)
                    ],
                  ),
                ),
              ),
            ),
          );
        }
    );
  }
}