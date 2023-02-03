import 'package:cloud_proj/screens/authenticate/sign_in.dart';
import 'package:cloud_proj/services/auth1.dart';
import 'package:cloud_proj/widgets/bottomBar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_proj/add_details_page.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_proj/screens/home/basepage.dart';
import 'dart:io';
import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_proj/widgets/appBar.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'main.dart';


// main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(new profile_sec());
// }
var uName;
var uAge;
var uPicture;


class profile_sec extends StatefulWidget {
  const profile_sec({Key? key}) : super(key: key);

  @override
  State<profile_sec> createState() => _profile_secState();
}

class _profile_secState extends State<profile_sec> {
  void _timer() {
    Future.delayed(Duration(seconds: 1)).then((_) {
      if (!mounted) return;
      setState(() {
      });
      _timer();
    });
  }

  final AuthService _auth = AuthService();

  final CollectionReference petCollection = FirebaseFirestore.instance.collection('pets');
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');
  fetchUserDetails() async{

    var collection = FirebaseFirestore.instance.collection('users');
    var docSnapshot = await collection.doc("$current_logged_uid").get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      uName = data?['uName'];
      uAge = data?['uAge'];
      uPicture = data?['uPicture'];

    }
    // else {
    //   return Container(child: CircularProgressIndicator(),);
    // }
    setState(() {

    });

    ;}

  @override
  void initState() {
    fetchUserDetails();
    super.initState();



  }
  File? _profileImage;
  String? imageURL ;

  Future getImage() async{
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if(image ==null) return;
      final imageTemporary = File(image.path);
      setState(() {
        this._profileImage = imageTemporary;
      });
    } on Exception catch (e) {
      print("Failed to pick image");

    }
  }
  imagefunc(){
    if(uPicture == '') {
      return Icon(Icons.add_a_photo);
    }

    else
      return FittedBox(
        // height: MediaQuery.of(context).size.width / 2.5,
        // width: MediaQuery.of(context).size.width / 2.5,
        child: Image.network(uPicture),
        fit:BoxFit.cover);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(centerTitle:true,title:Text("Profile",
      style: TextStyle(fontSize: 35),),
    ),
        body: Container(
          // height: MediaQuery.of(context).size.width / 1,
            padding: new EdgeInsets.all(20.0),
            child: Column(mainAxisAlignment: MainAxisAlignment.center,
              children: [

            //     Align(
            //     alignment: Alignment.center,
            //     child: InkWell(
            //     child: ClipRRect(
            //       borderRadius: BorderRadius.circular(20),
            //       child: Container(
            //       height: MediaQuery.of(context).size.width / 2.5,
            //         width: MediaQuery.of(context).size.width / 2.5,
            //       decoration: BoxDecoration(
            //         color: Colors.grey,
            //         borderRadius: BorderRadius.circular(20),
            //
            //         boxShadow: [BoxShadow(
            //           color: Colors.black45,
            //           blurRadius: 3.0,
            //         ),],
            //
            //
            //       ),
            //         child: FittedBox(child: _profileImage!= null?
            //         Image.file(_profileImage!,):imagefunc(),fit: BoxFit.cover,),),
            //     ),
            //     onTap: (){getImage();},
            // ),
            //   ),


                Container(padding: EdgeInsets.all(20),
                  child:Text("$uName,$uAge",style: TextStyle(fontSize: 35)))

              ,Container(child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              // border: Border.all(color: Colors.black,width: 3)
                          ),
                          child: Icon(Icons.settings, size: 50,),
                        ),
                        onTap: (){}),
                Container(
                  padding: EdgeInsets.only(top: 50),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    ),
                    onPressed: () {
                      Navigator.push(context,MaterialPageRoute(builder: (context) => addpets()));
                    },
                    child: Text('Rehome a pet',),
                  ),
                ),InkWell(
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            // border: Border.all(color: Colors.black,width: 3)
                          ),
                          child: Icon(Icons.help, size: 50,),
                        ),
                        onTap: (){})

              ,],)),
                Container(
                  padding: EdgeInsets.only(top: 50),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    ),
                    onPressed: () async{
                      await _auth.signOut();
                      Navigator.pop(context);
                      Navigator.push(context,MaterialPageRoute(builder: (context) => MyApp2()));
                    },
                    child: Text('Log Out',),
                  ),
                )

            ,
                Spacer(),
                Container(
                  alignment: Alignment.bottomCenter,

                    child: Row(mainAxisAlignment: MainAxisAlignment.center,
                        children:[Container(child: Text("Made with ",style: TextStyle(fontSize: 20))),
                      Container(
                        width: 30,
                        height: 30,
                        child: Icon(Icons.favorite_rounded, size: 25,),
                      ),]),
                  ),
                ],)
        ),
        );
  }
}
