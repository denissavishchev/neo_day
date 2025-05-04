import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';
import '../../main_provider.dart';
import 'day_button.dart';
import '../languages/language_widget.dart';

class TopWidget extends StatelessWidget {
  const TopWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
        builder: (context, data, _){
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('DAY', style: kBigTextStyle,),
              DayButton(icon: Icons.note_alt,
                  onTap: () => data.readNote()),
              LanguageWidget(),
              DayButton(icon: Icons.history, onTap: () {  },),
              DayButton(icon: Icons.add, onTap: () => data.showToAddHabit(context),)
            ],
          );
        }
    );
  }
}