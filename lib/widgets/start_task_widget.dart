import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
              padding: const EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.all(Radius.circular(18)),
              ),
              child: Column(
                children: [
                  Stack(
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18, ),
                    child: Column(
                      children: [
                        Text('start${data.dayTaskCount}'.tr(), style: kBlackTextStyle,),
                        Text('task${data.dayTaskCount}'.tr(), style: kBlackTextStyle,),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          );
        }
    );
  }
}