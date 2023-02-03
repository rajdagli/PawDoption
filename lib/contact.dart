import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_proj/likes.dart';
import 'package:cloud_proj/profile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_proj/models/user.dart';
import 'package:cloud_proj/screens/wrapper.dart';
import 'package:cloud_proj/services/auth1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';


var owner_det = "";
var Ophone = "";
var Oemail = "";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(contact());
}

// fetchOwnerDet() async{
//   var _ownerDet = await FirebaseFirestore.instance.collection("users").doc('zhlrfn2RN0jY7l8pVsCK')
//       .collection('swiped_pets').get();
//
//   var collection = FirebaseFirestore.instance.collection('users');
//   var docSnapshot = await collection.doc('zhlrfn2RN0jY7l8pVsCK').get();
//   if (docSnapshot.exists) {
//     Map<String, dynamic>? data = docSnapshot.data();
//     Ophone = data?['uPhone'];
//     Oemail = data?['uEmail'];
//
//   // var name = data['name'];
//   //
//   // List<DocumentSnapshot> _owner_det_list = _ownerDet.docs;
//   // owner_det =_owner_det_list;
//
// }}



class contact extends StatefulWidget {
  const contact({Key? key}) : super(key: key);

  @override
  State<contact> createState() => _contactState();
}

class _contactState extends State<contact> {
  @override
  void initState() {
    // fetchOwnerDet();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Contact owner",style: TextStyle(fontSize: 35),),),
      body: Container(child: Column(
        children: [
          SizedBox(height: 20),
          InkWell(
            onTap: (){
              FlutterPhoneDirectCaller.callNumber("$current_contacted_owner_phone");

            },
            child: Container(
            child: Row(children: [
              Image.asset('assets/phone.png',scale: 15,),
              Text("$current_contacted_owner_phone"),

        ],),),
          ),

          InkWell(
            onTap: ()async{
              String email = Uri.encodeComponent("$current_contacted_owner_email");
              //output: Hello%20Flutter
             Uri mail = Uri.parse("mailto:$email");
              if (await launchUrl(mail)) {
             //email app opened
             }else{
               //email app is not opened
              }
              },
            child: Container(
              child: Row(children: [
                Image.asset('assets/mail.png',scale: 15,),
                Text("$current_contacted_owner_email"),

              ],),),
          )],
      )),
    );
  }
}
