import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/screens/cubits/register_cubit.dart';
import 'package:scholar_chat/screens/login_screen.dart';
import '../widgets/custom_botton.dart';
import '../widgets/custom_text_field.dart';
import '../constants.dart';
import 'chat_screen.dart';




class RegisterScreen extends StatelessWidget {
  static String id='RegisterScreen';
   String? email;

   String? password;

   bool isLoading=false;

   GlobalKey<FormState> formKey=GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit,RegisterState>(
      listener: (context, state) {
        if(state is RegisterLoading)
          {
            isLoading=true;
          }
        else if(state is RegisterSuccess)
          {
            Navigator.pushNamed(context, ChatScreen.id);
            isLoading=false;
          }
        else if(state is RegisterFailure)
        {
          showSnackBar(context, state.errorMessage);
          isLoading=false;
        }
      },
      builder: (context,state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Scaffold(
            backgroundColor: kPrimaryColor,
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Spacer(flex: 2,),
                    Image.asset('assets/images/scholar.png'),
                    Text('Scholar Chat', style: TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                      fontFamily: 'pacifico',
                    ),),
                    Spacer(flex: 1,),
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [Text('REGISTER', style: TextStyle(
                          fontSize: 26,
                          color: Colors.white,
                        ),
                        ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: CustomTextFormField(
                        hintText: 'Email', onChanged: (data) {
                        email = data;
                      },),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 15),
                      child: CustomTextFormField(
                        hintText: 'Password', onChanged: (data) {
                        password = data;
                      },),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: CustomButton(bottonText: 'REGISTER',
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            BlocProvider.of<RegisterCubit>(context).
                            registerUser(email: email!, password: password!);
                          }
                        },),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('already have an account ?',
                          style: TextStyle(color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Text('Login',
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
        );
      }
    );
  }

  void showSnackBar(BuildContext context,String message) {
     ScaffoldMessenger.of(context).showSnackBar(SnackBar
      (content: Text(message),),);
  }

  Future<void> registerUser() async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: email!, password: password!);
  }
}
