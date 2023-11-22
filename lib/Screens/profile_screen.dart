
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:we_chat_application/API/api.dart';
import 'package:we_chat_application/Models/user.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:we_chat_application/Screens/auth/login_screen.dart';

import '../Support/dialogs.dart';
import '../main.dart';


class ProfileScreen extends StatefulWidget {

 final Cuser user;
  const ProfileScreen({super.key, required this.user});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  Widget build(BuildContext context) {
        return Scaffold(
      appBar: AppBar(
        title: const Text("Profile Screen"),
        // leading: const Icon(
        //   CupertinoIcons.home,
        // ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
            color: Colors.black,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
            color: Colors.black,
          )
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: FloatingActionButton.extended(
          onPressed: () async {

            Dialogs.showProgressBar(context);

            await APIs.auth.signOut().then((value) async {
               await GoogleSignIn().signOut().then((value) {
                //first for prof screen
                  Navigator.pop(context);
                //second for home screen
                  Navigator.pop(context);

                  Navigator.pushReplacement(context, 
                  MaterialPageRoute(builder: (_) => const LoginScreen()));
               });
            });
          },
          icon: const Icon(Icons.add_comment_rounded),
          label: Text('Logout'),
        ),
      ),
       
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).height*.05),
        child: ListView(
          children: [
            SizedBox(width: MediaQuery.sizeOf(context).width,height: MediaQuery.sizeOf(context).height*0.03),
           
            ClipRRect(
              borderRadius: BorderRadius.circular(MediaQuery.sizeOf(context).height),
              child: CachedNetworkImage(
                width: MediaQuery.sizeOf(context).height * 0.2,
                height: MediaQuery.sizeOf(context).height * 0.2,
                fit: BoxFit.cover,
                imageUrl: widget.user.image,
                errorWidget: (context, url, error) => CircleAvatar(
                  child: Icon(CupertinoIcons.person),
                ),
              ),
            ),
            SizedBox(width: MediaQuery.sizeOf(context).width,height: MediaQuery.sizeOf(context).height*0.03),


          Text(widget.user.email,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.black54, fontSize: 16)),

            SizedBox(width: MediaQuery.sizeOf(context).width,height: MediaQuery.sizeOf(context).height*0.03),


          TextFormField(
                      initialValue: widget.user.name,
                      decoration: InputDecoration(
                          prefixIcon:
                              const Icon(Icons.person, color: Colors.blue),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                          hintText: 'eg. Happy Singh',
                          label: const Text('Name')),
                    ),
            SizedBox(width: MediaQuery.sizeOf(context).width,height: MediaQuery.sizeOf(context).height*0.03),

          TextFormField(
                      initialValue: widget.user.about,
                      decoration: InputDecoration(
                          prefixIcon:
                              const Icon(Icons.person, color: Colors.blue),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                          hintText: 'eg.Academic',
                          label: const Text('About')),
                    ),
            SizedBox(width: MediaQuery.sizeOf(context).width,height: MediaQuery.sizeOf(context).height*0.03),

          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              shape: StadiumBorder(),
              minimumSize: Size(MediaQuery.sizeOf(context).width*.5, MediaQuery.sizeOf(context).height*0.06)
            ),
            onPressed: (){},
            icon: const Icon(Icons.edit,size: 28,),label:Text('Update',style: TextStyle(fontSize: 16),),
          )          

          ],
        ),
      ),
    );
  
  }
}
