import 'package:newchatapp/componentes/constants.dart';

class Message {
  final String message;
  final String id;

  Message(this.message, this.id);

  factory Message.fromjson(Map<String, dynamic> jsonData) {
    return Message(
      jsonData[kMessage]?.toString() ?? '',
      jsonData[kId]?.toString() ?? '',
    );
  }
}