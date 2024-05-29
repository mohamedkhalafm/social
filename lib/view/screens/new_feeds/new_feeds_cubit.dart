import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:social/model/comment_model.dart';
import 'package:social/model/post_model.dart';
import 'package:social/model/user_model.dart';
import 'package:social/view/screens/create_new_post/creat_new_post_states.dart';
import 'package:social/view/screens/profile_screen/profile_cubit.dart';

import '../../../shared/components/components.dart';
import 'new_feeds_states.dart';

class NewFeedsCubit extends Cubit<NewFeedsStates> {
  NewFeedsCubit() : super(GetPostInitialState());
  static NewFeedsCubit get(context) => BlocProvider.of(context);

  List<PostModel> posts = [];
  List<String> postID = [];

  List<int> commentsNumber = [];
  //List<String> comments = [];

  void getPost() {
    emit(GetPostsLoadingState());
    commentsNumber = [];
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          emit(GetPostsSuccessState());
          likes.add(value.docs.length);
          print(likes);
          commentsNumber.add(value.docs.length);
          postID.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
        }).catchError((error) {});
      });
      emit(GetPostsSuccessState());
    }).catchError((error) {
      emit(GetPostsErrorState());
    });
  }

  void deletePost({required String postId}) {
    emit(DeletePostLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .delete()
        .then((value) {
      showToast(text: 'The post has been deleted', state: ToastStates.SUCCESS);
      emit(DeletePostSuccessState());
    }).catchError((error) {
      emit(DeletePostErrorState());
    });
  }

  List<int> likes = [];
  bool liked = false;

  void likePost(String postId, uId, ) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(uId
            //userModel!.uId
            )
        .set({'like': liked}).then((value) {
          emit(LikePostSuccessState());
          liked =! liked;
      emit(LikePostSuccessState());
    }).catchError((error) {
      emit(LikePostErrorState());
    });
  }

  void createComment({
    String? text,
    String? postID,
    String? image,
  }) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postID)
        .collection('comments')
        .doc()
        .set({
      'postId': postID, 'text': text, 'image': image
      //userModel!.image
    }).then((value) {
      emit(CreateCommentSuccessState());
    }).catchError((error) {
      emit(CreateCommentErrorState());
    });
  }

  List<CommentModel> comments = [];
  CommentModel? commentModel;

  void getcomment({required String postId}) {
    //emit(SocialGetComentsLoadingState());
    comments = [];
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        //emit(SocialGetComentsSuccessState());
        commentModel = CommentModel.fromJson(element.data());
        comments.add(commentModel!);
      });
      emit(GetComentsSuccessState());
    }).catchError((error) {
      emit(GetComentsErrorState());
    });
  }

  List<UserModel> users = [];
  late UserModel? userModel;

  void getAllUsers() {
    FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach((element) {
        if (element.data()['uId'] != uId)
          users.add(UserModel.fromJson(element.data()));
        emit(GetAllUsersSuccessState());
      });
    }).catchError((error) {
      print(error.toString());
      emit(GetAllUsersErrorState());
    });
  }
}
