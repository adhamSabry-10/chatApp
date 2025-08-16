import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newchatapp/Cubits/chat_cubit.dart';
import 'package:newchatapp/screens/blocs/auth_bloc/auth_bloc.dart';
import 'package:newchatapp/screens/chat_page.dart';

import 'package:flutter/material.dart';
import 'package:newchatapp/screens/login_page.dart';
import 'package:newchatapp/simple_bloc_observer.dart';
import 'firebase_options.dart';
import 'screens/Register.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Bloc.observer = SimpleBlocObserver();
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ChatCubit()),
        BlocProvider(create: (context) => AuthBloc()),
      ],
      child: MaterialApp(
        routes: {
          'loginPage': (context) => LoginPage(),
          'RegisterScreen': (context) => RegisterScreen(),
          ChatPage.id: (context) => ChatPage(),
        },
        debugShowCheckedModeBanner: false,
        initialRoute: 'loginPage',
      ),
    );
  }
}
