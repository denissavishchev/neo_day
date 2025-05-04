import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const kBlue = Color(0xff104c64);
const kGrey = Color(0xffc9dfdc);
const kRed = Color(0xffb6410f);
const kBlack = Color(0xff0c0c0c);
const kWhite = Color(0xfff3f1db);
const kTangerine = Color(0xffe5551a);
const kTangerineLight = Color(0xffff532e);

const kIndigo = Color(0xff0d0d55);
const kNavy = Color(0xff24e0ff);
const kGreen = Color(0xffe2e603);

TextStyle kTextStyle = TextStyle(
    color: kWhite,
    fontSize: 24.sp,
    fontWeight: FontWeight.bold
);

TextStyle kTangerineTextStyle = TextStyle(
    color: kTangerine,
    fontSize: 24.sp,
    fontWeight: FontWeight.bold
);

TextStyle kBlackTextStyle = TextStyle(
    color: kBlack,
    fontSize: 24.sp,
    fontWeight: FontWeight.bold
);

TextStyle kBigTextStyle = TextStyle(
    color: kWhite,
    fontSize: 80.sp,
    height: 1,
    fontWeight: FontWeight.bold
);

const textFieldDecoration = InputDecoration(
  // hintStyle: kTextStyle,
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: kGreen)
  ),
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: kGreen)
  ),
  focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: kRed)
  ),
  errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: kRed)
  ),
);