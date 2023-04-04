import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../../constants.dart';
import '../../models/message_model.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  CollectionReference messages =
  FirebaseFirestore.instance.collection(kMessagesCollection);
  List<Message> messagesList = [];
  void sendMessage({required String message,required String email})
  {
   try {
     messages.add(
         {
           kMessage: message,
           kCreatedAt: DateTime.now(),
           'id': email,
         });
   }
   on Exception catch(ex)
    {

    }
  }
  void resieveMessages()
  {
    messages.orderBy(kCreatedAt,descending: true

    ).snapshots().listen((event) {
          messagesList.clear();
      for(var doc in event.docs)
        {
          messagesList.add(Message.fromJson(doc));
        }
      emit(ChatSuccess(messages: messagesList));
    });
  }
}
