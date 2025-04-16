import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../main_provider.dart';
import 'horizontal_switch_button_widget.dart';

class HabitsListWidget extends StatelessWidget {
  const HabitsListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Consumer<MainProvider>(
        builder: (context, data, _){
          return Center(
            child: Column(
              children: [
                Expanded(
                  child: SizedBox(
                    width: size.width,
                    child: ListView.builder(
                        itemCount: 3,
                        itemBuilder: (context, index){
                          return Container(
                            width: size.width,
                            margin: const EdgeInsets.only(bottom: 4),
                            padding: const EdgeInsets.fromLTRB(18, 6, 18, 12),
                            decoration: BoxDecoration(
                                color: kNavy.withValues(alpha: 0.3),
                                borderRadius: const BorderRadius.all(Radius.circular(4))
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text('habits[index].name',
                                      style: const TextStyle(
                                          color: kWhite,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18
                                      ),),
                                    const SizedBox(height: 8,),
                                    SizedBox(
                                      width: 240,
                                      child: Wrap(
                                        runAlignment: WrapAlignment.center,
                                        runSpacing: 4,
                                        children: List.generate(180, (i){
                                          // List<int> converted = habits[index].progress.split('')
                                          //     .map((v) => int.parse(v)).toList();
                                          // data.convertedLength = habits[index].days - (habits[index].days - converted.length);
                                          // converted.addAll(List.filled(habits[index].days - converted.length, 3));
                                          // data.zeros = converted.where((e) => e == 0).length;
                                          // data.ones = converted.where((e) => e == 1).length;
                                          return Container(
                                            margin: const EdgeInsets.only(right: 4),
                                            width: 12,
                                            height: 12,
                                            decoration: BoxDecoration(
                                                color: kIndigo.withValues(alpha: 0.2),
                                                borderRadius: const BorderRadius.all(Radius.circular(3)),
                                                border: Border.all(width: 1, color: kBlack)
                                            ),
                                          );
                                        }),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    HorizontalSwitchButtonWidget(
                                      onTap: () {},
                                      checked: true,
                                      index: index,),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.only(right: 4),
                                          width: 12,
                                          height: 12,
                                          decoration: BoxDecoration(
                                              color: kGreen,
                                              borderRadius: const BorderRadius.all(Radius.circular(3)),
                                              border: Border.all(width: 1, color: kBlack)
                                          ),
                                        ),
                                        const Text('- ', style: kTextStyle,),
                                        Text('100', style: kTextStyle,),
                                        const Text(' / ', style: kTextStyle,),
                                        Container(
                                          margin: const EdgeInsets.only(right: 4),
                                          width: 12,
                                          height: 12,
                                          decoration: BoxDecoration(
                                              color: kNavy.withValues(alpha: 0.2),
                                              borderRadius: const BorderRadius.all(Radius.circular(3)),
                                              border: Border.all(width: 1, color: kBlack)
                                          ),
                                        ),
                                        const Text('- ', style: kTextStyle,),
                                        Text('64', style: kTextStyle,),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Text('120', style: kTextStyle,),
                                        const Text(' / ', style: kTextStyle,),
                                        Text('180', style: kTextStyle,),
                                        const Text(' days', style: kTextStyle,),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }
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