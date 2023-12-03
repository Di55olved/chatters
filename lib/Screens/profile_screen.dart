
import 'package:chatters/API/api.dart';
import 'package:chatters/Models/user.dart';
import 'package:chatters/core/repository/user_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatters/Screens/auth/login_screen.dart';

import '../Support/dialogs.dart';
import '../main.dart';


class ProfileScreen extends StatefulWidget {
 final UserRepository userRepository;
 final Cuser user;
  const ProfileScreen({super.key, required this.user, required this.userRepository});


  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
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
                    MaterialPageRoute(builder: (_) => LoginScreen(userRepository: widget.userRepository)));
                 });
              });
            },
            icon: const Icon(Icons.add_comment_rounded),
            label: Text('Logout'),
          ),
                ),
                 
                body: Form(
                  key: _formKey,
                  child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).height*.05),
                            child: ListView(
                              children: [
                                SizedBox(width: MediaQuery.sizeOf(context).width,height: MediaQuery.sizeOf(context).height*0.03),
                               
            SizedBox(
            width: MediaQuery.of(context).size.width * 0.2, // Adjust as needed
            height: MediaQuery.of(context).size.width * 0.2, // Adjust as needed
            
            child: ClipRRect(
              borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height * 0.03),
              child: CachedNetworkImage(
                width: MediaQuery.sizeOf(context).width*.1,
                height: MediaQuery.sizeOf(context).height*.1,
                imageUrl: widget.user.image,
                errorWidget: (context, url, error) => const CircleAvatar(
                  child: Icon(CupertinoIcons.person),
              ),
              
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
                      onSaved: (val) => APIs.me.name = val ?? '',
                      validator: (val) => val != null && val.isNotEmpty
                          ? null
                          : 'Required Field',                  
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
                          onSaved: (val) => APIs.me.about = val ?? '',
                          validator: (val) => val != null && val.isNotEmpty
                          ? null
                          : 'Required Field',
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
                                onPressed: (){
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                APIs.updateUserInfo().then((value) {
                                  Dialogs.showSnackBar(
                                      context, 'Profile Updated Successfully!');
                                });
                        }                                },
                                icon: const Icon(Icons.edit,size: 28,),label:Text('Update',style: TextStyle(fontSize: 16),),
                              )          
                            
                              ],
                            ),
                  ),
                ),
              ),
        );
  
  }
}
