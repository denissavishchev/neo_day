import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../main_provider.dart';
import '../constants.dart';

class DaySwitchWidget extends StatefulWidget {
  const DaySwitchWidget({
    super.key,
  });

  @override
  State<DaySwitchWidget> createState() => _DaySwitchWidgetState();
}

class _DaySwitchWidgetState extends State<DaySwitchWidget> {

  Timer? timer;

  @override
  void initState() {
    final data = Provider.of<MainProvider>(context, listen: false);
    data.updateTimer();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        data.updateTimer();
      });
    });
    super.initState();
  }
  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Consumer<MainProvider>(
        builder: (context, data, _){
          return Stack(
            alignment: Alignment.center,
            children: [
              AnimatedContainer(
                width: size.width,
                // height: 110,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(60)),
                  image: DecorationImage(
                      image: AssetImage('assets/images/${data.isDay ? 'day' : 'night'}.png'),
                      fit: BoxFit.fill
                  ),
                ),
                duration: const Duration(milliseconds: 500),
                child: Stack(
                  children: [
                    Positioned(
                        top: 14,
                        left: size.width * 0.1,
                        child: AnimatedOpacity(
                            opacity: data.isDay ? 0 : 1,
                            duration: Duration(milliseconds: data.isDay ? 200 : 500),
                            curve: Curves.easeInCubic,
                            child: Text(data.endTime == ''
                                ? ''
                                : 'Your previous day lasted ${data.previousDayDuration}\nand ended at ${data.endTime}',
                              style: kTangerineTextStyle,))),
                    Positioned(
                        bottom: 14,
                        left: size.width * 0.1,
                        child:
                        AnimatedOpacity(
                            opacity: data.isDay ? 0 : 1,
                            duration: Duration(milliseconds: data.isDay ? 200 : 500),
                            curve: Curves.easeInCubic,
                            child: Text('Start your new day',
                              style: kTangerineTextStyle,))),
                    Positioned(
                        top: 14,
                        left: size.width * 0.3,
                        child: AnimatedOpacity(
                            opacity: data.isDay ? 1 : 0,
                            duration: Duration(milliseconds: data.isDay ? 600 : 200),
                            curve: Curves.easeInCubic,
                            child: Text('Your day started at ${data.startTime}',
                              style: kBlackTextStyle,))),
                    Positioned(
                        bottom: 14,
                        left: size.width * 0.3,
                        child:
                        AnimatedOpacity(
                            opacity: data.isDay ? 1 : 0,
                            duration: Duration(milliseconds: data.isDay ? 600 : 200),
                            curve: Curves.easeInCubic,
                            child: Text('Day duration: ${data.dayDuration}',
                              style: kBlackTextStyle,))),
                    AnimatedAlign(
                      duration: const Duration(milliseconds: 500),
                      alignment: data.isDay ? Alignment.centerLeft : Alignment.centerRight,
                      child: GestureDetector(
                        onLongPress: () => data.switchDay(context),
                        child: Container(
                          width: 80,
                          height: 80,
                          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(60)),
                            boxShadow: [
                              BoxShadow(
                                  color: kBlack.withValues(alpha: 0.1),
                                  spreadRadius: 2,
                                  blurRadius: 1
                              )
                            ],
                          ),
                          child: AnimatedCrossFade(
                            firstChild: Image.asset('assets/images/sun.png'),
                            secondChild: Image.asset('assets/images/moon.png'),
                            crossFadeState: data.isDay ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                            duration: const Duration(milliseconds: 500),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              IgnorePointer(
                child: SizedBox(
                  height: 110,
                  child: SvgPicture.asset('assets/images/innerStripe.svg',
                    fit: BoxFit.fill,
                    colorFilter: const ColorFilter.mode(kBlack, BlendMode.srcIn),
                  ),
                ),
              ),
            ],
          );
        }
    );
  }
}
