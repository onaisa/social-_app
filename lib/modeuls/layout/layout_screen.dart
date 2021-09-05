import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modeuls/layout/cubit/socialapp_cubit.dart';
import 'package:social_app/modeuls/log_in/login%20_screen.dart';
import 'package:social_app/share/copmonents/component.dart';
import 'package:social_app/share/copmonents/constance.dart';
import 'package:social_app/share/network/local/cache_helper.dart';
import 'package:social_app/share/styles/icon_broken.dart';

class LayOut_Screen extends StatelessWidget {
  const LayOut_Screen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialappCubit, SocialappState>(
      listener: (context, state) {},
      builder: (context, state) {
        SocialappCubit cubit = SocialappCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              cubit.titles[cubit.currentindex],
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(fontSize: 20.0),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  IconBroken.Notification,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(
                  IconBroken.Search,
                ),
                onPressed: () {},
              ),
            ],
          ),
          body: cubit.screens[cubit.currentindex],
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentindex,
              onTap: (int index) {
                cubit.changeBottomNavBarIndex(index, context);
              },
              items: [
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.Home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.Chat), label: 'Chat'),
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.Paper_Upload), label: 'Posts'),
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.Location), label: 'Users'),
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.Setting), label: 'Setting'),
              ]),
        );
      },
    );
  }
}
