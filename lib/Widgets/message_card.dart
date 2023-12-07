import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatters/API/api.dart';
import 'package:chatters/Models/messages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageCard extends StatefulWidget {
  const MessageCard({super.key, required this.messages});

  final Messages messages;

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  @override
  @override
  Widget build(BuildContext context) {
    final fromId = widget.messages.fromId.trim().toLowerCase();
    print('From ID: $fromId');
    return fromId == "test1" ? __blueMsg() : __greenMsg();
  }

  Widget __blueMsg() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //message time
        Padding(
          padding:
              EdgeInsets.only(left: MediaQuery.sizeOf(context).width * .04),
          child: Text(
            widget.messages.sent,
            style: const TextStyle(fontSize: 13, color: Colors.black54),
          ),
        ),
                //message content
        Flexible(
            child: Container(
          padding: EdgeInsets.all(widget.messages.type == Type.image
              ? MediaQuery.sizeOf(context).width * .03
              : MediaQuery.sizeOf(context).width * .04),
          margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.sizeOf(context).width * .04,
              vertical: MediaQuery.sizeOf(context).height * .01),
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 221, 245, 255),
              border: Border.all(color: Colors.lightBlue),
              //making borders curved
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                  bottomRight: Radius.circular(30))),
          child:
              //show text
              Text(
            widget.messages.msg,
            style: const TextStyle(fontSize: 15, color: Colors.black87),
          ),
        )),


      ],
    );
  }

  Widget __greenMsg() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //message content
        Flexible(
            child: Container(
          padding: EdgeInsets.all(widget.messages.type == Type.image
              ? MediaQuery.sizeOf(context).width * .03
              : MediaQuery.sizeOf(context).width * .04),
          margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.sizeOf(context).width * .04,
              vertical: MediaQuery.sizeOf(context).height * .01),
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 218, 255, 176),
              border: Border.all(color: Colors.lightGreen),
              //making borders curved
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                  bottomRight: Radius.circular(30))),
          child:
              //show text
              Text(
            widget.messages.msg,
            style: const TextStyle(fontSize: 15, color: Colors.black87),
          ),
        )),

        //message time
        Padding(
            padding: EdgeInsets.only(right: MediaQuery.sizeOf(context).width * .04),
          child: Row(
            children: [
              Icon(Icons.done_all_rounded, color: Colors.blue,),
              Text(
                widget.messages.sent,
                style: const TextStyle(fontSize: 13, color: Colors.black54),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
