// ignore_for_file: prefer_const_constructors, prefer_final_fields

import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatters/API/api.dart';
import 'package:chatters/Models/messages.dart';
import 'package:chatters/Models/user.dart';
import 'package:chatters/Widgets/message_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatterScreen extends StatefulWidget {
  final Cuser user;
  const ChatterScreen({super.key, required this.user});

  @override
  State<ChatterScreen> createState() => _ChatterScreenState();
}

class _ChatterScreenState extends State<ChatterScreen> {
  //all messages
  //Cuser currentUser = APIs.user.uid;
  List<Messages> _msglist = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: _appBar(),
      ),
      body: Column(
        children: [
          Expanded(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: APIs.getAllMessages(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }

              final data = snapshot.data?.docs;
              if (data != null && data.isNotEmpty) {
                List<Messages> _msglist = data
                    .map((doc) =>
                        Messages.fromJson(doc.data() as Map<String, dynamic>))
                    .toList();

                return ListView.builder(
                  itemCount: _msglist.length,
                  itemBuilder: (context, index) {
                    return MessageCard(messages: _msglist[index]);
                  },
                );
              } else {
                return Center(
                  child: Text(
                    "Say Hi 👋",
                    style: TextStyle(fontSize: 30),
                  ),
                );
              }
            },
          )),
          _chatInput()
        ],
      ),
    );
  }

  Widget _appBar() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back,
            )),
        Expanded(
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            horizontalTitleGap: 5,
            leading: SizedBox(
              width:
                  MediaQuery.of(context).size.width * 0.09, // Adjust as needed
              height:
                  MediaQuery.of(context).size.width * 0.09, // Adjust as needed

              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                    MediaQuery.of(context).size.height * 0.03),
                child: CachedNetworkImage(
                  width: MediaQuery.sizeOf(context).width * .045,
                  height: MediaQuery.sizeOf(context).height * .045,
                  imageUrl: widget.user.image,
                  errorWidget: (context, url, error) => const CircleAvatar(
                    child: Icon(CupertinoIcons.person),
                  ),
                ),
              ),
            ),
            title: Text(widget.user.name, style: TextStyle(fontSize: 14)),
            subtitle: const Text(
              'Last seen, 10:53',
              style: TextStyle(fontSize: 13, color: Colors.black54),
            ),
          ),
        ),
      ],
    );
  }

  Widget _chatInput() {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.sizeOf(context).height * 0.01,
          horizontal: MediaQuery.sizeOf(context).width * 0.025),
      child: Row(
        children: [
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.emoji_emotions,
                          color: Colors.blueAccent, size: 26)),
                  Expanded(
                      child: TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: const InputDecoration(
                        hintText: 'Type Something...',
                        hintStyle: TextStyle(color: Colors.blueAccent),
                        border: InputBorder.none),
                  )),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.image,
                          color: Colors.blueAccent, size: 26)),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.camera_alt_rounded,
                          color: Colors.blueAccent, size: 26)),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.camera_enhance,
                          color: Colors.blueAccent, size: 26)),
                ],
              ),
            ),
          ),
          MaterialButton(
            onPressed: () {},
            minWidth: 0,
            padding:
                const EdgeInsets.only(top: 10, bottom: 10, right: 5, left: 10),
            shape: const CircleBorder(),
            color: Colors.green,
            child: const Icon(Icons.send, color: Colors.white, size: 28),
          )
        ],
      ),
    );
  }
}
