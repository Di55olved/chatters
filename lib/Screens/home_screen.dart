import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:we_chat_application/API/api.dart';
import 'package:we_chat_application/Screens/profile_screen.dart';
import 'package:we_chat_application/Widgets/chatter_card.dart';
import 'package:we_chat_application/Models/user.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Cuser> list = [];

  @override
  void initState() {
    super.initState();
    APIs.getSelfInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chatters"),
        leading: const Icon(
          CupertinoIcons.home,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
            color: Colors.black,
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
              context, MaterialPageRoute(builder: (_) =>  ProfileScreen(user: APIs.me)));
            },
            icon: const Icon(Icons.more_vert),
            color: Colors.black,
          )
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: FloatingActionButton(
          onPressed: () async {
            await APIs.auth.signOut();
            await GoogleSignIn().signOut();
          },
          child: const Icon(Icons.add_comment_rounded),
        ),
      ),
      body: StreamBuilder(
        stream: APIs.getAllUsers(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.none:
              return const Center(child: CircularProgressIndicator());
            case ConnectionState.active:
            case ConnectionState.done:
              final data = snapshot.data?.docs;
              list = data?.map((e) => Cuser.fromJson(e.data())).toList() ?? [];

              case ConnectionState.done:
                final data = snapshot.data?.docs;
                list = data?.map((e) => Cuser.fromJson(e.data())).toList() ?? [];

                print('Data: $data'); // Check the retrieved data

                if (list.isEmpty) {
                  print('List is empty'); // Log if the list is empty
                  return const Center(
                    child: Text(
                      "Connection Unavailable",
                      style: TextStyle(fontSize: 30),
                    ),
                  );
                } 
          }
                return ListView.builder(
                  itemCount: list.length,
                  padding: EdgeInsets.only(
                      top: MediaQuery.sizeOf(context).height * .01),
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return ChatterCard(user: list[index]);
                  },
                );
        },
      ),
    );
  }
}
