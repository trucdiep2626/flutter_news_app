import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/bloc/authentication/authentication_bloc.dart';
import 'package:flutter_news_app/bloc/authentication/authentication_event.dart';
import 'package:flutter_news_app/bloc/sign_up/sign_up_bloc.dart';
import 'package:flutter_news_app/bloc/sign_up/sign_up_event.dart';
import 'package:flutter_news_app/bloc/sign_up/sign_up_state.dart';
import 'package:flutter_news_app/presentation/widgets/text_form_field_widget.dart';
import 'package:flutter_news_app/repositories/user_repository.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class SignUpScreen extends StatelessWidget {
  final UserRepository userRepository;

  SignUpScreen({required this.userRepository});
  // final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  BlocProvider<SignUpBloc>(
        create: (context) => SignUpBloc(userRepository: userRepository),
    child:  BlocBuilder<SignUpBloc, SignUpState>(
        builder: (context, signUpState) {
      if (signUpState.isFailure) {
        print('Login failed');
      } else if (signUpState.isSubmitting) {
        print('Logging in');
      } else if (signUpState.isSuccess) {
        //add event: AuthenticationEventLoggedIn ?
        BlocProvider.of<AuthenticationBloc>(context).add(SignedInEvent());
      }
      return Scaffold(

        body: Form(
          child: Padding(
            padding: EdgeInsets.all(ScreenUtil().setHeight(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormFieldWidget(
                  onChanged: (val)
                    {
                 // BlocProvider.of<SignUpBloc>(context).add(SetEmailToSignUpEvent(email: emailController.text));
                    },
                    controller: emailController,
                    validator: (val) => signUpState.isValidEmail
                        ? null
                        : 'Invalid email format',
                    hintText: 'email'),
                TextFormFieldWidget(
                    onChanged: (val)
                    {
                   //  BlocProvider.of<SignUpBloc>(context).add(SetPasswordToSignUpEvent(password: passwordController.text));
                    },
                    controller: passwordController,
                    validator: (val) => signUpState.isValidPassword
                        ? null
                        : 'Invalid password format',
                    hintText: 'password'),
                (emailController.text==null || passwordController.text==null)?
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black12
                  ),
                  child: Text('Sign up',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold),

                  ),
                ):
                GestureDetector(
                  onTap: (){
                    BlocProvider.of<SignUpBloc>(context).add(SignUpWithEmailEvent(email: emailController.text, password: passwordController.text));
                    Navigator.pop(context,({
                      'email':emailController.text,
                      'password':passwordController.text
                    }));
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                        top: ScreenUtil().setHeight(40),
                        bottom: ScreenUtil().setHeight(20)
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: ScreenUtil().setHeight(10),
                      horizontal: ScreenUtil().setHeight(40),
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.blueAccent
                    ),
                    child: Text('Create a new account',
                      style: TextStyle(fontSize: ScreenUtil().setSp(18),
                          color: Colors.white,
                          fontWeight: FontWeight.bold),

                    ),
                  ),
                ),
                GestureDetector(
                  onTap:
                      (){

                    Navigator.pop(context);
                  },
                  child: Text('Sign in',
                    style: TextStyle(
                        color: Colors.blueAccent
                    ),),
                )
              ],
            ),
          ),
        ),
      );
    }));
  }
}
