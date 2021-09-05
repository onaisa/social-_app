import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modeuls/layout/cubit/socialapp_cubit.dart';
import 'package:social_app/share/styles/icon_broken.dart';

class NewPostScreen extends StatelessWidget {
  NewPostScreen({Key key}) : super(key: key);
  TextEditingController textconroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialappCubit, SocialappState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text(
              'new post',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    if (SocialappCubit.get(context).imagePost == null) {
                      SocialappCubit.get(context).createPostWithOutImage(
                        datetime: Timestamp.now(),
                        text: textconroller.text,
                      );
                    } else {
                      SocialappCubit.get(context).createPostWithImage(
                        datetime: Timestamp.now(),
                        text: textconroller.text,
                      );
                    }
                  },
                  child: Text(
                    'post',
                    style: TextStyle(fontSize: 18.0),
                  ))
            ],
          ),
          body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  if (state is CreatePostLoadingState ||
                      state is CreatePostWithImageLoadingState)
                    LinearProgressIndicator(),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25.0,
                        backgroundImage: NetworkImage(
                          SocialappCubit.get(context).userModel.image,
                        ),
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Expanded(
                        child: Text(
                          SocialappCubit.get(context).userModel.name,
                          style: TextStyle(
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: textconroller,
                      scrollPhysics: BouncingScrollPhysics(),
                      maxLines: 9,
                      decoration: InputDecoration(
                        hintText: 'what is on your mind ...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  if (SocialappCubit.get(context).imagePost != null)
                    Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        Container(
                          height: 140.0,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              4.0,
                            ),
                            image: DecorationImage(
                              image: FileImage(
                                  SocialappCubit.get(context).imagePost),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: CircleAvatar(
                            radius: 20.0,
                            child: Icon(
                              Icons.close,
                              size: 16.0,
                            ),
                          ),
                          onPressed: () {
                            SocialappCubit.get(context).removePostImage();
                          },
                        ),
                      ],
                    ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            SocialappCubit.get(context).pickedImagePost();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                IconBroken.Image,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                'add photo',
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            '# tags',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )),
        );
      },
    );
  }
}
