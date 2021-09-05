import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_app/models/usermodel.dart';
import 'package:social_app/share/copmonents/constance.dart';
import 'package:social_app/share/network/local/cache_helper.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  static LoginCubit get(context) => BlocProvider.of(context);
  // UserModel? usermodel;
  void userlogin({
    String email,
    String password,
  }) async {
    emit(LoginLoudingState());

    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      CacheHelper.savedata(key: 'uid', value: value.user.uid);
      uid = value.user.uid;
      emit(LoginSucessState(value.user.uid));
    }).catchError((error) {
      emit(LoginErorrState(
          message:
              error.toString().substring(error.toString().indexOf(']') + 1)));
      print(error.toString().substring(error.toString().indexOf(']') + 1));
    });
  }
}
