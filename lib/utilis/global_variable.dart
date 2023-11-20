
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod/screen/add_post_screen.dart';
import 'package:riverpod/screen/feed_screen.dart';
import 'package:riverpod/screen/notification_screen.dart';
import 'package:riverpod/screen/profile_screen.dart';
import 'package:riverpod/screen/search_screen.dart';

const webscreenSize=900;
final allPages=[
   FeedScreen(),
  // FeedScreen(),
   SearchScreen(),
   AddPostScreen(),
   NotificationScreen(),
     ProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid),
];