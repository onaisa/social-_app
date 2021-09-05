part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoudingState extends RegisterState {}

class RegisterSucessState extends RegisterState {
  String uid;
  RegisterSucessState(this.uid);
}

class RegisterErorrState extends RegisterState {
  final String message;
  RegisterErorrState({this.message});
}

class CreateUserSucssesState extends RegisterState {}

class CreateUseErrorSucssesState extends RegisterState {
  final String message;
  CreateUseErrorSucssesState({this.message});
}
