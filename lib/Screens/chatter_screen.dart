import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatters/Models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatterScreen extends StatefulWidget {
  final Cuser user; 
  const ChatterScreen({super.key, required this.user});

  @override
  State<ChatterScreen> createState() => _ChatterScreenState();
}

class _ChatterScreenState extends State<ChatterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: _appBar(),
      ),
    );
  }

  Widget _appBar() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const BackButton(),
        Expanded(
          child: ListTile(
            horizontalTitleGap: 5,
          leading: SizedBox(
            width: MediaQuery.of(context).size.width * 0.09, // Adjust as needed
            height: MediaQuery.of(context).size.width * 0.09, // Adjust as needed
            
            child: ClipRRect(
              borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height * 0.03),
              child: CachedNetworkImage(
                width: MediaQuery.sizeOf(context).width*.045,
                height: MediaQuery.sizeOf(context).height*.045,
                imageUrl: widget.user.image,
                errorWidget: (context, url, error) => const CircleAvatar(
                  child: Icon(CupertinoIcons.person),
              ),
              
              ),
            ),
          ),
            title: Text(widget.user.name,  style: TextStyle(fontSize: 14)),
            subtitle: const Text('Last seen, 10:53', style: TextStyle(fontSize: 13, color: Colors.black54),),
          ),
        ),

      ],
    );
  }
  
}

