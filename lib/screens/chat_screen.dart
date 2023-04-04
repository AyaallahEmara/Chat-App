import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scholar_chat/screens/cubits/chat_cubit.dart';
import '../models/message_model.dart';
import '../widgets/custom_chatbuble.dart';

class ChatScreen extends StatelessWidget {
  final _controller = ScrollController();
  static String id = 'ChatScreen';
 // List<Message> messagesList = [];
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute
        .of(context)!
        .settings
        .arguments;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kPrimaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/scholar.png'
              , height: 50,
            ),
            Text('Chat'),
          ],
        ),
        centerTitle: true,
      ),
      body:
      Column(
        children: [
          Expanded(
            child:
            BlocBuilder<ChatCubit,ChatState>(

              builder: ( context, state) {
                var messagesList =  BlocProvider.of<ChatCubit>(context).messagesList;
              return ListView.builder(
                  reverse: true,
                  controller: _controller,
                  itemCount: messagesList.length,
                  itemBuilder: (context, index) {
                    return messagesList[index].id == email ?
                    ChatBuble(message: messagesList[index],) :
                    ChatBubleForFriend(message: messagesList[index],);
                  });},

            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: controller,
              onSubmitted: (data) {
               BlocProvider.of<ChatCubit>(context).
               sendMessage(message: data, email: email.toString());
                controller.clear();
                _controller.animateTo(
                    0,
                    duration: Duration(seconds: 1),
                    curve: Curves.easeIn);
              },
              decoration: InputDecoration(
                hintText: 'Send Message',
                suffixIcon: Icon(Icons.send,
                  color: kPrimaryColor,),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),

                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    color: kPrimaryColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

    );
  }
}
      /*  else
          {
            return Scaffold(
                body: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Loading......',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                        fontFamily: 'pacifico',
                    ),),
                  ],
                ));
          }*/


