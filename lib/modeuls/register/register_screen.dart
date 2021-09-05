import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/usermodel.dart';
import 'package:social_app/modeuls/layout/layout_screen.dart';
import 'package:social_app/modeuls/log_in/login%20_screen.dart';
import 'package:social_app/modeuls/register/cubit/register_cubit.dart';
import 'package:social_app/share/copmonents/component.dart';
import 'package:social_app/share/copmonents/constance.dart';
import 'package:social_app/share/network/local/cache_helper.dart';

class RegesterScreen extends StatefulWidget {
  RegesterScreen({Key key}) : super(key: key);

  @override
  _RegesterScreenState createState() => _RegesterScreenState();
}

class _RegesterScreenState extends State<RegesterScreen> {
  TextEditingController usernamecontroller = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController phonController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  bool isscure = false;

  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSucessState) {
            MyToast(msg: 'sucsess register', state: toaststate.sucsses);
            if (state.uid != null) {
              gotonavigat(context, LayOut_Screen());
            }
          } else if (state is RegisterErorrState) {
            MyToast(msg: state.message, state: toaststate.error);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'REGESTER',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Text(
                      'regester now to comunication with frindes',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[600],
                      ),
                    ),
                    Form(
                        key: formkey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            DefoaltTextFormFiled(
                                texttype: TextInputType.name,
                                preicon: Icon(Icons.person),
                                label: 'user name',
                                validate: 'plase enter user name',
                                controller: usernamecontroller),
                            SizedBox(
                              height: 15.0,
                            ),
                            DefoaltTextFormFiled(
                              texttype: TextInputType.visiblePassword,
                              preicon: Icon(Icons.lock),
                              label: 'password',
                              validate: 'plase enter password',
                              controller: passwordController,
                              suficon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isscure = !isscure;
                                    });
                                  },
                                  icon: isscure
                                      ? Icon(Icons.visibility_off)
                                      : Icon(Icons.visibility)),
                              ispassword: isscure,
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            DefoaltTextFormFiled(
                                texttype: TextInputType.emailAddress,
                                preicon: Icon(Icons.email),
                                label: 'email',
                                validate: 'plase enter email',
                                controller: emailController),
                            SizedBox(
                              height: 15.0,
                            ),
                            DefoaltTextFormFiled(
                                texttype: TextInputType.number,
                                preicon: Icon(Icons.phone),
                                label: 'phone',
                                validate: 'plase enter phone',
                                controller: phonController),
                            SizedBox(
                              height: 15.0,
                            ),
                            Container(
                              height: 40.0,
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (formkey.currentState.validate()) {
                                    RegisterCubit.get(context).userRegister(
                                        name: usernamecontroller.text,
                                        phone: phonController.text,
                                        email: emailController.text,
                                        password: passwordController.text);
                                  }
                                },
                                child: Text(
                                  'REGSTER',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Row(
                              children: [
                                Text("you have an account?",
                                    style:
                                        Theme.of(context).textTheme.bodyText2),
                                SizedBox(
                                  width: 3.0,
                                ),
                                TextButton(
                                  onPressed: () {
                                    gotonavigat(context, Login_Screen());
                                  },
                                  child: Text(
                                    'login',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            if (state is RegisterLoudingState)
                              Center(child: CircularProgressIndicator())
                          ],
                        ))
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
