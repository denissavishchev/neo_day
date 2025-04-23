import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../main_provider.dart';

class MotivationWidget extends StatelessWidget {
  const MotivationWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Consumer<MainProvider>(
        builder: (context, data, _){
          return Visibility(
            visible: data.isDay,
            child: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MotivationButton(text: 'Quote', onTap: () => data.showMotivation(),),
                    MotivationButton(text: 'Advice', onTap: () {  },),
                    MotivationButton(text: 'Joke', onTap: () {  },)
                  ],
                ),
                AnimatedPositioned(
                  duration: Duration(milliseconds: 300),
                  top: 0,
                  bottom: 0,
                  right: data.isMotivation ? 0 : -size.width,
                  width: size.width - 36,
                  child: Container(
                    decoration: BoxDecoration(
                      color: kBlue,
                      borderRadius: BorderRadius.all(Radius.circular(12))
                    ),
                    child: Center(
                      child: Text('Motivation Text',
                        style: kTextStyle,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
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
        height: 60,
        decoration: BoxDecoration(
            color: kBlue,
            borderRadius: BorderRadius.all(Radius.circular(12))
        ),
        child: Center(child: Text(text, style: kTextStyle)),
      ),
    );
  }
}