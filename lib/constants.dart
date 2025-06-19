import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const kGrey = Color(0xffc9dfdc);
const kBlack = Color(0xff0c0c0c);
const kWhite = Color(0xfff3f1db);
const kTangerine = Color(0xffe5551a);


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

TextStyle kMediumTextStyle = TextStyle(
    color: kBlack,
    fontSize: 40.sp,
    height: 1,
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
      borderSide: BorderSide(color: kWhite)
  ),
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: kWhite)
  ),
  focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: kTangerine)
  ),
  errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: kTangerine)
  ),
);