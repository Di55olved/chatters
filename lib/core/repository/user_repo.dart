import 'package:chatters/Models/user.dart';
import 'package:chatters/core/network.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepository {
  final UserApiClient userApiClient;

  UserRepository({required this.userApiClient});

  Future<Stream<QuerySnapshot<Map<String, dynamic>>> Function()> getuser() async {
    return userApiClient.getAllUsers;
  }
  // Future<Stream<QuerySnapshot<Map<String, dynamic>>> Function()> getUserMoc() async {
  //   return userApiClient.fetchUserMoc();
  // }

}