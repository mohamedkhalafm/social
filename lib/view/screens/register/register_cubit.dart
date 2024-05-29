import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/model/user_model.dart';
import 'package:social/view/screens/register/register_states.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  //LoginModel loginModel;
 // UserModel userModel;
  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
   // required String cover,
    //required String bio,
  }) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
         // userModel = 
      // ignore: avoid_print
      print(value.user!.email);
      // ignore: avoid_print
      print(value.user!.uid);
      creteUser(
          uId: value.user!.uid,
          name: name,
          //cover: cover,
          phone: phone,
         // bio:bio,
          email: email);
      emit(RegisterSuccessState(value.user!.uid));
    }).catchError((error) {
      emit(RegisterErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(RegisterChangePasswordVisibilityState());
  }

  void creteUser(
      {required String name,
      required String email,
     // required String cover,
     // required String bio,
      required String phone,
      required String uId}) {
    UserModel model = UserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      bio: 'Software Engineer',
      cover: 'https://image.freepik.com/free-photo/close-up-portrait-smiling-happy-woman-with-ginger-curly-hair-touching-pale-smooth-healthy-skin-with-fingertips-looking-cheerful-laughing-white-wall_176420-34459.jpg',
      image:
          'https://image.freepik.com/free-photo/close-up-portrait-smiling-happy-woman-with-ginger-curly-hair-touching-pale-smooth-healthy-skin-with-fingertips-looking-cheerful-laughing-white-wall_176420-34459.jpg',
      isEmailVerified: false,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(CrateUserSuccessState());
    }).catchError((error) {
      emit(CrateUserErrorState(error.toString()));
    });
  }


  
}
