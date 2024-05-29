import 'package:flutter/material.dart';
import 'package:social/shared/components/components.dart';
import 'package:social/view/screens/create_new_post/creat_new_post_screen.dart';
import 'package:social/view/screens/new_feeds/new_feeds_screen.dart';
import 'package:social/view/screens/search/search_screen.dart';

import '../chat_screen/chat_screen.dart';
import '../profile_screen/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 5);
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // ignore: deprecated_member_use
        brightness: Brightness.light,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: const <Widget>[
                Text('Social',
                    style:
                        TextStyle(fontSize: 27.0, fontWeight: FontWeight.bold)),
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
              IconButton(
                  onPressed: () {
                    navigateTo(context, SearchScreen());
                  },
                  icon: Icon(Icons.search)),
              const SizedBox(width: 15.0),
              IconButton(
                  onPressed: () {
                    navigateTo(context, const ChatScreen());
                  },
                  icon: const Icon(Icons.chat_rounded, color: Colors.black))
            ]),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        bottom: TabBar(
          indicatorColor: Colors.blueAccent,
          controller: _tabController,
          unselectedLabelColor: Colors.grey,
          labelColor: Colors.blueAccent,
          tabs: const [
            Tab(icon: Icon(Icons.home, size: 30.0)),
            Tab(icon: Icon(Icons.people, size: 30.0)),
            Tab(icon: Icon(Icons.cloud_upload_outlined, size: 30.0)),
            Tab(icon: Icon(Icons.account_circle, size: 30.0)),
            //Tab(icon: Icon(Icons.notifications, size: 30.0)),
            Tab(icon: Icon(Icons.menu, size: 30.0))
          ],
        ),
      ),

      // ali@gmail.com
      body: TabBarView(controller: _tabController, children: [
        // HomeTab(),
        // FriendsTab(),
        // WatchTab(),
        //ProfileTab(),
        FeedsScreen(),
         ProfileScreen(),
        CreateNewPost(),
         ProfileScreen(),
         ProfileScreen(),
        // MenuTab()
      ]),
    );
  }
}

// 51:59:0A:E0:9B:FD:78:2F:6A:EA:AD:B3:D3:35:3A:43:99:39:8D:78:12:85:2E:41:42:F5:86:1F:C2:10:C9:53


// > Configure project :firebase_auth
// WARNING: The option setting 'android.enableR8=true' is deprecated.
// It will be removed in version 5.0 of the Android Gradle plugin.
// You will no longer be able to disable R8

// > Task :app:signingReport
// Variant: debug
// Config: debug
// Store: C:\Users\Hamada Salim G-Trd\.android\debug.keystore
// Alias: AndroidDebugKey
// MD5: E6:95:26:83:15:0E:64:17:ED:52:DF:D0:6E:3D:16:D2
// SHA1: F4:1E:9A:BC:EF:D5:D3:C1:8A:DF:E0:7C:B6:25:70:74:8A:A6:A5:51
// SHA-256: 51:59:0A:E0:9B:FD:78:2F:6A:EA:AD:B3:D3:35:3A:43:99:39:8D:78:12:85:2E:41:42:F5:86:1F:C2:10:C9:53
// Valid until: Saturday, February 3, 2052