import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';
import '../../main_provider.dart';

class MotivationWidget extends StatelessWidget {
  const MotivationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Consumer<MainProvider>(
      builder: (context, data, _) {
        return Visibility(
          visible: data.isDay,
          child: AnimatedCrossFade(
            key: data.key2,
            duration: const Duration(milliseconds: 220),
            crossFadeState: data.motivationText == 'quote'
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            firstChild: _buildFirstContainer(size, data),
            secondChild: _buildSecondContainer(size, data),
            sizeCurve: Curves.easeInOut,
          ),
        );
      },
    );
  }

  Widget _buildFirstContainer(Size size, MainProvider data) {
    return Container(
      width: size.width,
      height: 55,
      decoration: BoxDecoration(
        color: kBlack,
        borderRadius: BorderRadius.all(Radius.circular(8)),
        border: Border.all(color: kWhite, width: 2)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          MotivationButton(text: 'quote'.tr(), onTap: () => data.showMotivation('quote'),),
          MotivationButton(text: 'advice'.tr(), onTap: () => data.showMotivation('advice'),),
          MotivationButton(text: 'joke'.tr(), onTap: () => data.showMotivation('joke'),)
        ],
      ),
    );
  }

  Widget _buildSecondContainer(Size size, MainProvider data) {
    return Container(
      width: size.width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: kBlack,
        borderRadius: BorderRadius.all(Radius.circular(8)),
        border: Border.all(color: kWhite, width: 2)
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(data.motivationText.tr(),
          style: kTextStyle,),
      ),
    );
  }
}

class MotivationButton extends StatelessWidget {
  const MotivationButton({
    super.key, required this.text, required this.onTap,
  });

  final String text;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size.width * 0.25,
        height: 40,
        decoration: BoxDecoration(
            color: kWhite,
            borderRadius: BorderRadius.all(Radius.circular(8))
        ),
        child: Center(child: Text(text, style: kBlackTextStyle)),
      ),
    );
  }
}