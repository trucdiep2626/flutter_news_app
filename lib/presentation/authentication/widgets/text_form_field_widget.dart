import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget(
      {Key? key,
      required this.controller,
      required this.validator,
      required this.hintText,
        required this.onChanged})
      : super(key: key);
  final Function(String?) onChanged;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final String hintText;
//  final bool

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      autovalidateMode: AutovalidateMode.always,
      autocorrect: false,
      controller: controller,
      validator: validator,
      obscureText: hintText == 'Mật khẩu' ? true : false,
      maxLines: 1,
      textCapitalization: TextCapitalization.sentences,
      textAlign: TextAlign.start,
      decoration: InputDecoration(
        errorStyle: TextStyle(
          fontSize: 15.sp,
          color: Colors.redAccent,
          fontWeight:  FontWeight.normal,
        ),
        hintText: hintText,
        hintStyle:  GoogleFonts.nunito(
          textStyle: TextStyle(
            fontSize: 18.sp,
            color: Colors.grey,
            fontWeight:  FontWeight.w500,
          ),
        )
      ),
    );
  }
}
