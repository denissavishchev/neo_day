import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../main_provider.dart';

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
                border: Border.all(color: kIndigo.withValues(alpha: 0.5), width: 1),
                borderRadius: const BorderRadius.all(Radius.circular(14)),
                boxShadow: [
                  BoxShadow(
                    color: kBlue.withValues(alpha: 0.5),
                  ),
                  const BoxShadow(
                    color: kGrey,
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
                          color: checked ? kTangerine : kBlue,
                          width: 1),
                      boxShadow: [
                        BoxShadow(
                            color: checked ? kTangerine.withValues(alpha: 0.1) : kBlack.withValues(alpha: 0.2),
                            spreadRadius: 2,
                            blurRadius: 2,
                            offset: const Offset(0, 2)
                        )
                      ],
                      gradient: const LinearGradient(
                          colors: [
                            kGrey,
                            kBlue
                          ],
                          begin: Alignment.bottomRight,
                          end: Alignment.topLeft
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(12))
                  ),
                  child: Center(
                    child: AnimatedCrossFade(
                      firstChild: const Icon(Icons.circle, color: kTangerine, size: 18,),
                      secondChild: const Icon(Icons.circle, color: kBlue, size: 18,),
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
