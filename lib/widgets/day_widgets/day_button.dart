import 'package:flutter/material.dart';
import '../../constants.dart';

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
        width: 50,
        height: 40,
        decoration: BoxDecoration(
            color: kWhite,
            borderRadius: BorderRadius.all(Radius.circular(8))
        ),
        child: Icon(icon, color: kBlack, size: 35,),
      ),
    );
  }
}