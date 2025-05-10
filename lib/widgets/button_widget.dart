import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({super.key,
    required this.text,
    required this.onTap
  });

  final String text;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            border: Border.all(color: kWhite, width: 2)
        ),
        child: Center(child: Text(text.tr(), style: kTextStyle,)),
      ),
    );
  }
}
