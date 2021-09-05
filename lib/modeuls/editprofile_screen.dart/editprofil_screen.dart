import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modeuls/layout/cubit/socialapp_cubit.dart';
import 'package:social_app/modeuls/log_in/login%20_screen.dart';
import 'package:social_app/share/copmonents/component.dart';
import 'package:social_app/share/copmonents/constance.dart';
import 'package:social_app/share/network/local/cache_helper.dart';
import 'package:social_app/share/styles/icon_broken.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key key}) : super(key: key);
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialappCubit, SocialappState>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialappCubit.get(context).userModel;
        nameController.text = userModel.name;
        phoneController.text = userModel.phone;
        bioController.text = userModel.bio;

        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Edit Profile',
            actions: [
              defaultTextButton(
                  function: () {
                    SocialappCubit.get(context).updateNewData(
                      bio: bioController.text,
                      name: nameController.text,
                      phone: phoneController.text,
                    );
                  },
                  text: ('Update')),
              SizedBox(
                width: 15.0,
              ),
              defaultTextButton(
                  function: () {
                    CacheHelper.removedata(key: 'uid');
                    gotonavigat(context, Login_Screen());
                  },
                  text: ('logout')),
              SizedBox(
                width: 15.0,
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: userModel == null
                  ? CircularProgressIndicator()
                  : Column(
                      children: [
                        if (state is UpdateImageLoadingState)
                          LinearProgressIndicator(),
                        if (state is UpdateUserErrorState) Text('error'),
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          height: 190.0,
                          child: Stack(
                            alignment: AlignmentDirectional.bottomCenter,
                            children: [
                              Align(
                                child: Stack(
                                  alignment: AlignmentDirectional.topEnd,
                                  children: [
                                    Container(
                                      height: 140.0,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(
                                            4.0,
                                          ),
                                          topRight: Radius.circular(
                                            4.0,
                                          ),
                                        ),
                                        image: DecorationImage(
                                          image: SocialappCubit.get(context)
                                                      .coverProfile ==
                                                  null
                                              ? NetworkImage(userModel.cover)
                                              : FileImage(
                                                  SocialappCubit.get(context)
                                                      .coverProfile),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      icon: CircleAvatar(
                                        radius: 20.0,
                                        child: Icon(
                                          IconBroken.Camera,
                                          size: 16.0,
                                        ),
                                      ),
                                      onPressed: () {
                                        SocialappCubit.get(context)
                                            .pickedCover();
                                      },
                                    ),
                                  ],
                                ),
                                alignment: AlignmentDirectional.topCenter,
                              ),
                              Stack(
                                alignment: AlignmentDirectional.bottomEnd,
                                children: [
                                  CircleAvatar(
                                    radius: 64.0,
                                    backgroundColor: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    child: CircleAvatar(
                                        radius: 60.0,
                                        backgroundImage:
                                            SocialappCubit.get(context)
                                                        .imageProfil ==
                                                    null
                                                ? NetworkImage(userModel.image)
                                                : FileImage(
                                                    SocialappCubit.get(context)
                                                        .imageProfil)),
                                  ),
                                  IconButton(
                                    icon: CircleAvatar(
                                      radius: 20.0,
                                      child: Icon(
                                        IconBroken.Camera,
                                        size: 16.0,
                                      ),
                                    ),
                                    onPressed: () {
                                      SocialappCubit.get(context)
                                          .pickedprofile();
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        // Row(
                        //   children: [
                        //     Expanded(
                        //       child: Column(
                        //         children: [
                        //           defaultButton(
                        //             function: () {
                        //               SocialappCubit.get(context).updateImage();
                        //             },
                        //             text: 'upload profile',
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //     SizedBox(
                        //       width: 5.0,
                        //     ),
                        //     Expanded(
                        //       child: Column(
                        //         children: [
                        //           defaultButton(
                        //             function: () {},
                        //             text: 'upload cover',
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // if (state is UpdateImageLoadingState)
                        //   LinearProgressIndicator(),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'name must not be empty';
                            }

                            return null;
                          },
                          label: 'Name',
                          prefix: IconBroken.User,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        defaultFormField(
                          controller: bioController,
                          type: TextInputType.text,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'bio must not be empty';
                            }

                            return null;
                          },
                          label: 'Bio',
                          prefix: IconBroken.Info_Circle,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        defaultFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'phone number must not be empty';
                            }

                            return null;
                          },
                          label: 'Phone',
                          prefix: IconBroken.Call,
                        ),
                      ],
                    ),
            ),
          ),
        );
      },
    );
  }
}
