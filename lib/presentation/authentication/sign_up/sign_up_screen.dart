
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/bloc/sign_up/sign_up_bloc.dart';
import 'package:flutter_news_app/bloc/sign_up/sign_up_event.dart';
import 'package:flutter_news_app/bloc/sign_up/sign_up_state.dart';
import 'package:flutter_news_app/data/repositories/user_repository.dart';
import 'package:flutter_news_app/presentation/authentication/widgets/button_widget.dart';
import 'package:flutter_news_app/presentation/authentication/widgets/flash_message.dart';
import 'package:flutter_news_app/presentation/authentication/widgets/text_form_field_widget.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends StatelessWidget {
  final UserRepository userRepository;

  SignUpScreen({required this.userRepository});

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
              success: false,
              message: 'Tạo tài khoản không thành công',
            ));
          } else if (signUpState.isSubmitting) {
          } else if (signUpState.isSuccess) {
            Navigator.pop(
                context,
                ({
                  'email': emailController.text,
                  'password': passwordController.text
                }));
            ScaffoldMessenger.of(context).showSnackBar(FlashMessage(
              success: true,
              message: 'Tạo tài khoản thành công',
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
                            SetEmailToSignUpEvent(email: emailController.text));
                      },
                      controller: emailController,
                      validator: (val) => signUpState.isValidEmail
                          ? null
                          : 'Email có định dạng chưa chính xác',
                      hintText: 'Email',
                      showPassword: false,
                    ),
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
                      hintText: 'Mật khẩu',
                      showPassword: signUpState.showPassword,
                      onPressedIconButton: () {
                        BlocProvider.of<SignUpBloc>(context).add(
                            ShowPasswordEventInSignUp(
                                showPassword: !signUpState.showPassword));
                      },
                    ),
                    ButtonWidget(
                        onTap: () {
                          BlocProvider.of<SignUpBloc>(context).add(
                              SignUpWithEmailEvent(
                                  email: emailController.text,
                                  password: passwordController.text));
                        },
                        labelText: 'Tạo tài khoản'),
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
