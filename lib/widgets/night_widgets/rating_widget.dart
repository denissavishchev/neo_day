import 'dart:math';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';
import '../../main_provider.dart';

class RatingWidget extends StatelessWidget {
  const RatingWidget({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Consumer<MainProvider>(
        builder: (context, data, _){
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            width: size.width,
            decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.all(Radius.circular(8))
            ),
            child: Row(
              children: [
                SizedBox(
                  height: 125,
                  width: 110,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 50,
                          top: 50,
                          child: Text('${data.selectedStars}',
                            style: kBigTextStyle.copyWith(
                                shadows: [
                                  Shadow(
                                    blurRadius: 10,
                                    color: kTangerine
                                  ),
                                  Shadow(
                                    blurRadius: 10,
                                    color: kTangerine.withValues(alpha: 0.7),
                                    offset: Offset(2, 2),
                                  ),
                                ]
                            ), )),
                      Stack(
                        children: List.generate(5, (i){
                          double angle = (2.4 * i) / 3;
                          return Positioned(
                            left: 50 * (1 - sin(angle)),
                            top: 50 * (1 + cos(angle)),
                            child: Icon(Icons.star,
                                color: i < data.selectedStars ? kTangerine : kWhite,
                                size: 20 + 30 * (i / 4),
                                shadows: [
                                  BoxShadow(
                                      color: i < data.selectedStars ? kBlack : kTangerine,
                                      blurRadius: 9,
                                      spreadRadius: 6,
                                      offset: Offset(1, 1)
                                  ),
                                ]),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 8,
                    children: [
                      Text('${data.selectedStars}StarText${data.randomNumber}'.tr(), style: kBlackTextStyle,),
                      Text('${data.selectedStars}StarQuestion${data.randomNumber}'.tr(), style: kBlackTextStyle,),
                    ],
                  ),
                )
              ],
            ),
          );
        }
    );
  }
}