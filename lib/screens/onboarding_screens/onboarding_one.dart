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
