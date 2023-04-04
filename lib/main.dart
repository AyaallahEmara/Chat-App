import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat/screens/chat_screen.dart';
import 'package:scholar_chat/screens/cubits/chat_cubit.dart';
import 'package:scholar_chat/screens/cubits/login_cubit.dart';
import 'package:scholar_chat/screens/cubits/register_cubit.dart';
import 'package:scholar_chat/screens/login_screen.dart';
import 'package:scholar_chat/screens/register_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp( ScholarChat());
}
class ScholarChat extends StatelessWidget {
   ScholarChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
       MultiBlocProvider
         (
         providers: [
           BlocProvider(create: (context)=>LoginCubit()),
           BlocProvider(create: (context)=>RegisterCubit()),
           BlocProvider(create: (context)=>ChatCubit()),
         ],
         child: MaterialApp(
          routes: {
            LoginScreen.id : (context) => LoginScreen(),
            RegisterScreen.id : (context) => RegisterScreen(),
            ChatScreen.id : (context)=>ChatScreen(),
          },
          home: LoginScreen(),

    ),
       );
  }
}
