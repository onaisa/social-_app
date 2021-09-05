import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import 'package:social_app/models/usermodel.dart';
import 'package:social_app/share/network/local/cache_helper.dart';
import 'package:social_app/share/network/remote/dio_helper.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  static RegisterCubit get(context) => BlocProvider.of(context);
  UserModel usermodel;
  void userRegister({
    String name,
    String phone,
    String email,
    String password,
    String image,
    String cover,
    String bio,
  }) async {
    emit(RegisterLoudingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(" user inf is ${value.user.email}");
      usercreat(
          name: name,
          email: email,
          cover:
              'https://image.freepik.com/free-photo/hand-painted-watercolor-background-with-sky-clouds-shape_24972-1095.jpg',
          image: 'https://image.flaticon.com/icons/png/128/1239/1239369.png',
          bio: 'write your bio...',
          phone: phone,
          uid: value.user.uid);
      CacheHelper.savedata(key: 'uid', value: value.user.uid);

      emit(RegisterSucessState(value.user.uid));
    }).catchError((error) {
      emit(RegisterErorrState(
          message:
              error.toString().substring(error.toString().indexOf(']') + 1)));
      print(error.toString().substring(error.toString().indexOf(']') + 1));
    });
  }

  void usercreat({
    @required String name,
    @required String email,
    @required String phone,
    @required String uid,
    @required String bio,
    @required String image,
    @required String cover,
  }) {
    UserModel model = UserModel(
      email: email,
      name: name,
      phone: phone,
      uid: uid,
      bio: bio,
      cover: cover,
      image: image,
    );
    FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .set(model.toMap())
        .then((value) {
      emit(CreateUserSucssesState());
    }).catchError((error) {
      print(error.toString().substring(error.toString().indexOf(']') + 1));
      emit(CreateUseErrorSucssesState(
          message:
              error.toString().substring(error.toString().indexOf(']') + 1)));
    });
  }
}
