import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';
import '../../main_provider.dart';

class TaskSwitchButtonWidget extends StatelessWidget {
  const TaskSwitchButtonWidget({
    super.key,
    required this.onTap,
    required this.checked,
    required this.index,
  });

  final VoidCallback onTap;
  final bool checked;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
        builder: (context, data, _){
          return GestureDetector(
            onTap: onTap,
            child: Container(
              width: 60,
              height: 80,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              decoration: BoxDecoration(
                border: Border.all(color: kBlack.withValues(alpha: 0.7), width: 1),
                borderRadius: const BorderRadius.all(Radius.circular(14)),
                boxShadow: [
                  BoxShadow(
                    color: kBlack.withValues(alpha: 0.3),
                  ),
                  const BoxShadow(
                    color: kWhite,
                    spreadRadius: -4.0,
                    blurRadius: 4.0,
                  ),
                ],
              ),
              child: AnimatedAlign(
                duration: const Duration(milliseconds: 200),
                alignment: checked ? Alignment.topCenter : Alignment.bottomCenter,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 54,
                  height: 34,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: checked
                              ? kTangerine.withValues(alpha: 0.8)
                              : kBlack.withValues(alpha: 0.8),
                          width: 1),
                      boxShadow: [
                        BoxShadow(
                            color: kBlack.withValues(alpha: 0.1),
                            spreadRadius: 2,
                            blurRadius: 2,
                            offset: const Offset(0, 2)
                        )
                      ],
                      gradient: LinearGradient(
                          colors: [
                            kWhite,
                            kGrey
                          ],
                          begin: Alignment.bottomRight,
                          end: Alignment.topLeft
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(12))
                  ),
                  child: Center(
                    child: AnimatedCrossFade(
                      firstChild: ColorLine(color: kTangerine,),
                      secondChild: ColorLine(color: kBlack),
                      crossFadeState: checked ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                      duration: const Duration(milliseconds: 100),
                    ),
                  ),
                ),
              ),
            ),
          );
        }
    );
  }
}

class ColorLine extends StatelessWidget {
  const ColorLine({
    super.key, 
    required this.color,
  });
  
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 8,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: kBlack, width: 1),
      ),
    );
  }
}
