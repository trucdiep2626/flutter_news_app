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
import 'package:flutter_news_app/presentation/authentication/widgets/text_form_field_widget.dart';
import 'package:flutter_news_app/repositories/user_repository.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class SignInScreen extends StatelessWidget {
 // final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();

  final UserRepository userRepository;

  SignInScreen({required this.userRepository });
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var account;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<SignInBloc>(
    create: (context) => SignInBloc(userRepository: userRepository)),
    // BlocProvider<AuthenticationBloc>(
    // create: (context) => AuthenticationBloc(userRepository: userRepository)),
      ],
    child: BlocBuilder<SignInBloc,SignInState>(
    builder: (context, signInState) {
      if (signInState.isFailure) {
        print('Login failed');
      } else if (signInState.isSubmitting) {
        print('Logging in');
      } else if (signInState.isSuccess) {
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
               //       BlocProvider.of<SignInBloc>(context).add(SetEmailToSignInEvent(email: emailController.text));
                    },
                    controller: emailController,
                    validator: (val) => signInState.isValidEmail
                        ? null
                        : 'Invalid email format',
                    hintText: 'email'),
                TextFormFieldWidget(
                    onChanged: (val)
                    {
                   //   BlocProvider.of<SignInBloc>(context).add(SetPasswordToSignInEvent(password: passwordController.text));
                    },
                    controller: passwordController,
                    validator: (val) => signInState.isValidPassword
                        ? null
                        : 'Invalid password format',
                    hintText: 'password'),
                (emailController.text==null || passwordController.text==null)?
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black12
                  ),
                  child: Text('Sign in',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold),

                  ),
                ):
                GestureDetector(
                  onTap:/*    (emailController.text=='' || passwordController.text=='')?(){} : */ (){
                   BlocProvider.of<SignInBloc>(context).add(SignInWithEmailEvent(email: emailController.text, password: passwordController.text));
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
                      child: Text('Sign in',
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(18),
                        color: Colors.white,
                        fontWeight: FontWeight.bold),

                    ),
                ),
                ),
                GestureDetector(
                  onTap:
                  ()async{
                  account= await Navigator.push(context,
                        MaterialPageRoute(builder: (_)=> SignUpScreen(userRepository: userRepository) ))   ;

                  if(account !=null)
                  {
                    log('hhhhhhhhhhhhhhhhhhhhhhh');
                    BlocProvider.of<SignInBloc>(context).add(SignInWithEmailEvent(email: account['email'], password: account['password']));
                    emailController.text=account['email'];
                    passwordController.text= account['password'];
                  }

                  },
                  child: Text('Create a new account',
                  style: TextStyle(
                    color: Colors.blueAccent
                  ),),
                )
              ],
            ),
          ),
        ),
      );
    } ));
  }
}
