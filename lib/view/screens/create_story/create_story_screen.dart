import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social/view/screens/create_story/creat_story_cubit.dart';
import 'package:social/view/screens/create_story/creat_story_states.dart';
import 'package:social/view/screens/profile_screen/profile_cubit.dart';
import 'package:social/view/screens/profile_screen/profile_states.dart';

class CreateStory extends StatelessWidget {
  CreateStory({
    Key? key,
  }) : super(key: key);
  TextEditingController story = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var model = CreateStoryCubit.get(context);
        var user = ProfileCubit.get(context).userModel;
        return BlocConsumer<CreateStoryCubit, CreateStoryStates>(
            listener: (context, state) {
          if (state is CreateStorySuccessState) {
            Navigator.pop(context);
            model.getPersonalStory2();
            Fluttertoast.showToast(
                msg: "Your story is created successfully",
                fontSize: 16,
                gravity: ToastGravity.BOTTOM,
                textColor: Theme.of(context).scaffoldBackgroundColor,
                backgroundColor: Colors.black,
                toastLength: Toast.LENGTH_LONG);
          }
        }, builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.black,
            resizeToAvoidBottomInset: false,
            body: SafeArea(
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: FileImage(model.storyImage!),
                            fit: BoxFit.contain)),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(
                                user!.image.toString(),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Text(
                                    user.name.toString(),
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
                            ),
                            IconButton(
                                onPressed: () {
                                  model.closeStory();
                                  Navigator.pop(context);
                                  model.addText = false;
                                },
                                icon: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.withOpacity(0.3),
                                            blurRadius: 9,
                                            spreadRadius: 4,
                                            offset: Offset(0, 4))
                                      ]),
                                  child: CircleAvatar(
                                      backgroundColor: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      child: const Icon(
                                        Icons.close_rounded,
                                        color: Colors.black,
                                      )),
                                ))
                          ],
                        ),
                      ),
                      if (model.addText == true)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 70.0),
                          child: Center(
                            child: TextFormField(
                              controller: story,
                              maxLines: 6,
                              style: const TextStyle(
                                  height: 1.5,
                                  color: Colors.white,
                                  fontSize: 30),
                              decoration: const InputDecoration(
                                  hintText: "What's on your mind ...",
                                  hintStyle: TextStyle(
                                    color: Colors.white,
                                  ),
                                  border: InputBorder.none),
                            ),
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  model.AddText();
                                  story.text = '';
                                },
                                child: Container(
                                  height: 45,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.withOpacity(0.3),
                                            blurRadius: 9,
                                            spreadRadius: 4,
                                            offset: const Offset(0, 4))
                                      ]),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.text_fields,
                                        color: Colors.black,
                                      ),
                                      Text(
                                        !model.addText
                                            ? " add text"
                                            : " remove text",
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  var date = DateTime.now();
                                  model.createStoryImage(
                                      uId: ProfileCubit.get(context)
                                          .userModel!
                                          .uId
                                          .toString(),
                                      image: ProfileCubit.get(context)
                                          .userModel!
                                          .image
                                          .toString(),
                                      name: ProfileCubit.get(context)
                                          .userModel!
                                          .name
                                          .toString(),
                                      date: date,
                                      text: story.text);
                                  if (state is! CreateStoryLoadingState) {
                                    Navigator.pop(context);
                                    // Future.delayed(Duration.zero, () {
                                    //   Navigator.pop(context);
                                    //});
                                  }
                                },
                                child: Container(
                                  height: 45,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.withOpacity(0.3),
                                            blurRadius: 9,
                                            spreadRadius: 4,
                                            offset: const Offset(0, 4))
                                      ]),
                                  child: ConditionalBuilder(
                                    condition:
                                        state is! CreateStoryLoadingState,
                                    builder: (context) => Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Icon(
                                          Icons.share_outlined,
                                          color: Colors.black,
                                        ),
                                        Text(
                                          " share now",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18),
                                        )
                                      ],
                                    ),
                                    fallback: (context) => const Center(
                                        child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.black,
                                    )),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
      },
    );
  }
}
