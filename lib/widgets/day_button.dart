import 'package:flutter/material.dart';

import '../constants.dart';

class DayButton extends StatelessWidget {
  const DayButton({
    super.key, required this.icon, required this.onTap,
  });

  final IconData icon;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
            color: kBlue,
            borderRadius: BorderRadius.all(Radius.circular(12))
        ),
        child: Icon(icon, color: kWhite, size: 40,),
      ),
    );
  }
}