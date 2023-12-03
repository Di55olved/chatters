import 'dart:convert';
import 'package:chatters/Models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;

class UserApiClient {
  final http.Client httpClient;

  static var auth = FirebaseAuth.instance;

  // for accessing cloud firestore database
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  
  static FirebaseStorage storage = FirebaseStorage.instance;

  static late Cuser me;
  //getter method
  static get user => auth.currentUser!;
  UserApiClient({required this.httpClient});

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers() {
    return firestore.collection("users").snapshots();
  }

  Future<List<Cuser>> fetchUserMoc() async {
    return [Cuser(id: 'id', about: 'about', createdAt: 'createdAt', isOnline: false, lastActive: 'lastActive', email: 'email', pushToken: 'pushToken', name: 'name', image: 'image')];
  }
}

class Endpoints {
  static const baseUrl = 'https://jsonplaceholder.typicode.com';
  static const String userUrl = '$baseUrl/todos';
  static const productUrl = 'https://dummyjson.com/products';
}

