import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/model/message_model.dart';
import 'package:social/shared/components/components.dart';
import 'package:social/view/screens/login/login_states.dart';

import 'messages_states.dart';

class MessagesCubit extends Cubit<MessagesStates> {
  MessagesCubit() : super(MessagesInitialState());

  static MessagesCubit get(context) => BlocProvider.of(context);

  void sendMessage({
    required String receiverId,
    required String messageContent,
    required String messageDate,
  }) {
    MessageModel messageModel = MessageModel(
        senderId: uId,
        receiverId: receiverId,
        text: messageContent,
        dateTime: messageDate);
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SendMessagesSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SendMessagesErrorState());
    });
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(uId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SendMessagesSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SendMessagesErrorState());
    });
  }

  List<MessageModel> messages = [];

  void getMessages({
    required String receiverId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];

      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });

      emit(GetMessagesSuccessState());
    });
  }
}
