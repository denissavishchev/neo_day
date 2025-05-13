import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:neo_day/widgets/button_widget.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';
import '../../main_provider.dart';
import '../../widgets/onboarding_widgets/onboarding_day_night_switch.dart';
import '../main_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

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
                                    padding: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      gradient: LinearGradient(
                                          colors: [
                                            kWhite,
                                            kBlack
                                          ],
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                        stops: [0, 0.8]
                                      )
                                    ),
                                    child: Stack(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            color: data.isDayOnboarding ? kWhite : kBlack,
                                            image: DecorationImage(
                                                image: AssetImage(
                                                  data.isDayOnboarding
                                                  ? 'assets/images/day$index.jpg'
                                                  : 'assets/images/night$index.jpg',),
                                              fit: BoxFit.cover,
                                            ),
                                            borderRadius: BorderRadius.all(Radius.circular(8)),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(8),
                                                child: BackdropFilter(
                                                  filter: ImageFilter.blur(
                                                    sigmaX: 4,
                                                    sigmaY: 4,
                                                  ),
                                                  child: Container(
                                                    width: size.width,
                                                    padding: const EdgeInsets.symmetric(
                                                        horizontal: 12, vertical: 6),
                                                    decoration: BoxDecoration(
                                                        color: kWhite.withValues(alpha: 0.2),
                                                        borderRadius: BorderRadius.circular(8),
                                                        border: Border.all(
                                                            width: 1,
                                                            color: kWhite.withValues(alpha: 0.1))
                                                    ),
                                                    child: Text(
                                                      data.isDayOnboarding
                                                          ? 'day$index'.tr()
                                                          : 'night$index'.tr(),
                                                      style: kTextStyle.copyWith(
                                                        shadows: [
                                                          Shadow(
                                                            offset: Offset(1, 1),
                                                            blurRadius: 4,
                                                            color: kBlack,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                            ),
                          ),
                          const SizedBox(height: 6,),
                          ButtonWidget(
                              text: 'start',
                              onTap: () => Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) =>
                                  const MainScreen()))
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
