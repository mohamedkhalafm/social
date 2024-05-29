import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/view/screens/search/search_cubit.dart';
import 'package:social/view/screens/search/search_states.dart';

import '../../../model/user_model.dart';
import '../../../shared/components/components.dart';
import '../messages_screen/messages_screen.dart';

class SearchScreen extends StatelessWidget {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit()..searchUser,
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: 60,
              title: Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width - 20,
                  child: TextFormField(
                    controller: searchController,
                    style: TextStyle(color: Colors.black),
                    autofocus: true,
                    textCapitalization: TextCapitalization.words,
                    onFieldSubmitted: (value) {
                      SearchCubit.get(context).searchUser(value);
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                      filled: true,
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.blueAccent)),
                      hintText: '',
                      hintStyle: TextStyle(fontSize: 15,color: Colors.grey),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [SearchList(context),],
              ),
            ),
            // Conditional.single(
            //   context: context,
            //   conditionBuilder:(context) => SearchCubit.get(context).search != null,
            //     widgetBuilder:(context) => chatBuildItem(context, SearchCubit.get(context).search),
            //   fallbackBuilder: (context) => Container(
            //     width: double.infinity,
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       children: [
            //         Icon(Icons.search_off_outlined,size: 60,color: Colors.grey,),
            //         SizedBox(height: 30,),
            //         Text('LocaleKeys.NoSearchResults.tr(),style: TextStyle(fontSize: 25,color: SocialCubit.get(context).textColor'),)
            //       ],
            //     ),
            //   )
            //),
            // body: ListView.separated(
            //   physics: BouncingScrollPhysics(),
            //   itemBuilder: (context,index) =>chatBuildItem(context,SocialCubit.get(context).search![index]) ,
            //   separatorBuilder:(context,index) => myDivider(),
            //   itemCount: 1
            // )
          );
        },
      ),
    );
  }
  Widget SearchList(context) {
    return Expanded(
      child: ConditionalBuilder(
          fallback: (context) => const Center(
                child: CircularProgressIndicator(),
              ),
          condition: true,
          //SearchCubit.get(context).searchList.isNotEmpty,
          builder: (context) => ListView.separated(
              itemBuilder: (context, index) => SearchItem(
                    context,
                    SearchCubit.get(context).search![index],
                  ),
              separatorBuilder: (context, index) => seperator(),
              itemCount: SearchCubit.get(context).searchList.length)),
    );
  }

  Widget SearchItem(
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
          
            ],
          )),
       
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

  // Widget chatBuildItem(context, Map<String, dynamic>? userModel) {
  //   return InkWell(
  //     onTap: () {
  //       navigateTo(context, FriendsProfileScreen(userModel!['uId']));
  //     },
  //     child: Padding(
  //       padding: const EdgeInsets.all(15),
  //       child: Row(
  //         children: [
  //           CircleAvatar(
  //             backgroundImage: NetworkImage('${userModel!['profilePic']}'),
  //             radius: 27,
  //           ),
  //           SizedBox(
  //             width: 10,
  //           ),
  //           Text(
  //             '${userModel['name']}',
  //             maxLines: 1,
  //             overflow: TextOverflow.ellipsis,
  //             style: TextStyle(
  //               color: SocialCubit.get(context).textColor,
  //               fontSize: 15,
  //               fontWeight: FontWeight.bold,
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }

}