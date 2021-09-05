import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/share/styles/icon_broken.dart';

void gotonavigat(context, Widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => Widget));
}

void NavigateAndFinish(context, Widget) {
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => Widget), (route) => false);
}

Widget DefoaltTextFormFiled({
  Widget suficon,
  bool ispassword = false,
  Widget preicon,
  String label,
  String validate,
  TextEditingController controller,
  TextInputType texttype,
}) {
  return Padding(
    padding: const EdgeInsets.all(0.0),
    child: TextFormField(
      keyboardType: texttype,
      obscureText: ispassword,
      controller: controller,
      validator: (String value) {
        if (value.isEmpty)
          return validate;
        else
          return null;
      },
      decoration: InputDecoration(
        suffixIcon: suficon,
        prefixIcon: preicon,
        labelText: label,
        border: OutlineInputBorder(),
      ),
    ),
  );
}

Widget defaoltbuttom({
  Widget text,
  Function function,
}) {
  return ElevatedButton(
      onPressed: () {
        function;
      },
      child: text);
}

void MyToast({
  String msg,
  toaststate state,
}) {
  Fluttertoast.showToast(
      msg: msg,
      backgroundColor: selecttoastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
      toastLength: Toast.LENGTH_LONG,
      timeInSecForIosWeb: 5,
      gravity: ToastGravity.BOTTOM);
}

enum toaststate { sucsses, error, woring }
Color selecttoastColor(toaststate state) {
  Color color;
  switch (state) {
    case toaststate.error:
      color = Colors.red;
      break;
    case toaststate.woring:
      color = Colors.orange;
      break;
    case toaststate.sucsses:
      color = Colors.green;
      break;
  }
  return color;
}

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 3.0,
  @required Function function,
  @required String text,
}) =>
    Container(
      width: width,
      height: 40.0,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );

Widget defaultTextButton({
  @required Function function,
  @required String text,
}) =>
    TextButton(
      onPressed: function,
      child: Text(
        text.toUpperCase(),
      ),
    );

Widget defaultFormField({
  @required TextEditingController controller,
  @required TextInputType type,
  Function onSubmit,
  Function onChange,
  Function onTap,
  bool isPassword = false,
  @required Function validate,
  @required String label,
  @required IconData prefix,
  IconData suffix,
  Function suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: OutlineInputBorder(),
      ),
    );

Widget defaultAppBar({
  @required BuildContext context,
  String title,
  List<Widget> actions,
}) =>
    AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          IconBroken.Arrow___Left_2,
        ),
      ),
      titleSpacing: 5.0,
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyText1,
      ),
      actions: actions,
    );
