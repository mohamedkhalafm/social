// ignore: import_of_legacy_library_into_null_safe
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/model/user_model.dart';
import 'package:social/view/screens/messages_screen/messages_states.dart';

import '../../../model/message_model.dart';
import '../../../shared/components/components.dart';
import 'messages_cubit.dart';

// ignore: must_be_immutable
class MessagesScreen extends StatelessWidget {
  UserModel? userModel;

  MessagesScreen({
    Key? key,
    this.userModel,
  }) : super(key: key);

  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        MessagesCubit.get(context).getMessages(receiverId: userModel!.uId!);

        return BlocConsumer<MessagesCubit, MessagesStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20.0,
                      backgroundImage: NetworkImage(
                        userModel!.image.toString(),
                      ),
                    ),
                    const SizedBox(
                      width: 15.0,
                    ),
                    Text(
                      userModel!.name.toString(),
                    ),
                  ],
                ),
              ),
              body: ConditionalBuilder(
                condition: MessagesCubit.get(context).messages.length > 0,
                builder: (context) => Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            var message =
                                MessagesCubit.get(context).messages[index];

                            if (userModel!.uId! == message.senderId) {
                              return buildMyMessage(message);
                            }

                            return buildMessage(message);
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 15.0,
                          ),
                          itemCount: MessagesCubit.get(context).messages.length,
                        ),
                      ),
                      sendMessage(context)
                    ],
                  ),
                ),
                fallback: (context) => Column(
                  children: [
                    const Expanded(
                        child: Center(child: Text('No Messages Yet'))),
                    Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: sendMessage(context)),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget sendMessage(context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(
          15.0,
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15.0,
              ),
              child: TextFormField(
                controller: messageController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'type your message here ...',
                ),
              ),
            ),
          ),
          Container(
            height: 50.0,
            color: Colors.deepPurple,
            child: MaterialButton(
              onPressed: () {
                MessagesCubit.get(context).sendMessage(
                  receiverId: userModel!.uId.toString(),
                  messageDate: DateTime.now().toString(),
                  messageContent: messageController.text,
                );
                messageController.clear();
              },
              minWidth: 1.0,
              child: const Icon(
                Icons.send,
                size: 16.0,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 233, 224, 224),
            borderRadius: BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(
                10.0,
              ),
              topStart: Radius.circular(
                10.0,
              ),
              topEnd: Radius.circular(
                10.0,
              ),
            ),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 5.0,
            horizontal: 10.0,
          ),
          child: Text(
            model.text.toString(),
            style: const TextStyle(color: Colors.black , fontSize: 16),
          ),
        ),
      );

  Widget buildMyMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 191, 168, 231),
            borderRadius: BorderRadiusDirectional.only(
              bottomStart: Radius.circular(
                10.0,
              ),
              topStart: Radius.circular(
                10.0,
              ),
              topEnd: Radius.circular(
                10.0,
              ),
            ),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 5.0,
            horizontal: 10.0,
          ),
          child: Text(
            model.text.toString(),
            style: const TextStyle(color: Colors.black , fontSize: 16),
          ),
        ),
      );
}
