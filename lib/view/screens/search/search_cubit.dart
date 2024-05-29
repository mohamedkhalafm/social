
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:social/model/post_model.dart';
import 'package:social/model/user_model.dart';
import 'package:social/view/screens/create_new_post/creat_new_post_states.dart';
import 'package:social/view/screens/search/search_states.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());
  static SearchCubit get(context) => BlocProvider.of(context);
List<UserModel> searchList = [];
  Map<String, dynamic>? search;

  void searchUser(String? searchText) {
    emit(SearchLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .where('name', isEqualTo: searchText)
        .get()
        .then((value) {
      search = value.docs[0].data();
      emit(SearchSuccessState());
      print(search![0].name);
      print('success');
    }).catchError((error) {
      print(error.toString());
      emit(SearchErrorState());
    });
  }
  
  
}




