import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class AppConstants {
  static TextStyle activeStyle = GoogleFonts.nunito(
    textStyle: TextStyle(
      fontSize: 20.sp,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),
  );
  static TextStyle unActiveStyle = GoogleFonts.nunito(
    textStyle: TextStyle(
      fontSize: 18.sp,
      color: Colors.black26,
      fontWeight: FontWeight.bold,
    ),
  );
  static Color iconColor = Colors.black38;
  static Color activeColor = Colors.black;
  static Color unActiveColor = Colors.black26;
}
