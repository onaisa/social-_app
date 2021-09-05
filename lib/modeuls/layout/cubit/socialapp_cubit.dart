import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:social_app/models/messagemodel.dart';
import 'package:social_app/models/postmodel.dart';
import 'package:social_app/models/usermodel.dart';
import 'package:social_app/modeuls/chats/chats_screen.dart';
import 'package:social_app/modeuls/feeds/feeds_screen.dart';
import 'package:social_app/modeuls/posts/posts_screen.dart';
import 'package:social_app/modeuls/settings/settings_screen.dart';
import 'package:social_app/modeuls/users/users_screen.dart';
import 'package:social_app/share/copmonents/component.dart';
import 'package:social_app/share/copmonents/constance.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

part 'socialapp_state.dart';

class SocialappCubit extends Cubit<SocialappState> {
  SocialappCubit() : super(SocialappInitial());
  static SocialappCubit get(context) => BlocProvider.of(context);
  UserModel userModel;

  void getUser(String uid) {
    emit(SocialGetUserLoadingState());

    FirebaseFirestore.instance.collection('users').doc(uid).get().then((value) {
      userModel = UserModel.fromJson(value.data());
      print(userModel.email);
      print(userModel.phone);
      print(userModel.name);
      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      emit(SocialGetUserErrorState(
          error.toString().substring(error.toString().indexOf(']') + 1)));
      print(error.toString().substring(error.toString().indexOf(']') + 1));
    });
  }

  int currentindex = 0;

  List<Widget> screens = [
    FeedsScreen(),
    ChatsScreen(),
    NewPostScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];

  List<String> titles = ['Home', 'Chats', 'Post', 'Users', 'Settings'];

  void changeBottomNavBarIndex(int index, context) {
    // if ((index == 1) || (index == 3)) getAllUser();
    if (index == 2) {
      gotonavigat(context, NewPostScreen());
    } else {
      currentindex = index;
      emit(ChangeBottomNavBarIndexState());
    }
  }

  File imageProfil;
  var imagePicked = ImagePicker();
  void pickedprofile() async {
    final pickedfile = await imagePicked.pickImage(source: ImageSource.gallery);
    if (pickedfile != null) {
      imageProfil = File(pickedfile.path);
      emit(PickedImageSucsessState());
    } else {
      print('no image picked');
      emit(PickedImageErroeState());
    }
  }

  File coverProfile;
  var coverPicked = ImagePicker();
  void pickedCover() async {
    final pickedfile = await imagePicked.pickImage(source: ImageSource.gallery);
    if (pickedfile != null) {
      coverProfile = File(pickedfile.path);
      emit(PickedCoverSucsessState());
    } else {
      print('no image picked');
      emit(PickedCoverErroeState());
    }
  }

  File imagePost;
  var imagePostPicked = ImagePicker();
  void pickedImagePost() async {
    final pickedfile =
        await imagePostPicked.pickImage(source: ImageSource.gallery);
    if (pickedfile != null) {
      imagePost = File(pickedfile.path);
      emit(PickedImagePostSucsessState());
    } else {
      print('no image picked');
      emit(PickedImagePostErroeState());
    }
  }

//update profile without cover or image
  void updateProfil({
    String name,
    String bio,
    String phone,
    String image,
    String cover,
  }) {
    UserModel model = UserModel(
      bio: bio ?? userModel.bio,
      email: userModel.email,
      name: name ?? userModel.name,
      phone: phone ?? userModel.phone,
      uid: userModel.uid,
      cover: cover ?? userModel.cover,
      image: image ?? userModel.image,
    );
    emit(UpdateUserLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uid)
        .update(model.toMap())
        .then((value) {
      getUser(userModel.uid);
      emit(UpdateUserSucsessState());
    }).catchError((error) {
      emit(UpdateUserErrorState());
      print(error.toString());
    });
  }

//update profile with cover and image
  void updateNewData({
    String name,
    String bio,
    String phone,
  }) {
    emit(UpdateImageLoadingState());
    String newCover;
    if (coverProfile != null)
      firebase_storage.FirebaseStorage.instance
          .ref()
          .child('${Uri.file(coverProfile.path).pathSegments.last}')
          .putFile(coverProfile)
          .then((cover) {
        cover.ref.getDownloadURL().then((value) {
          newCover = value;
        });
      });

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(imageProfil.path).pathSegments.last}')
        .putFile(imageProfil)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        updateProfil(
            image: value ?? userModel.image,
            cover: newCover ?? userModel.cover,
            bio: bio,
            name: name,
            phone: phone);
        print(value.toString());
        print(newCover.toString());
        print(bio.toString());
        print(phone.toString());
        print(name.toString());

