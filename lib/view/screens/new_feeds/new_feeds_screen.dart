// ignore: import_of_legacy_library_into_null_safe
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/view/screens/create_story/creat_story_cubit.dart';
import 'package:social/view/screens/create_story/creat_story_states.dart';
import 'package:social/view/screens/new_feeds/new_feeds_cubit.dart';
import 'package:social/view/screens/new_feeds/new_feeds_states.dart';
import 'package:social/view/screens/profile_screen/profile_cubit.dart';
import 'package:social/view/screens/profile_screen/profile_states.dart';
import 'package:social/view/screens/widgets/post_item.dart';

import '../widgets/story_item.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateStoryCubit, CreateStoryStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = CreateStoryCubit.get(context);
        return BlocConsumer<ProfileCubit, ProfileStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return BlocConsumer<NewFeedsCubit, NewFeedsStates>(
              listener: (context, state) {},
              builder: (context, state) {
                return ConditionalBuilder(
                  condition: NewFeedsCubit.get(context).posts.isNotEmpty,
                  //&& NewFeedsCubit.get(context).userModel != null,
                  builder: (context) => SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: BlocConsumer<ProfileCubit, ProfileStates>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        var user = ProfileCubit.get(context).userModel;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Card(
                              elevation: 1,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        // bloc.changeIndex(4, context);
                                      },
                                      child: CircleAvatar(
                                        radius: 27,
                                        backgroundImage: NetworkImage(
                                            ProfileCubit.get(context)
                                                .userModel!
                                                .image
                                                .toString()),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Expanded(
                                      child: Container(
                                        width: double.infinity,
                                        height: 45,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(40),
                                            border:
                                                Border.all(color: Colors.grey)),
                                        child: MaterialButton(
                                            onPressed: () {
                                              // Navigator.push(
                                              //     context,
                                              //     MaterialPageRoute(
                                              //         builder: (context) => Post()));
                                            },
                                            child: const Text(
                                              "What's on your mind ?",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            )),
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          //bloc.getPostFeedsImage(context);
                                        },
                                        icon: const Icon(
                                          Icons.photo_library_outlined,
                                          color: Colors.black,
                                        ))
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(13.0),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                physics: const BouncingScrollPhysics(),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        model.getStoryImage(context);
                                      },
                                      child: Container(
                                        width: 110,
                                        height: 180,
                                        margin:
                                            const EdgeInsetsDirectional.only(
                                                start: 8),
                                        decoration: BoxDecoration(
                                            color: Colors.grey.withOpacity(0.3),
                                            borderRadius:
                                                BorderRadius.circular(17)),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 153,
                                              child: Stack(
                                                alignment: AlignmentDirectional
                                                    .bottomCenter,
                                                children: [
                                                  Align(
                                                    alignment:
                                                        AlignmentDirectional
                                                            .topCenter,
                                                    child: Container(
                                                      width: 110,
                                                      height: 135,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .only(
                                                            topRight:
                                                                Radius.circular(
                                                                    17),
                                                            topLeft:
                                                                Radius.circular(
                                                                    17),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    10),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10),
                                                          ),
                                                          image: DecorationImage(
                                                              image: NetworkImage(
                                                                  user!.image
                                                                      .toString()),
                                                              fit: BoxFit
                                                                  .cover)),
                                                    ),
                                                  ),
                                                  CircleAvatar(
                                                    radius: 20,
                                                    backgroundColor: Colors.grey
                                                        .withOpacity(0.3),
                                                    child: const CircleAvatar(
                                                      radius: 18,
                                                      //  backgroundColor: social3,
                                                      child: Icon(
                                                        Icons.add,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            const Spacer(),
                                            Text(
                                              "Create Story",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2,
                                            ),
                                            const Spacer(),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    SizedBox(
                                      height: 180,
                                      child: ListView.separated(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          reverse: true,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) =>
                                              StoryItem(context,
                                                  model.stories[index]),
                                          separatorBuilder: (context, index) =>
                                              const SizedBox(
                                                width: 10,
                                              ),
                                          itemCount: model.stories.length),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            ListView.separated(
                              itemCount:
                                  NewFeedsCubit.get(context).posts.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) => postItem(
                                  context,
                                  NewFeedsCubit.get(context).posts[index],
                                  index),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                height: 8.0,
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  ),
                  fallback: (context) =>
                      const Center(child: CircularProgressIndicator()),
                );
              },
            );
          },
        );
      },
    );
  }
}
