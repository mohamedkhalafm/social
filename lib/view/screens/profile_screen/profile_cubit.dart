
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social/model/user_model.dart';
import 'package:social/shared/components/components.dart';
import 'package:social/view/screens/profile_screen/profile_states.dart';
import 'package:social/view/screens/register/register_cubit.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit() : super(ProfileInitialState());
  static ProfileCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;

  // ignore: non_constant_identifier_names
  void getUserData() {
    emit(ProfileGetUserLoadingState());

    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      userModel = UserModel.fromJson(value.data()!);
      print(value.data());
      emit(ProfileGetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ProfileGetUserErrorState(error.toString()));
    });
  }
  File? profileImage;
  final picker = ImagePicker();

  Future getprofileImage() async {
    // ignore: non_constant_identifier_names
    final PickedFile = await picker.getImage(source: ImageSource.gallery);
    if (PickedFile != null) {
     // profileimage = File(PickedFile.path);
      emit(ProfileImagePickedSucces());
    } else {
      print('No image selected');
      emit(ProfileImagePickederror());
    }
  }

  File? coverImage;

  Future getcoverImage() async {
    // ignore: non_constant_identifier_names
    final PickedFile = await picker.getImage(source: ImageSource.gallery);
    if (PickedFile != null) {
      //coverImage = File(PickedFile.path  );
      emit(CoverImagePickedSuccess());
    } else {
      print('No image selected');
      emit(CoverImagePickederror());
    }
  }
   

  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(UserUpdateLoadingState());

    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(UserUpdateSuccessState());
        print(value);
        updateUser(
          name: name,
          phone: phone,
          bio: bio,
          image: value,
        );
      }).catchError((error) {
        emit(UserUpdateErrorState());
      });
    }).catchError((error) {
      emit(UserUpdateErrorState());
    });
  }

  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(UserUpdateLoadingState());

    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(UserUpdateSuccessState());
        print(value);
        updateUser(
          name: name,
          phone: phone,
          bio: bio,
          cover: value,
        );
      }).catchError((error) {
        emit(UserUpdateErrorState());
      });
    }).catchError((error) {
      emit(UserUpdateErrorState());
    });
  }


  void updateUser({
    required String name,
    required String phone,
    required String bio,
    String? cover,
    String? image,
  }) {
    UserModel model = UserModel(
      name: name,
      phone: phone,
      bio: bio,
      email: userModel!.email,
      cover: cover ?? userModel!.cover,
      image: image ?? userModel!.image,
      uId: userModel!.uId,
      isEmailVerified: false,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(UserUpdateErrorState());
    });
  }
  
  }