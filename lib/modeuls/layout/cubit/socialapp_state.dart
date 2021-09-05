part of 'socialapp_cubit.dart';

@immutable
abstract class SocialappState {}

class SocialappInitial extends SocialappState {}

class SocialGetUserLoadingState extends SocialappState {}

class SocialGetUserSuccessState extends SocialappState {}

class SocialGetUserErrorState extends SocialappState {
  final String error;

  SocialGetUserErrorState(this.error);
}

class ChangeBottomNavBarIndexState extends SocialappState {}

// picke image state

class PickedImageSucsessState extends SocialappState {}

class PickedImageErroeState extends SocialappState {}

///pick image post
class PickedImagePostSucsessState extends SocialappState {}

class PickedImagePostErroeState extends SocialappState {}

// picke cover state

class PickedCoverSucsessState extends SocialappState {}

class PickedCoverErroeState extends SocialappState {}

// update user

class UpdateUserSucsessState extends SocialappState {}

class UpdateUserErrorState extends SocialappState {}

class UpdateUserLoadingState extends SocialappState {}

//updateimage
class UpdateImageSucsessState extends SocialappState {}

class UpdateImageErrorState extends SocialappState {}

class UpdateImageLoadingState extends SocialappState {}

//creat post
class CreatePostSucsessState extends SocialappState {}

class CreatePostErrorState extends SocialappState {}

class CreatePostLoadingState extends SocialappState {}

//creat post with image
class CreatePostWithImageSucsessState extends SocialappState {}

class CreatePostWithImageErrorState extends SocialappState {}

class CreatePostWithImageLoadingState extends SocialappState {}

//upload imagepost
class UploadImagePostSucsessState extends SocialappState {}

class UploadImagePostErrorState extends SocialappState {}

class UploadImagePostLoadingState extends SocialappState {}

//remove post image
class RemovePostImageState extends SocialappState {}

// get posts
class SocialGetPostsLoadingState extends SocialappState {}

class SocialGetPostsSuccessState extends SocialappState {}

class SocialGetPostsErrorState extends SocialappState {
  final String error;

  SocialGetPostsErrorState(this.error);
}

//  like post
class LikePostsSuccessState extends SocialappState {}

class LikePostsErrorState extends SocialappState {
  final String error;

  LikePostsErrorState(this.error);
}

//getallusers
class SocialGetAllUsersLoadingState extends SocialappState {}

class SocialGetAllUsersSuccessState extends SocialappState {}

class SocialGetAllUsersErrorState extends SocialappState {
  final String error;

  SocialGetAllUsersErrorState(this.error);
}
//send message

class SendMessageErrorgState extends SocialappState {}

class SendMessageSuccessState extends SocialappState {}

//get message
class GetMessageSuccessState extends SocialappState {}
