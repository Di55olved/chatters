import 'package:chatters/Models/messages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chatters/Models/user.dart';
import 'package:firebase_storage/firebase_storage.dart';

class APIs {
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
      } else {
        await createChatter().then((value) => getSelfInfo());
      }
    });
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

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers() {
    return firestore.collection("users").snapshots();
  }

  static String getConversationID(String id) => user.uid.hashCode <= id.hashCode
      ? '${user.uid}_$id'
      : '${id}_${user.uid}';
    

  //sending message
  static Future<void> sendMessage(Cuser cuser, String msg) async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    final Messages message = Messages(
        toId: cuser.id,
        msg: msg,
        read: '',
        type: Type.text,
        fromId: user.uid,
        sent: time);

    final ref =
        firestore.collection('chats/${getConversationID(cuser.id)}/messages/');

    await ref.doc().set(message.toJson());
  }

//get all msg for a specific conversation from firestore
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages(
      Cuser user) {
    return firestore
        .collection('chats/${getConversationID(user.id)}/messages/')
        .snapshots();
  }

  static Future<void> updateUserInfo() async {
    await firestore.collection('users').doc(user.uid).update({
      'name': me.name,
      'about': me.about,
    });
  }
}


//firestore.collection("users").where('id',isNotEqualTo: user.uid).snapshots();
