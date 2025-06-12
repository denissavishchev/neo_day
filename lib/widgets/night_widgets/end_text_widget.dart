import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';
import '../../main_provider.dart';

class EndTextWidget extends StatelessWidget {
  const EndTextWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Consumer<MainProvider>(
        builder: (context, data, _){
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            width: size.width,
            decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.all(Radius.circular(8))
            ),
            child: Column(
              spacing: 8,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('puzzleTitle${data.dayTaskCount}'.tr(), style: kBlackTextStyle.copyWith(fontSize: 22),),
                Text('puzzleQuestion${data.dayTaskCount}'.tr(), style: kBlackTextStyle,),
                Text('puzzleBody${data.dayTaskCount}'.tr(), style: kBlackTextStyle,),
                const SizedBox(height: 20,),
                Text('puzzleFooter${data.dayTaskCount}'.tr(),
                  style: kBlackTextStyle, textAlign: TextAlign.center,),
              ],
            ),
          );
        }
    );
  }
}