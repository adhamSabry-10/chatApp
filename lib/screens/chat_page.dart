import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newchatapp/Cubits/chat_cubit.dart';
import 'package:newchatapp/Cubits/chat_state.dart';
import 'package:newchatapp/componentes/chat_buble.dart';
import 'package:newchatapp/componentes/constants.dart';
import 'package:newchatapp/model/Message.dart';

class ChatPage extends StatelessWidget {
  static String id = 'ChatPage';
  final _controller = ScrollController();
  List<Message> messageslist = [];
  TextEditingController Controller = TextEditingController();

  ChatPage({super.key});
  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kPrimaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'Assets/scholar.png',
              height: 50,
              width: 50,
            ),
            const Text(' Chat'),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child:
                BlocBuilder<ChatCubit, ChatState>(

            builder: (context, state) {
              var messageslist=BlocProvider.of<ChatCubit>(context).messageslist;
              return ListView.builder(
                  reverse: true,
                  controller: _controller,
                  itemCount: messageslist.length,
                  itemBuilder: (context, index) {
                    return messageslist[index].id == email
                        ? ChatBuble(message: messageslist[index])
                        : ChatBubleForFriend(message: messageslist[index]);
                  });
            }),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: Controller,
              onSubmitted: (data) {
                BlocProvider.of<ChatCubit>(context)
                    .sendMessage(message: data, email: email);
                Controller.clear();
                _controller.animateTo(
                  0,
                  duration:const Duration(microseconds: 500),
                  curve: Curves.easeIn,
                );
              },
              decoration: InputDecoration(
                  hintText: 'Send Message',
                  suffixIcon:const Icon(Icons.send, color: kPrimaryColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide:const BorderSide(
                        color: kPrimaryColor,
                      ))),
            ),
          ),
        ],
      ),
    );
  }
}
