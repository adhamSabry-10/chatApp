import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthBloc() : super(AuthInitial()) {
    on<LoginEvent>(_handleLogin);
    on<RegisterEvent>(_handleRegister);
  }

  Future<void> _handleLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(LoginLoading());
    try {
      await _auth.signInWithEmailAndPassword(
          email: event.email, password: event.password);
      emit(LoginSuccess());
    } on FirebaseAuthException catch (ex) {
      if (ex.code == 'user-not-found') {
        emit(LoginFailure(ErrorMessage: 'User not found'));
      } else if (ex.code == 'wrong-password') {
        emit(LoginFailure(ErrorMessage: 'Wrong password'));
      } else {
        emit(LoginFailure(ErrorMessage: 'FirebaseAuth error: ${ex.message}'));
      }
    } catch (e) {
      emit(LoginFailure(ErrorMessage: 'Something went wrong'));
    }
  }

  Future<void> _handleRegister(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(RegisterLoading());
    try {
      await _auth.createUserWithEmailAndPassword(
          email: event.email, password: event.password);
      emit(RegisterSuccess());
    } on FirebaseAuthException catch (ex) {
      if (ex.code == 'weak-password') {
        emit(RegisterFailure(ErrorMessage: 'Weak password'));
      } else if (ex.code == 'email-already-in-use') {
        emit(RegisterFailure(ErrorMessage: 'Email already in use'));
      } else {
        emit(RegisterFailure(ErrorMessage: 'FirebaseAuth error: ${ex.message}'));
      }
    } catch (e) {
      emit(RegisterFailure(ErrorMessage: 'Something went wrong'));
    }
  }
}