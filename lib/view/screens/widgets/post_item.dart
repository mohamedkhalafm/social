import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../model/comment_model.dart';
import '../../../model/post_model.dart';
import '../new_feeds/new_feeds_cubit.dart';
import '../profile_screen/profile_cubit.dart';
import '../profile_screen/profile_states.dart';

Widget postItem(context, PostModel model, index) => Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 10.0,
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25.0,
                  backgroundImage: NetworkImage('${model.image}'),
                ),
                const SizedBox(
                  width: 15.0,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Text(
                          '${model.name}',
                          style: const TextStyle(
                              height: 1.4,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        const Icon(
                          Icons.check_circle_outline,
                          color: Colors.deepPurple,
                          size: 16.0,
                        ),
                      ]),
                      Text(
                        //'${model.date}',
                        DateFormat.yMMMEd()
                            .format(DateTime.tryParse(model.date.toString())!),
                        style: const TextStyle(height: 1.4, fontSize: 13),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 15.0),
                IconButton(
                    icon: const Icon(
                      Icons.more_horiz,
                      size: 16.0,
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: const Text(
                                  'Delete',
                                  style: TextStyle(color: Colors.red),
                                ),
                                content: const Text(
                                    'Do you want to delete this post ?'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        NewFeedsCubit.get(context).deletePost(
                                            postId: NewFeedsCubit.get(context)
                                                .postID[index]);
                                      },
                                      child: const Text('Yes')),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('No'))
                                ],
                              ));
                    })
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey[300],
              ),
            ),
            Text(
              '${model.postText}',
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 14, height: 1.3),
            ),
            const SizedBox(
              height: 10.0,
            ),
            if (model.postImage != '')
              Container(
                height: 250.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    image: DecorationImage(
                        image: NetworkImage('${model.postImage}'),
                        fit: BoxFit.cover)),
              ),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.favorite_rounded,
                            size: 20.0,
                            color: Colors.red,
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            '${NewFeedsCubit.get(context).likes[index]}',
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      NewFeedsCubit.get(context).getcomment(
                          postId: NewFeedsCubit.get(context).postID[index]);
                      Timer(
                          const Duration(milliseconds: 500),
                          () => showModalBottomSheet(
                              context: context,
                              builder: (context) =>
                                  commentBottomSheet(index, context)));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Icon(
                            Icons.chat_rounded,
                            size: 20.0,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            '${NewFeedsCubit.get(context).commentsNumber[index].abs()} comments',
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey[300],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: BlocConsumer<ProfileCubit, ProfileStates>(
                listener: (context, state) {},
                builder: (context, state) => Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          NewFeedsCubit.get(context).getcomment(
                              postId: NewFeedsCubit.get(context).postID[index]);
                          Timer(
                              const Duration(milliseconds: 500),
                              () => showModalBottomSheet(
                                  context: context,
                                  builder: (context) =>
                                      commentBottomSheet(index, context)));
                        },
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 10.0,
                              backgroundImage: NetworkImage(
                                  '${ProfileCubit.get(context).userModel!.image
                                  //NewFeedsCubit.get(context).userModel!.image
                                  }'),
                            ),
                            const SizedBox(
                              width: 15.0,
                            ),
                            Text(
                              'Write your comment...',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(height: 1.4),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        NewFeedsCubit.get(context).likePost(
                          
                            NewFeedsCubit.get(context).postID[index],
                            ProfileCubit.get(context).userModel!.uId);
                      },
                      child: Row(
                        children: [
                           NewFeedsCubit.get(context).liked ? const Icon(
                            Icons.favorite_rounded,
                            size: 20.0,
                            color: Colors.red,
                          ) :const Icon(
                            Icons.favorite_rounded,
                            size: 20.0,
                            color: Colors.deepPurple,
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            'Like',
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

var textCommentController = TextEditingController();
Widget commentBottomSheet(index, context) => Padding(
      padding: const EdgeInsets.only(right: 10.0, left: 10.0, top: 20.0),
      child: Container(
        height: 700,
        width: double.infinity,
        color: Colors.white,
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: NewFeedsCubit.get(context).comments.isNotEmpty
                  ? ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) => buildCommentBody(
                          NewFeedsCubit.get(context).comments[index]),
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 20.0,
                          ),
                      itemCount: NewFeedsCubit.get(context).comments.length)
                  : const SizedBox(
                      width: 200,
                      child: Center(child: Text('No Comments')),
                    ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: Colors.grey.shade300, width: 1.0),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: TextFormField(
                      controller: textCommentController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'type your comment...',
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                BlocConsumer<ProfileCubit, ProfileStates>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    return CircleAvatar(
                      radius: 20.0,
                      backgroundColor: Colors.blue,
                      child: IconButton(
                        onPressed: () {
                          NewFeedsCubit.get(context).createComment(
                              postID: NewFeedsCubit.get(context).postID[index],
                              text: textCommentController.text,
                              image:
                                  ProfileCubit.get(context).userModel!.image);
                          textCommentController.clear();
                        },
                        icon: const Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                )
              ],
            )
          ],
        ),
      ),
    );

Widget buildCommentBody(CommentModel model) => Row(
      children: [
        CircleAvatar(
          radius: 25.0,
          backgroundColor: Colors.grey[200],
          backgroundImage: NetworkImage(model.image.toString()),
        ),
        const SizedBox(
          width: 10.0,
        ),
        Container(
          width: 260.0,
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(10.0)),
          child: Text(model.text.toString()),
        )
      ],
    );
