import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:newchatapp/Cubits/chat_cubit.dart';
import 'package:newchatapp/componentes/Buttons.dart';
import 'package:newchatapp/componentes/constants.dart';
import 'package:newchatapp/componentes/widgets.dart';
import 'package:flutter/material.dart';
import 'package:newchatapp/helper/Snack_bar.dart';
import 'package:newchatapp/screens/blocs/auth_bloc/auth_bloc.dart';
import 'package:newchatapp/screens/chat_page.dart';

class LoginPage extends StatelessWidget {
  String? email, password;
  bool Isloading = false;
  GlobalKey<FormState> formkey = GlobalKey();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          Isloading = true;
        } else if (state is LoginSuccess) {
          BlocProvider.of<ChatCubit>(context).getmessage();
          Navigator.pushNamed(context, ChatPage.id, arguments: email);
          Isloading = false;
        } else if (state is LoginFailure) {
          ShowSnackBar(context, state.ErrorMessage);
          Isloading = false;
        }
      },
      child: ModalProgressHUD(
        inAsyncCall: Isloading,
        child: Scaffold(
          backgroundColor: kPrimaryColor,
          body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Form(
                key: formkey,
                child: ListView(
                  children: [
                    Image.asset(
                      'Assets/scholar.png',
                      height: 100,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Scholar Chat',
                          style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 75,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Login',
                            style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomeWidgites(
                      onchanged: (data) {
                        email = data;
                      },
                      hinttext: ' Email',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomeWidgites(
                      obscureText: true,
                      onchanged: (data) {
                        password = data;
                      },
                      hinttext: ' Password',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomeButtons(
                        ontap: () async {
                          if (formkey.currentState!.validate()) {
                            BlocProvider.of<AuthBloc>(context).add(
                                LoginEvent(email: email!, password: password!));
                          }
                        },
                        text: 'Log in'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'dont have an account ?',
                          style: TextStyle(color: Colors.white),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, 'RegisterScreen');
                          },
                          child: const Text(
                            '  Register',
                            style: TextStyle(color: Color(0xffC7EDE6)),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
