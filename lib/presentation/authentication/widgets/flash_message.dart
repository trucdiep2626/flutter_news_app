import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FlashMessage extends SnackBar {
  final bool success;
  final String message;

  FlashMessage({required this.success, required this.message})
      : super(
          duration: Duration(milliseconds: 500),
          content: Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Icon(
                    success ? Icons.check_circle : Icons.error,
                    color: success ? Colors.green : Colors.red,
                  )),
              Expanded(
                flex: 10,
                child: Text(
                  message,
                  style: GoogleFonts.nunito(
                    textStyle: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        );
}
