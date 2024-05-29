import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/view/screens/create_story/creat_story_cubit.dart';
import 'package:social/view/screens/create_story/creat_story_states.dart';
import 'package:social/view/screens/profile_screen/profile_cubit.dart';
import 'package:social/view/screens/profile_screen/profile_states.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../model/story_model.dart';

// ignore: must_be_immutable
class ViewStory extends StatelessWidget {
  StoryModel? model;
  ViewStory(this.model, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var user = ProfileCubit.get(context);
        return BlocConsumer<CreateStoryCubit, CreateStoryStates>(
            listener: (context, state) {},
            builder: (context, state) {
              var bloc = CreateStoryCubit.get(context);
              return Scaffold(
                backgroundColor: Colors.black,
                body: SafeArea(
                    child: Stack(
                  children: [
                    SizedBox.expand(
                      child: InteractiveViewer(
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(model!.storyImage),
                                  fit: BoxFit.contain)),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.3),
                                              blurRadius: 9,
                                              spreadRadius: 4,
                                              offset: const Offset(0, 4))
                                        ]),
                                    child: CircleAvatar(
                                        backgroundColor: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                        child: const Icon(
                                          Icons.arrow_back_ios_outlined,
                                          color: Colors.black,
                                        )),
                                  )),
                              InkWell(
                                onTap: () {
                                  // if (model!.uId != user.userModel!.uId) {
                                  //   bloc.getFriendData(model!.uId);
                                  //   Navigator.push(
                                  //       context,
                                  //       MaterialPageRoute(
                                  //           builder: (context) =>
                                  //               FriendProfile()));
                                  // } else {
                                  //   bloc.changeIndex(4, context);
                                  Navigator.pop(context);
                                  // }
                                },
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(
                                    model!.image,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          model!.name,
                                          style: const TextStyle(
                                              fontSize: 23,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        const Icon(
                                          Icons.check_circle,
                                          color: Colors.black,
                                          size: 23,
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      timeago.format(model!.date),
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption!
                                          .copyWith(
                                              color: Colors.grey,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Flexible(
                            child: Container(
                          color: Colors.black.withOpacity(0.3),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              if (model!.text != "")
                                Center(
                                    child: Text(
                                  model!.text!,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 25),
                                )),
                              MaterialButton(
                                  onPressed: () {},
                                  child: Column(
                                    children: const[
                                      Icon(
                                        Icons.keyboard_arrow_up,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        "REPLAY",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600),
                                      )
                                    ],
                                  ))
                            ],
                          ),
                        ))
                      ],
                    )
                  ],
                )),
              );
            });
      },
    );
  }
}
