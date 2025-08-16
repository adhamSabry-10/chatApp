import 'package:newchatapp/model/Message.dart';

abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatSuccess extends ChatState {
  List<Message>messages;
  ChatSuccess({required this.messages});

}
