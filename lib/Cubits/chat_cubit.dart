import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newchatapp/Cubits/chat_state.dart';
import 'package:newchatapp/componentes/constants.dart';
import 'package:newchatapp/model/Message.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  CollectionReference Messages =
      FirebaseFirestore.instance.collection(kMessageCollection);
  List<Message> messageslist = [];

  void sendMessage({required String message, required String email}) {
    try {
      Messages.add(
          {'message': message, 'CreatedAt': DateTime.now(), 'id': email});
    } catch (e) {}
  }

  void getmessage() {
    Messages.orderBy(kTime, descending: true).snapshots().listen((event) {
      messageslist.clear();
      for (var doc in event.docs) {
        messageslist.add(Message.fromjson(doc.data() as Map<String, dynamic>));
      }
      emit(ChatSuccess(messages: messageslist));
    });
  }
}
