import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newchatapp/componentes/Buttons.dart';
import 'package:newchatapp/componentes/constants.dart';
import 'package:newchatapp/componentes/widgets.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:newchatapp/helper/Snack_bar.dart';
import 'package:newchatapp/screens/blocs/auth_bloc/auth_bloc.dart';
import 'package:newchatapp/screens/chat_page.dart';

class RegisterScreen extends StatelessWidget {
  String? email;
  String? password;
  bool Isloading = false;
  GlobalKey<FormState> formkey = GlobalKey();

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
      if (state is RegisterLoading) {
        Isloading = true;
      } else if (state is RegisterSuccess) {
        Navigator.pushNamed(context, ChatPage.id, arguments: email);
        Isloading = false;
      } else if (state is RegisterFailure) {
        ShowSnackBar(context, state.ErrorMessage);
        Isloading = false;
      }
    }, builder: (context, state) {
      return ModalProgressHUD(
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
                        Text('Register',
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
                          BlocProvider.of<AuthBloc>(context).add(RegisterEvent(
                              email: email!, password: password!));
                        }
                      },
                      text: 'Register',
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Already have an account ?',
                          style: TextStyle(color: Colors.white),
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              '  Login',
                              style: TextStyle(color: Color(0xffC7EDE6)),
                            ))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
