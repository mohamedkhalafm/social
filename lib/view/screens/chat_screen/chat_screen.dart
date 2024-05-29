import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/model/message_model.dart';
import 'package:social/model/user_model.dart';
import 'package:social/shared/components/components.dart';
import 'package:social/view/screens/messages_screen/messages_cubit.dart';
import 'package:social/view/screens/messages_screen/messages_screen.dart';
import 'package:social/view/screens/new_feeds/new_feeds_cubit.dart';
import 'package:social/view/screens/new_feeds/new_feeds_states.dart';
  
class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewFeedsCubit()..getAllUsers(),
      child: BlocConsumer<NewFeedsCubit, NewFeedsStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                iconSize: 30.0,
                color: Colors.white,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: const Text(
                'Chats',
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              elevation: 0.0,
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [usersList(context), chatList(context)],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget usersList(context) {
    return SizedBox(
      height: 120.0,
      child: ListView.builder(
        padding: const EdgeInsets.only(left: 10.0),
        scrollDirection: Axis.horizontal,
        itemCount: NewFeedsCubit.get(context).users.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () => navigateTo(
                context,
                MessagesScreen(
                  userModel: NewFeedsCubit.get(context).users[index],
                )),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  CircleAvatar(
                    radius: 35.0,
                    backgroundImage: NetworkImage(NewFeedsCubit.get(context)
                        .users[index]
                        .image
                        .toString()),
                  ),
                  const SizedBox(height: 6.0),
                  Text(
                    NewFeedsCubit.get(context).users[index].name.toString(),
                    style: const TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget chatList(context) {
    return Expanded(
      child: ConditionalBuilder(
          fallback: (context) => const Center(
                child: CircularProgressIndicator(),
              ),
          condition: NewFeedsCubit.get(context).users.length > 0,
          builder: (context) => ListView.separated(
              itemBuilder: (context, index) => chatItem(
                    context,
                    NewFeedsCubit.get(context).users[index],
                  ),
              separatorBuilder: (context, index) => seperator(),
              itemCount: NewFeedsCubit.get(context).users.length)),
    );
  }

  Widget chatItem(
    context,
    UserModel model,
  ) {
    return InkWell(
      onTap: () {
        navigateTo(
            context,
            MessagesScreen(
              userModel: model,
            ));
      },
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(children: [
          CircleAvatar(
            radius: 28.0,
            backgroundImage: NetworkImage('${model.image}'),
          ),
          const SizedBox(
            width: 15.0,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${model.name}',
                style: const TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              // Text(
              //   MessagesCubit.get(context).messages[2].text.toString(),
              //   style: const TextStyle(
              //     color: Colors.black,
              //     fontSize: 16.0,
              //     fontWeight: FontWeight.w600,
              //   ),
              // ),
            ],
          )),
          // const SizedBox(
          //   width: 20,
          // ),
          // Text(
          //   messageModel.dateTime.toString(),
          //   style: const TextStyle(
          //     color: Colors.blueGrey,
          //     fontSize: 16.0,
          //     fontWeight: FontWeight.w600,
          //   ),
          // ),
        ]),
      ),
    );
  }

  Widget seperator() {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );
  }
}
