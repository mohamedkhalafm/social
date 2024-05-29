import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/view/screens/create_story/view_story.dart';

import '../../../model/story_model.dart';
import '../profile_screen/profile_cubit.dart';
import '../profile_screen/profile_states.dart';

Widget StoryItem(context, StoryModel storyModel) {
    return BlocConsumer<ProfileCubit, ProfileStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
        var user = ProfileCubit.get(context).userModel;
        return InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ViewStory(storyModel)));
          },
          child: Container(
            width: 110,
            height: 180,
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(17)),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      image: DecorationImage(
                        image: NetworkImage(storyModel.storyImage),
                        fit: BoxFit.cover,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 23,
                        child: CircleAvatar(
                          radius: 20,
                          backgroundImage: storyModel.uId == user!.uId
                              ? NetworkImage(user.image.toString())
                              : NetworkImage(storyModel.image),
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: 110,
                        height: 25,
                        child: Text(
                          storyModel.uId == user.uId
                              ? user.name.toString()
                              : storyModel.name,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }