import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';
import '../../main_provider.dart';


class OnboardingDayNightSwitch extends StatelessWidget {
  const OnboardingDayNightSwitch({
    super.key,
  });

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
                height: 110,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(60)),
                  image: DecorationImage(
                      image: AssetImage('assets/images/${data.isDayOnboarding ? 'day' : 'night'}.png'),
                      fit: BoxFit.fill
                  ),
                ),
                duration: const Duration(milliseconds: 500),
                child: Stack(
                  children: [
                    AnimatedAlign(
                      duration: const Duration(milliseconds: 500),
                      alignment: data.isDayOnboarding ? Alignment.centerLeft : Alignment.centerRight,
                      child: GestureDetector(
                        onLongPress: () => data.switchDayOnboarding(context),
                        child: Container(
                          width: 80,
                          height: 80,
                          margin: const EdgeInsets.symmetric(horizontal: 20),
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
                            crossFadeState: data.isDayOnboarding ? CrossFadeState.showFirst : CrossFadeState.showSecond,
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
