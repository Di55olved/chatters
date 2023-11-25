import 'package:chatters/Screens/chatter_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chatters/Models/user.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ChatterCard extends StatefulWidget {
  final Cuser user;
  const  ChatterCard({super.key, required this.user});

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
        onTap: () {
        Navigator.push(
        context, MaterialPageRoute(builder: (_) =>  ChatterScreen(user: widget.user)));
        },
        child: ListTile(
          leading: SizedBox(
            width: MediaQuery.of(context).size.width * 0.1, // Adjust as needed
            height: MediaQuery.of(context).size.width * 0.1, // Adjust as needed
            
            child: ClipRRect(
              borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height * 0.03),
              child: CachedNetworkImage(
                width: MediaQuery.sizeOf(context).width*.055,
                height: MediaQuery.sizeOf(context).height*.055,
                imageUrl: widget.user.image,
                errorWidget: (context, url, error) => const CircleAvatar(
                  child: Icon(CupertinoIcons.person),
              ),
              
              ),
            ),
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


