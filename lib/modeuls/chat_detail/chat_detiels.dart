import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/usermodel.dart';
import 'package:social_app/modeuls/layout/cubit/socialapp_cubit.dart';
import 'package:social_app/share/styles/icon_broken.dart';

class ChatDeteils extends StatefulWidget {
  UserModel model;
  ChatDeteils(this.model);

  @override
  _ChatDeteilsState createState() => _ChatDeteilsState();
}

class _ChatDeteilsState extends State<ChatDeteils> {
  TextEditingController textcontroller = TextEditingController();
  @override
  void dispose() {
    SocialappCubit.get(context).messages.isEmpty;

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialappCubit, SocialappState>(
      listener: (context, state) {},
      builder: (context, state) {
        SocialappCubit.get(context).getMessages(reciverId: widget.model.uid);

        return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back),
                color: Colors.black,
              ),
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 20.0,
                    backgroundImage: NetworkImage(
                      widget.model.image,
                    ),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Expanded(
                    child: Text(
                      widget.model.name,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                ],
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  // if (SocialappCubit.get(context).messages.length > 0)
                  Expanded(
                    child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          if (SocialappCubit.get(context)
                                  .messages[index]
                                  .senderId ==
                              widget.model.uid) {
                            return buildMessageItem(SocialappCubit.get(context)
                                .messages[index]
                                .text);
                          } else {
                            return buildMyMessageItem(
                                SocialappCubit.get(context)
                                    .messages[index]
                                    .text);
                          }
                        },
                        separatorBuilder: (context, index) => SizedBox(
                              height: 2.0,
                            ),
                        itemCount: SocialappCubit.get(context).messages.length),
                  ),
                  // Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 3.0),
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: TextField(
                        controller: textcontroller,
                        textAlignVertical: TextAlignVertical.center,
                        scrollPhysics: BouncingScrollPhysics(),
                        keyboardType: TextInputType.multiline,
                        maxLines: 2,
                        minLines: 1,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () {
                                  SocialappCubit.get(context).sendMessag(
                                    text: textcontroller.text,
                                    dateTime: Timestamp.now(),
                                    reciverId: widget.model.uid,
                                  );
                                  textcontroller.clear();
                                },
                                icon: Icon(
                                  IconBroken.Send,
                                  color: Colors.blue,
                                )),
                            border: InputBorder.none,
                            hintText: 'type your message ...')),
                  ),
                ],
              ),
            ));
      },
    );
  }
}

Widget buildMessageItem(String text) => Align(
      alignment: AlignmentDirectional.centerStart,
      child: Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadiusDirectional.only(
              topEnd: Radius.circular(10.0),
              topStart: Radius.circular(10.0),
              bottomEnd: Radius.circular(10.0),
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          child: Text(text),
        ),
      ),
    );

Widget buildMyMessageItem(String text) => Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blue[100],
            borderRadius: BorderRadiusDirectional.only(
              topEnd: Radius.circular(10.0),
              topStart: Radius.circular(10.0),
              bottomStart: Radius.circular(10.0),
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          child: Text(text),
        ),
      ),
    );
