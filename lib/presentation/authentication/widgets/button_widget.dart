import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({Key? key, required this.onTap, required this.labelText})
      : super(key: key);
  final Function()? onTap;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(
            top: ScreenUtil().setHeight(40),
            bottom: ScreenUtil().setHeight(20)),
        padding: EdgeInsets.symmetric(
          vertical: ScreenUtil().setHeight(10),
          horizontal: ScreenUtil().setHeight(40),
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.blueAccent),
        child: Text(labelText,
            style: GoogleFonts.nunito(
              textStyle: TextStyle(
                  fontSize: 18.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            )),
      ),
    );
  }
}
