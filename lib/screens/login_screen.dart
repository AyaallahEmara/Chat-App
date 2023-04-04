import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat/screens/cubits/chat_cubit.dart';
import 'package:scholar_chat/screens/cubits/login_cubit.dart';
import 'package:scholar_chat/screens/register_screen.dart';
import 'package:scholar_chat/widgets/custom_botton.dart';
import 'package:scholar_chat/widgets/custom_text_field.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../constants.dart';
import 'chat_screen.dart';


class LoginScreen extends StatelessWidget {
  String? email;
  static String id='LoginPage';
  String? password;

  bool isLoading=false;

  GlobalKey<FormState> formKey=GlobalKey();
  @override
  Widget build(BuildContext context) {
    return
      BlocListener<LoginCubit,LoginState>(
      listener: (context, state) {
        if(state is LoginLoading)
          {
            isLoading=true;
          }
        else if(state is LoginSuccess)
          {
            BlocProvider.of<ChatCubit>(context).resieveMessages();
            Navigator.pushNamed(context, ChatScreen.id,arguments: email);
            isLoading=false;
          }
        else if(state is LoginFailure)
          {
            showSnackBar(context, state.errorMessage);
            isLoading=false;
          }
      },
      child: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
          backgroundColor: kPrimaryColor,
          body: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 8),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Spacer(flex: 2,),
                  Image.asset('assets/images/scholar.png'),
                  Text('Scholar Chat',style: TextStyle(
                    fontSize: 32,
                    color: Colors.white,
                    fontFamily: 'pacifico',
                  ),),
                  Spacer(flex: 1,),
                  Padding(
                    padding:  EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [Text('LOGIN',style: TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                      ),
                      ),
              ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: CustomTextFormField(hintText: 'Email',onChanged: (data)
                      {
                        email=data;
                      },),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(bottom: 15),
                    child: CustomTextFormField(obscureText: true,hintText: 'Password',onChanged: (data)
                      {
                        password=data;
                      },),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: CustomButton(bottonText: 'LOGIN',
                    onTap: ()async
                      {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<LoginCubit>(context).
                          loginUser(email: email!, password: password!);

                        }
                      },),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('don\'t have an account ?',
                      style: TextStyle(color: Colors.white,
                      ),
                      ),
                      Padding(
                        padding:  EdgeInsets.only(left: 8),
                        child: GestureDetector(
                          onTap: ()
                          {
                            Navigator.pushNamed(context, RegisterScreen.id);
                          },
                          child: Text('Register',
                            style: TextStyle(color: Color(0xFFC7EDE6),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Spacer(flex: 3,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  void showSnackBar(BuildContext context,String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar
      (content: Text(message),),);
  }

  Future<void> loginUser() async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
        email: email!, password: password!);
  }
}
