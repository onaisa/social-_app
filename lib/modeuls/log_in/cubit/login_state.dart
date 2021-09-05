part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoudingState extends LoginState {}

class LoginSucessState extends LoginState {
  final String uid;
  LoginSucessState(this.uid);
}

class LoginErorrState extends LoginState {
  final String message;
  LoginErorrState({this.message});
}
