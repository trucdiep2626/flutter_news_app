import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/bloc/authentication/authentication_bloc.dart';
import 'package:flutter_news_app/bloc/authentication/authentication_event.dart';
import 'package:flutter_news_app/bloc/sign_in/sign_in_bloc.dart';
import 'package:flutter_news_app/bloc/sign_in/sign_in_event.dart';
import 'package:flutter_news_app/bloc/sign_in/sign_in_state.dart';
import 'package:flutter_news_app/presentation/authentication/sign_up/sign_up_screen.dart';
import 'package:flutter_news_app/presentation/authentication/widgets/button_widget.dart';
import 'package:flutter_news_app/presentation/authentication/widgets/flash_message.dart';
import 'package:flutter_news_app/presentation/authentication/widgets/text_form_field_widget.dart';
import 'package:flutter_news_app/repositories/user_repository.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SignInScreen extends StatelessWidget {
  // final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();

  final UserRepository userRepository;

  SignInScreen({required this.userRepository});
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var account;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignInBloc>(
        create: (context) => SignInBloc(userRepository: userRepository),
        child: BlocConsumer<SignInBloc, SignInState>(
            listener: (context, signInState) {
          if (signInState.isFailure) {
            ScaffoldMessenger.of(context).showSnackBar(FlashMessage(
              success: false,
              message: 'Đăng nhập không thành công',
            ));
          } else if (signInState.isSubmitting) {
          } else if (signInState.isSuccess) {
            BlocProvider.of<AuthenticationBloc>(context).add(SignedInEvent());
            ScaffoldMessenger.of(context).showSnackBar(FlashMessage(
              success: true,
              message: 'Đăng nhập thành công',
            ));
          }
        }, builder: (context, signInState) {
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
                        BlocProvider.of<SignInBloc>(context).add(
                            SetEmailToSignInEvent(email: emailController.text));
                      },
                      controller: emailController,
                      validator: (val) => signInState.isValidEmail
                          ? null
                          : 'Email không được bỏ trống',
                      hintText: 'Email',
                      showPassword: false,
                    ),
                    TextFormFieldWidget(
                      onChanged: (val) {
                        BlocProvider.of<SignInBloc>(context).add(
                            SetPasswordToSignInEvent(
                                password: passwordController.text));
                      },
                      controller: passwordController,
                      validator: (val) => signInState.isValidPassword
                          ? null
                          : 'Mật khẩu không được bỏ trống',
                      hintText: 'Mật khẩu',
                      showPassword: signInState.showPassword,
                      onPressedIconButton: () {
                        BlocProvider.of<SignInBloc>(context).add(
                            ShowPasswordEventInSignIn(
                                showPassword: !signInState.showPassword));
                      },
                    ),
                    ButtonWidget(
                        onTap: () {
                          BlocProvider.of<SignInBloc>(context).add(
                              SignInWithEmailEvent(
                                  email: emailController.text,
                                  password: passwordController.text));
                        },
                        labelText: 'Đăng nhập'),
                    GestureDetector(
                      onTap: () async {
                        account = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => SignUpScreen(
                                    userRepository: userRepository)));
                        if (account != null) {
                          BlocProvider.of<SignInBloc>(context).add(
                              SignInWithEmailEvent(
                                  email: account['email'],
                                  password: account['password']));
                          emailController.text = account['email'];
                          passwordController.text = account['password'];
                        }
                      },
                      child: Text(
                        'Tạo tài khoản mới',
                        style: GoogleFonts.nunito(
                            textStyle: TextStyle(
                          color: Colors.blueAccent,
                        )),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }));
  }
}
