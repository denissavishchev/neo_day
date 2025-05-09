import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';
import '../../main_provider.dart';
import '../../widgets/onboarding_widgets/onboarding_day_night_switch.dart';

class OnboardingOne extends StatelessWidget {
  const OnboardingOne({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Consumer<MainProvider>(
        builder: (context, data, _){
          return SafeArea(
            child: Scaffold(
                body: GestureDetector(
                  onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                  child: Container(
                    width: size.width,
                    height: size.height,
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    color: kBlack,
                    child: Column(
                        spacing: 12,
                        children: [
                          const SizedBox(height: 6,),
                          OnboardingDayNightSwitch(),
                          SizedBox(
                            height: size.height * 0.65,
                            child: PageView.builder(
                              controller: data.onboardingPageController,
                              itemCount: 3,
                                itemBuilder: (context, index){
                                  return Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 6),
                                    decoration: BoxDecoration(
                                      color: data.isDayOnboarding ? kWhite : kBlack,
                                      borderRadius: BorderRadius.all(Radius.circular(8)),
                                      border: Border.all(
                                          color: data.isDayOnboarding ? kBlack : kWhite,
                                        width: 2
                                      )
                                    ),
                                  );
                                }
                            ),
                          )
                        ]
                    ),
                  ),
                )
            ),
          );
        }
    );
  }
}