        emit(UpdateImageSucsessState());
      }).catchError((error) {
        print(error);
        emit(UpdateImageErrorState());
      });
    }).catchError((error) {
      print(error);
      emit(UpdateImageErrorState());
    });
  }

  // String postImageUrl;
  // void uploadPostImage() {
  //   emit(UploadImagePostLoadingState());
  //   firebase_storage.FirebaseStorage.instance
  //       .ref()
  //       .child('usres/${Uri.file(imagePost.path).pathSegments.last}')
  //       .putFile(imagePost)
  //       .then((value) {
  //     value.ref.getDownloadURL().then((value) {
  //       postImageUrl = value;

  //       emit(UploadImagePostSucsessState());
  //     }).catchError((error) {
  //       print(error);
  //       emit(UploadImagePostErrorState());
  //     });
  //   });
  // }

  void removePostImage() {
    imagePost = null;
    emit(RemovePostImageState());
  }

  void createPostWithImage({String text, Timestamp datetime}) {
    emit(CreatePostWithImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(imagePost.path).pathSegments.last}')
        .putFile(imagePost)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPostWithOutImage(text: text, datetime: datetime, image: value);

        emit(CreatePostWithImageSucsessState());
      }).catchError((error) {
        print(error);
        emit(CreatePostWithImageErrorState());
      });
    });
  }

  void createPostWithOutImage({
    String text,
    Timestamp datetime,
    String image,
  }) {
    emit(CreatePostLoadingState());

    PostModel postModel = PostModel(
        dateTime: datetime,
        image: userModel.image,
        name: userModel.name,
        uId: userModel.uid,
        text: text,
        postImage: image ?? '');
    FirebaseFirestore.instance
        .collection('posts')
        .add(postModel.toMap())
        .then((value) {
      // String postId = value.id;
      // print("postId is ${value.id}");

      emit(CreatePostSucsessState());
    }).catchError((error) {
      print(error.toString());
      emit(CreatePostErrorState());
    });
  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];

  void getPosts() {
    emit(SocialGetPostsLoadingState());

    FirebaseFirestore.instance
        .collection('posts')
        .orderBy('dateTime')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);
          postsId.add(element.id);

          print('postidlengh is ${postsId.length}');
          posts.add(PostModel.fromJson(element.data()));

          print('postslength is ${posts.length}');

          print('likeslength is ${value.docs.length}');
          emit(SocialGetPostsSuccessState());
        }).catchError((error) {
          emit(SocialGetPostsErrorState(
              error.toString().substring(error.toString().indexOf(']') + 1)));
        });
      });
    }).catchError((error) {
      emit(SocialGetPostsErrorState(
          error.toString().substring(error.toString().indexOf(']') + 1)));
    });
  }

  void LikePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel.uid)
        .set({'like': true}).then((value) {
      emit(LikePostsSuccessState());
    }).catchError((error) {
      emit(LikePostsErrorState(error.toString()));
    });
  }

  List<UserModel> usres = [];
  void getAllUser() {
    emit(SocialGetAllUsersLoadingState());
    if (usres.length == 0)
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          // if (element.data()['uid'] != userModel.uid)
          usres.add(UserModel.fromJson(element.data()));
        });

        emit(SocialGetAllUsersSuccessState());
      }).catchError((error) {
        emit(SocialGetAllUsersErrorState(
            error.toString().substring(error.toString().indexOf(']') + 1)));
        print(error.toString().substring(error.toString().indexOf(']') + 1));
      });
  }

  void sendMessag({
    Timestamp dateTime,
    String text,
    String reciverId,
  }) {
    MessegModel model = MessegModel(
      datetaime: dateTime,
      receverId: reciverId,
      senderId: userModel.uid,
      text: text,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uid)
        .collection('chat')
        .doc(reciverId)
        .collection('message')
        .add(model.tojson())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorgState());
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(reciverId)
        .collection('chat')
        .doc(userModel.uid)
        .collection('message')
        .add(model.tojson())
        .then((value) {
      emit(SendMessageSuccessState());
      print('send message $text');
    }).catchError((error) {
      emit(SendMessageErrorgState());
    });
  }

  List<MessegModel> messages = [];
  void getMessages({
    String reciverId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uid)
        .collection('chat')
        .doc(reciverId)
        .collection('message')
        .orderBy('dateataime')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        // print('get message ${element[0].text}');
        messages.add(MessegModel.Fromjson(element.data()));
        // print('get message ${messages[0].text}');
        emit(GetMessageSuccessState());
      });
    });
  }
}
