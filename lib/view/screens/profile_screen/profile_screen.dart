import 'package:conditional_builder/conditional_builder.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/shared/components/components.dart';
import 'package:social/view/screens/profile_screen/profile_cubit.dart';
import 'package:social/view/screens/profile_screen/profile_states.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var user = ProfileCubit.get(context).userModel;
        return
            // ConditionalBuilder(condition: state is ProfileGetUserSuccessState, builder: (context)=>
            SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 200.0,
                      child: Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: [
                            Align(
                              alignment: AlignmentDirectional.topCenter,
                              child: Container(
                                height: 140.0,
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0)),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            user!.cover.toString()),
                                        fit: BoxFit.cover)),
                              ),
                            ),
                            Container(
                              alignment: Alignment.bottomLeft,
                              child: CircleAvatar(
                                radius: 64.0,
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                child: CircleAvatar(
                                  radius: 60,
                                  backgroundImage:
                                      NetworkImage(user.image.toString()),
                                ),
                              ),
                            ),
                          ]),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        children: [
                          Text(
                            user.name.toString(),
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          Text(
                            user.bio.toString(),
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                                onPressed: () {
                                  //ProfileCubit.get(context).getpostImage();
                                },
                                child: const Text(
                                  'Add Photo',
                                )),
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          OutlinedButton(
                              onPressed: () {
                                 navigateTo(context, EditProfileScreen());
                              },
                              child: const Icon(
                                Icons.edit,
                                size: 16.0,
                              )),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                FirebaseMessaging.instance
                                    .subscribeToTopic('announcement');
                              },
                              child: const Text(
                                'Subscribe',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 15.0,
                          ),
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                FirebaseMessaging.instance
                                    .unsubscribeFromTopic('announcement');
                              },
                              child: const Text(
                                'Unsubscribe',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ])),
        );
        //);
      },
    );
  }
}

class EditProfileScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = ProfileCubit.get(context).userModel;
        var profileImage = ProfileCubit.get(context).profileImage;
        var coverImage = ProfileCubit.get(context).coverImage;

        nameController.text = userModel!.name!;
        phoneController.text = userModel.phone!;
        bioController.text = userModel.bio!;

        return Scaffold(
          appBar: AppBar(
            actions: [Text('Edit Profile')],
            leading: IconButton(
                onPressed: () {
                  ProfileCubit.get(context).updateUser(
                      name: nameController.text,
                      phone: phoneController.text,
                      bio: bioController.text);
                },
                icon: Icon(Icons.edit)),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if (state is UserUpdateLoadingState)
                    LinearProgressIndicator(),
                  if (state is UserUpdateLoadingState)
                    SizedBox(
                      height: 10.0,
                    ),
                  Container(
                    height: 190.0,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 140.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(
                                      4.0,
                                    ),
                                    topRight: Radius.circular(
                                      4.0,
                                    ),
                                  ),
                                  image: DecorationImage(
                                    image: coverImage == null
                                        ? NetworkImage(
                                            '${userModel.cover}',
                                          )
                                        : FileImage(coverImage)
                                            as ImageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const CircleAvatar(
                                  radius: 20.0,
                                  child: Icon(
                                    Icons.camera,
                                    size: 16.0,
                                  ),
                                ),
                                onPressed: () {
                                  ProfileCubit.get(context).getcoverImage();
                                },
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 64.0,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 60.0,
                                backgroundImage: profileImage == null
                                    ? NetworkImage(
                                        '${userModel.image}',
                                      )
                                    : FileImage(profileImage) as ImageProvider,
                              ),
                            ),
                            IconButton(
                              icon: const CircleAvatar(
                                radius: 20.0,
                                child: Icon(
                                  Icons.camera,
                                  size: 16.0,
                                ),
                              ),
                              onPressed: () {
                                ProfileCubit.get(context).getprofileImage();
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  if (ProfileCubit.get(context).profileImage != null ||
                      ProfileCubit.get(context).coverImage != null)
                    Row(
                      children: [
                        if (ProfileCubit.get(context).profileImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                TextButton(
                                  onPressed: () {
                                    ProfileCubit.get(context)
                                        .uploadProfileImage(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      bio: bioController.text,
                                    );
                                  },
                                  child: Text('upload profile'),
                                ),
                                if (state is UserUpdateLoadingState)
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                if (state is UserUpdateLoadingState)
                                  LinearProgressIndicator(),
                              ],
                            ),
                          ),
                        SizedBox(
                          width: 5.0,
                        ),
                        if (ProfileCubit.get(context).coverImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                TextButton(
                                  onPressed: () {
                                    ProfileCubit.get(context).uploadCoverImage(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      bio: bioController.text,
                                    );
                                  },
                                  child: Text('upload cover'),
                                ),
                                if (state is UserUpdateLoadingState)
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                if (state is UserUpdateLoadingState)
                                  LinearProgressIndicator(),
                              ],
                            ),
                          ),
                      ],
                    ),
                  if (ProfileCubit.get(context).profileImage != null ||
                      ProfileCubit.get(context).coverImage != null)
                    SizedBox(
                      height: 20.0,
                    ),
                  TextField(
                    controller: nameController,
                  ),
                  TextField(
                    controller: nameController,
                  ),
                  TextField(
                    controller: nameController,
                  ),
                  // defaultFormField(
                  //   controller: nameController,
                  //   type: TextInputType.name,
                  //   validate: (String value) {
                  //     if (value.isEmpty) {
                  //       return 'name must not be empty';
                  //     }

                  //     return null;
                  //   },
                  //   label: 'Name',
                  //   prefix: IconBroken.User,
                  // ),
                  SizedBox(
                    height: 10.0,
                  ),
                  // defaultFormField(
                  //   controller: bioController,
                  //   type: TextInputType.text,
                  //   validate: (String value) {
                  //     if (value.isEmpty) {
                  //       return 'bio must not be empty';
                  //     }

                  //     return null;
                  //   },
                  //   label: 'Bio',
                  //   prefix: IconBroken.Info_Circle,
                  // ),
                  // SizedBox(
                  //   height: 10.0,
                  // ),
                  // defaultFormField(
                  //   controller: phoneController,
                  //   type: TextInputType.phone,
                  //   validate: (String value) {
                  //     if (value.isEmpty) {
                  //       return 'phone number must not be empty';
                  //     }

                  //     return null;
                  //   },
                  //   label: 'Phone',
                  //   prefix: IconBroken.Call,
                  // ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
