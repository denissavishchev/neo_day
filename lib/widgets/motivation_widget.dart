import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../main_provider.dart';

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
            duration: const Duration(milliseconds: 220),
            crossFadeState: data.motivationIndex == 0
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            firstChild: _buildRedContainer(size, MainProvider()),
            secondChild: _buildGreenContainer(size),
            sizeCurve: Curves.easeInOut,
          ),
        );
      },
    );
  }

  Widget _buildRedContainer(Size size, MainProvider data) {
    return Container(
      margin: const EdgeInsets.all(8),
      width: size.width,
      height: 100,
      decoration: const BoxDecoration(
        color: kRed,
        borderRadius: BorderRadius.all(Radius.circular(18)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MotivationButton(text: 'quote'.tr(), onTap: () => data.showMotivation(),),
          MotivationButton(text: 'advice'.tr(), onTap: () {  },),
          MotivationButton(text: 'joke'.tr(), onTap: () {  },)
        ],
      ),
    );
  }

  Widget _buildGreenContainer(Size size) {
    return Container(
      margin: const EdgeInsets.all(8),
      width: size.width,
      height: 250,
      decoration: const BoxDecoration(
        color: kGreen,
        borderRadius: BorderRadius.all(Radius.circular(18)),
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
            color: kBlue,
            borderRadius: BorderRadius.all(Radius.circular(12))
        ),
        child: Center(child: Text(text, style: kTextStyle)),
      ),
    );
  }
}