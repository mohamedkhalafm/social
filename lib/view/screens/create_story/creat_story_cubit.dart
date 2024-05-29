import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:social/shared/components/components.dart';
import 'package:social/view/screens/create_story/creat_story_states.dart';
import 'package:social/view/screens/profile_screen/profile_cubit.dart';

import '../../../model/story_model.dart';
import 'create_story_screen.dart';

class CreateStoryCubit extends Cubit<CreateStoryStates> {
  CreateStoryCubit() : super(CreateStoryInitialState());
  static CreateStoryCubit get(context) => BlocProvider.of(context);

  File? storyImage;
  var picker = ImagePicker();

  Future getStoryImage(context) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      storyImage = File(pickedFile.path);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => CreateStory()));
      emit(GetStoryImageSuccessState());
    } else {
      print("No image selected");
      emit(GetStoryImageErrorState());
    }
  }

  void createStoryImage({
    required DateTime date,
    String? text,
    required String uId,
    required String image,
    required String name,
  }) {
    emit(CreateStoryLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('stories/${Uri.file(storyImage!.path).pathSegments.last}')
        .putFile(storyImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        uploadStory(
            date: date,
            text: text,
            storyImage: value,
            uId: uId,
            image: image,
            name: name);
        emit(CreateStorySuccessState());
        print(value);
      }).catchError((error) {
        emit(CreateStoryErrorState());
        print(error.toString());
      }).catchError((error) {
        emit(CreateStoryErrorState());
        print(error.toString());
      });
    });
  }

  void uploadStory({
    required DateTime date,
    required String name,
    required String image,
    String? text,
    required String uId,
    required String storyImage,
  }) {
    emit(CreateStoryLoadingState());
    StoryModel storyModel = StoryModel(
      uId: uId,
      date: date,
      name: name,
      text: text ?? "",
      storyImage: storyImage,
      image: image,
    );

    FirebaseFirestore.instance
        .collection('stories')
        .add(storyModel.toMap())
        .then((value) {
      emit(CreateStorySuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(CreateStoryErrorState());
    });
  }

  void removeStoryImage() {
    storyImage = null;
    emit(StoryRemoveImage());
  }

  bool addText = false;
  void AddText() {
    addText = !addText;
    emit(AddTextSuccessState());
  }

  void closeStory() {
    emit(CloseStoryScreenState());
  }

  List<StoryModel> stories = [];
  void getStories() {
    emit(GetStoryImageLoadingState());
    FirebaseFirestore.instance
        .collection('stories')
        .orderBy('date')
        .snapshots()
        .listen((event) {
      stories = [];
      event.docs.forEach((element) {
        stories.add(StoryModel.fromJson(element.data()));
      });
    });
    emit(GetStoryImageSuccessState());
  }

  List<StoryModel> personalStories = [];
  void getPersonalStory2() {
    emit(CreateStoryLoadingState());
    personalStories = [];
    // ignore: avoid_function_literals_in_foreach_calls
    stories.forEach((element) {
      if (element.uId == uId) personalStories.add(element);
    });
    emit(CreateStorySuccessState());
  }
}
