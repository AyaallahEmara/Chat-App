
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../models/message_model.dart';

class ChatBuble extends StatelessWidget {
  ChatBuble({required this.message});
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.only(left: 16,top: 32,bottom: 32,right: 16),
        margin: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight:Radius.circular(32) ,
            bottomRight: Radius.circular(32),
          ),
          color: kPrimaryColor,
        ),
        child: Text(message.message,style:
        TextStyle(
          color: Colors.white,
        ),),
      ),
    );
  }
}


class ChatBubleForFriend extends StatelessWidget {
  ChatBubleForFriend({required this.message});
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.only(left: 16,top: 32,bottom: 32,right: 16),
        margin: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight:Radius.circular(32) ,
            bottomLeft: Radius.circular(32),
          ),
          color: Color(0xFF006D84),
        ),
        child: Text(message.message,style:
        TextStyle(
          color: Colors.white,
        ),),
      ),
    );
  }
}
