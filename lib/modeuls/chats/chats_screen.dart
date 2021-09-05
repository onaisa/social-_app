import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/usermodel.dart';
import 'package:social_app/modeuls/chat_detail/chat_detiels.dart';
import 'package:social_app/modeuls/layout/cubit/socialapp_cubit.dart';
import 'package:social_app/share/copmonents/component.dart';

class ChatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialappCubit, SocialappState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (SocialappCubit.get(context).usres.length > 0) {
          return ListView.separated(
              itemBuilder: (context, index) => buildUsersItem(
                  SocialappCubit.get(context).usres[index], context),
              separatorBuilder: (context, index) => Divider(),
              itemCount: SocialappCubit.get(context).usres.length);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

Widget buildUsersItem(UserModel model, context) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: InkWell(
        onTap: () {
          gotonavigat(context, ChatDeteils(model));
          // SocialappCubit.get(context).getMessages(reciverId: model.uid);
        },
        child: Container(
          child: Row(
            children: [
              CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage(
                  model.image,
                ),
              ),
              SizedBox(
                width: 15.0,
              ),
              Expanded(
                child: Text(
                  model.name,
                  style: TextStyle(
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
