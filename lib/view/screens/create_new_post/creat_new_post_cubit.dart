import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:social/model/post_model.dart';
import 'package:social/model/user_model.dart';
import 'package:social/view/screens/create_new_post/creat_new_post_states.dart';

class CreatePostCubit extends Cubit<CreatePostStates> {
  CreatePostCubit() : super(CreatePostInitialState());
  static CreatePostCubit get(context) => BlocProvider.of(context);

  File? profileimage;
  final picker = ImagePicker();

  // Future getprofileImage() async {
  //   // ignore: non_constant_identifier_names
  //   final PickedFile = await picker.getImage(source: ImageSource.gallery);
  //   if (PickedFile != null) {
  //     profileimage = File(PickedFile.path);
  //     emit(SocialProfileImagePickedSucces());
  //   } else {
  //     print('No image selected');
  //     emit(SocialProfileImagePickederror());
  //   }
  // }

  // File? coverImage;

  // Future getcoverImage() async {
  //   // ignore: non_constant_identifier_names
  //   final PickedFile = await picker.getImage(source: ImageSource.gallery);
  //   if (PickedFile != null) {
  //     coverImage = File(PickedFile.path);
  //     emit(SocialCoverileImagePickedSuccess());
  //   } else {
  //     print('No image selected');
  //     emit(SocialCoverileImagePickederror());
  //   }
  // }

  // void uploadProfile({
  //   required String name,
  //   required String phone,
  //   required String bio,
  // }) {
  //   emit(SocialUserUpdateLoadinState());
  //   firebase_storage.FirebaseStorage.instance
  //       .ref()
  //       .child('users/${Uri.file(profileimage!.path).pathSegments.last}')
  //       .putFile(profileimage!)
  //       .then((value) {
  //     value.ref.getDownloadURL().then((value) {
  //       emit(SocialUploadProfileImageSucces());
  //       print(value);
  //       UpdateUser(name: name, phone: phone, bio: bio, image: value);
  //     }).catchError((error) {
  //       //emit(SocialUploadProfileImageerror());
  //     });
  //   }).catchError((error) {
  //     emit(SocialUploadProfileImageerror());
  //   });
  // }

  // void uploadCover({
  //   required String name,
  //   required String phone,
  //   required String bio,
  // }) {
  //   emit(SocialUserUpdateLoadinState());
  //   firebase_storage.FirebaseStorage.instance
  //       .ref()
  //       .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
  //       .putFile(coverImage!)
  //       .then((value) {
  //     value.ref.getDownloadURL().then((value) {
  //       //emit(SocialUploadCoverImageSucces());
  //       print(value);
  //       UpdateUser(name: name, phone: phone, bio: bio, cover: value);
  //     }).catchError((error) {
  //       emit(SocialUploadCoverImageerror());
  //     });
  //   }).catchError((error) {
  //     emit(SocialUploadCoverImageerror());
  //   });
  // }

  // ignore: non_constant_identifier_names
  // void UpdateUserImages() {
  //   emit(SocialUserUpdateLoadinState());
  //   if(coverImage != null){
  //     uploadCover();
  //   }else if(profileimage != null){
  //     uploadProfile();
  //   }else if(coverImage != null && profileimage != null){}
  //   else {
  //   UpdateUser(
  //     name: 'name' ,
  //     phone: 'phone',
  //     bio: 'bio'
  //   );
  // }}

  // ignore: non_constant_identifier_names
  // void UpdateUser(
  //     {required String name,
  //     required String phone,
  //     required String bio,
  //     String? image,
  //     String? cover}) {
  //   SocialUserModel model = SocialUserModel(
  //       name: name,
  //       email: userModel!.email,
  //       //password: password,
  //       phone: phone,
  //       uId: userModel!.uId,
  //       bio: bio,
  //       image: image ?? userModel!.image,
  //       isEmailVerified: false,
  //       cover: cover ?? userModel!.cover);

  //   FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(userModel!.uId)
  //       .update(model.toMap())
  //       .then((value) {
  //     getUserData();
  //   }).catchError((error) {
  //     emit(SocialUserUpdateErrorState());
  //   });
  // }

  File? postImage;

  Future getpostImage() async {
    // ignore: non_constant_identifier_names, deprecated_member_use
    final PickedFile = await picker.getImage(source: ImageSource.gallery);
    if (PickedFile != null) {
      postImage = File(PickedFile.path);
      emit(PostImagePickedSucces());
    } else {
      // ignore: avoid_print
      print('No image selected');
      emit(PostImagePickedError());
    }
  }

  UserModel? userModel;
 // File? postImage;

  void createPostImage({
    required String name,
    required String uId,
    required String date,
    required String image,
    required String postText,
    //required dynamic postImage
  }) {
    emit(CreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //emit(CreatePostUploadpostImageSucces());
        // ignore: avoid_print
        print(value);
        createPost(
            date: date,
            postText: postText,
            postImage: value,
            name: name,
            uId: uId,
            image: image);
      }).catchError((error) {
        emit(CreatePostSuccessState());
      });
    }).catchError((error) {
      emit(CreatePostErrorState());
    });
  }

  void createPost({
    required String name,
    required String uId,
    required String date,
    required String image,
    required String postText,
    String? postImage,
  }) {
    emit(CreatePostLoadingState());
    PostModel model = PostModel(
        name: name,
        image: image,
        uId: uId,
        date: date,
        postText: postText,
        postImage: postImage ?? '');
    // ignore: avoid_print
    print(model.postText);

    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(CreatePostSuccessState());
    }).catchError((error) {
      emit(CreatePostErrorState());
    });
  }
  void removePostImage() {
    postImage;
    emit(PostRemoveImage());
  }
}

  // void removePostImage() {
  //   postImage;
  //   emit(CreatePostRemoveImage());
  // }