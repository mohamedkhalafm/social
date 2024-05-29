import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/view/screens/create_new_post/creat_new_post_cubit.dart';
import 'package:social/view/screens/create_new_post/creat_new_post_states.dart';
import 'package:social/view/screens/profile_screen/profile_cubit.dart';
import 'package:social/view/screens/profile_screen/profile_states.dart';

import '../../../model/post_model.dart';

class CreateNewPost extends StatelessWidget {
  var textController = TextEditingController();
  //PostModel? model;
  @override
  Widget build(BuildContext context) {
    var user = ProfileCubit.get(context).userModel;
    return BlocConsumer<CreatePostCubit, CreatePostStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    const Text('New Post'),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        if (CreatePostCubit.get(context).postImage == null) {
                          CreatePostCubit.get(context).createPost(
                              name: ProfileCubit.get(context)
                                  .userModel!
                                  .name
                                  .toString(),
                              uId: ProfileCubit.get(context)
                                  .userModel!
                                  .uId
                                  .toString(),
                              image: ProfileCubit.get(context)
                                  .userModel!
                                  .image
                                  .toString(),
                              date: DateTime.now().toString(),
                              postText: textController.text);
                        } else {
                          CreatePostCubit.get(context).createPostImage(
                              name: ProfileCubit.get(context)
                                  .userModel!
                                  .name
                                  .toString(),
                              uId: ProfileCubit.get(context)
                                  .userModel!
                                  .uId
                                  .toString(),
                              image: ProfileCubit.get(context)
                                  .userModel!
                                  .image
                                  .toString(),
                              date: DateTime.now().toString(),
                              postText: textController.text);
                        }
                      },
                      child: const Text('post'),
                    )
                  ],
                ),
                if (state is CreatePostLoadingState)
                  const LinearProgressIndicator(),
                if (state is CreatePostLoadingState)
                  const SizedBox(
                    height: 50.0,
                  ),
                BlocConsumer<ProfileCubit, ProfileStates>(
                  builder: (context, state) {
                    return Row(
                      children: [
                        CircleAvatar(
                          radius: 25.0,
                          backgroundImage: NetworkImage(
                            user!.image.toString(),
                          ),
                        ),
                        const SizedBox(
                          width: 15.0,
                        ),
                        Expanded(
                          child: Text(
                            user.name.toString(),
                            style: const TextStyle(height: 1.4),
                          ),
                        ),
                      ],
                    );
                  },
                  listener: (context, state) {},
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: textController,
                  decoration: const InputDecoration(
                      hintText: 'Type your post...', border: InputBorder.none),
                ),
                const SizedBox(
                  height: 20,
                ),

                if (CreatePostCubit.get(context).postImage != null)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        height: 140.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            image: DecorationImage(
                                image: FileImage(
                                    CreatePostCubit.get(context).postImage!),
                                fit: BoxFit.cover)),
                      ),
                      IconButton(
                          icon: const CircleAvatar(
                              radius: 20.0, child: Icon(Icons.close)),
                          onPressed: () {
                            CreatePostCubit.get(context).removePostImage();
                          })
                    ],
                  ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: TextButton(
                          onPressed: () {
                            CreatePostCubit.get(context).getpostImage();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.photo_album_rounded),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text('Add Photo'),
                            ],
                          )),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}


// ali@gmail.com