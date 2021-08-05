import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/bloc/authentication/authentication_bloc.dart';
import 'package:flutter_news_app/bloc/authentication/authentication_event.dart';
import 'package:flutter_news_app/bloc/sign_up/sign_up_bloc.dart';
import 'package:flutter_news_app/bloc/sign_up/sign_up_event.dart';
import 'package:flutter_news_app/bloc/sign_up/sign_up_state.dart';
import 'package:flutter_news_app/presentation/authentication/widgets/flash_message.dart';
import 'package:flutter_news_app/presentation/authentication/widgets/text_form_field_widget.dart';
import 'package:flutter_news_app/repositories/user_repository.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends StatelessWidget {
  final UserRepository userRepository;

  SignUpScreen({required this.userRepository});
  // final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpBloc>(
        create: (context) => SignUpBloc(userRepository: userRepository),
        child: BlocConsumer<SignUpBloc, SignUpState>(
            listener: (context, signUpState) {
          if (signUpState.isFailure) {
            ScaffoldMessenger.of(context).showSnackBar(FlashMessage(
              type: 'Fail',
            ));
          } else if (signUpState.isSubmitting) {
            print('Logging in');
          } else if (signUpState.isSuccess) {
            Navigator.pop(
                context,
                ({
                  'email': emailController.text,
                  'password': passwordController.text
                }));
            ScaffoldMessenger.of(context).showSnackBar(FlashMessage(
              type: 'Success',
            ));
          }
        }, builder: (context, signUpState) {
          return Scaffold(
            body: Form(
              child: Padding(
                padding: EdgeInsets.all(ScreenUtil().setHeight(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormFieldWidget(
                        onChanged: (val) {
                          BlocProvider.of<SignUpBloc>(context).add(
                              SetEmailToSignUpEvent(
                                  email: emailController.text));
                        },
                        controller: emailController,
                        validator: (val) => signUpState.isValidEmail
                            ? null
                            : 'Định dạng email chưa đúng',
                        hintText: 'Email'),
                    TextFormFieldWidget(
                        onChanged: (val) {
                          BlocProvider.of<SignUpBloc>(context).add(
                              SetPasswordToSignUpEvent(
                                  password: passwordController.text));
                        },
                        controller: passwordController,
                        validator: (val) => signUpState.isValidPassword
                            ? null
                            : 'Mật khẩu cần ít nhất 6 kí tự',
                        hintText: 'Mật khẩu'),
                    // ( signUpState.isValidEmail ==false ||signUpState.isValidPassword ==false )?
                    // Container(
                    //   margin: EdgeInsets.only(
                    //       top: ScreenUtil().setHeight(40),
                    //       bottom: ScreenUtil().setHeight(20)
                    //   ),
                    //   padding: EdgeInsets.symmetric(
                    //     vertical: ScreenUtil().setHeight(10),
                    //     horizontal: ScreenUtil().setHeight(40),
                    //   ),
                    //   decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(20),
                    //       color: Colors.black26
                    //   ),
                    //   child: Text('Tạo tài khoản',
                    //     style: GoogleFonts.nunito(
                    //       textStyle: TextStyle(
                    //         fontSize: 18.sp,
                    //         color: Colors.black,
                    //         fontWeight:  FontWeight.bold,
                    //       ),
                    //     )
                    //
                    //   ),
                    // ):
                    GestureDetector(
                      onTap: () {
                        BlocProvider.of<SignUpBloc>(context).add(
                            SignUpWithEmailEvent(
                                email: emailController.text,
                                password: passwordController.text));
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            top: ScreenUtil().setHeight(40),
                            bottom: ScreenUtil().setHeight(20)),
                        padding: EdgeInsets.symmetric(
                          vertical: ScreenUtil().setHeight(10),
                          horizontal: ScreenUtil().setHeight(40),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.blueAccent),
                        child: Text('Tạo tài khoản',
                            style: GoogleFonts.nunito(
                              textStyle: TextStyle(
                                fontSize: 18.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text('Đăng nhập',
                          style: GoogleFonts.nunito(
                            textStyle: TextStyle(
                              color: Colors.blueAccent,
                            ),
                          )),
                    )
                  ],
                ),
              ),
            ),
          );
        }));
  }
}
