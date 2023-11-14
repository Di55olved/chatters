import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:we_chat_application/Models/user.dart';

class ChatterCard extends StatefulWidget {
  final Cuser user;
  const ChatterCard({super.key, required this.user});

  @override
  State<ChatterCard> createState() => _ChatterCardState();
}

class _ChatterCardState extends State<ChatterCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.sizeOf(context).width * 0.02, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 2,
      color: Colors.lightBlue[100],
      child: InkWell(
        onTap: () {},
        child: ListTile(
          leading: const CircleAvatar(
            child: Icon(CupertinoIcons.person),
          ),
          title:  Text(widget.user.name),
          subtitle:  Text(
            widget.user.about,
            maxLines: 1,
          ),
          trailing: Text(
            "${DateTime.now().hour}:${DateTime.now().minute}",
            style: const TextStyle(color: Colors.black45),
          ),
        ),
      ),
    );
  }
}
