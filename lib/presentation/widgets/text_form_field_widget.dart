import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      obscureText: hintText == 'password' ? true : false,
      maxLines: 1,
      textCapitalization: TextCapitalization.sentences,
      textAlign: TextAlign.start,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
            fontSize: ScreenUtil().setSp(15),
            fontFamily: 'MS',
            fontWeight: FontWeight.w500,
            color: Colors.grey),
        /* border:
               (hintText == 'Notes') ? InputBorder.none : UnderlineInputBorder(),*/
      ),
    );
  }
}
