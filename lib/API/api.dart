import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chatters/Models/user.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class APIs extends ChangeNotifier {
  //for auntheniciation
  static var auth = FirebaseAuth.instance;

  // for accessing cloud firestore database
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static FirebaseStorage storage = FirebaseStorage.instance;

  static late Cuser me;
  //getter method
  static get user => auth.currentUser!;

  // checking if user already exits
  static Future<bool> chatterExists() async {
    return (await firestore
            .collection("users")
            .doc(auth.currentUser!.uid)
            .get())
        .exists;
  }

  static Future<void> getSelfInfo() async {
    await firestore.collection("users").doc(user.uid).get().then((user) async {
      if (user.exists) {
        me = Cuser.fromJson(user.data()!);
        me = Cuser.fromJson(user.data()!);
        print('My Data:${user.data()}');
      }
    });
  }

  //new chatter
  /*Changes made by Burhan
    Added parameters to createChatter() for ease
    param: {String Name, String imageURL}
  */
  static Future<void> createChatter(String Name, String imageURl) async {
    final time = DateTime.now().toString();

    final chatter_user = Cuser(
        id: user.uid,
        about: "Salam, Habibi I am a Chatter now",
        createdAt: time,
        isOnline: false,
        lastActive: time,
        email: user.email.toString(),
        pushToken: '',
        name: Name,
        image: imageURl);

    return (await firestore
        .collection("users")
        .doc(user.uid)
        .set(chatter_user.toJson()));
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers() {
    return firestore.collection("users").snapshots();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages() {
    return firestore.collection("messages").snapshots();
  }

  static Future<void> updateUserInfo() async {
    await firestore.collection('users').doc(user.uid).update({
      'name': me.name,
      'about': me.about,
    });
  }
}


//firestore.collection("users").where('id',isNotEqualTo: user.uid).snapshots();
