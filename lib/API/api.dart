import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:we_chat_application/Models/user.dart';

class APIs {
  //for auntheniciation
  static var auth = FirebaseAuth.instance;

  // for accessing cloud firestore database
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

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

  //new chatter
  static Future<void> createChatter() async {
    final time = DateTime.now().toString();

    final chatter_user = Cuser(
        id: user.uid,
        about: "Salam, Habibi I am a Chatter now",
        createdAt: time,
        isOnline: false,
        lastActive: time,
        email: user.email.toString(),
        pushToken: '',
        name: user.displayName.toString(),
        image: user.photoURL.toString());

    return (await firestore
            .collection("users")
            .doc(user.uid)
            .set(chatter_user.toJson()));
  }
}
