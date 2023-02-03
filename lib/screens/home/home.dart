import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_starter/screens/home/Maps/maps_home.dart';
import 'package:cloud_proj/screens/home/Maps/staticmaps_home.dart';
import 'package:cloud_proj/services/auth1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_proj/screens/home/pet_list.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final AuthService _auth = AuthService();

  final CollectionReference petCollection = FirebaseFirestore.instance.collection('pets');
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');

  @override

  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        title: Text('User List'),
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        actions: <Widget>[
          ElevatedButton.icon(
              icon: Icon(Icons.person),
              label: Text('Logout'),
              onPressed: () async{
                await _auth.signOut();
              },
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Maps_HomeScreen()),
              );
            },
              icon: Icon(Icons.map),
              label: Text('Maps'),
          ),
        ],
      ),
      // body: Container(child: Text(latList[0]),)
      // body: Container(child: Text(latList.toString()),)
      // body: Container(child: StreamBuilder<QuerySnapshot>(
      //     stream: FirebaseFirestore.instance.collection("pets").snapshots(),
      //
      //     builder: (context, AsyncSnapshot<QuerySnapshot>  snapshot){
      //       if(snapshot.hasData) {
      //         return ListView.builder(
      //             itemCount:snapshot.data!.docs.length,
      //             itemBuilder: (context, int index) {
      //               final DocumentSnapshot documentSnapshot =
      //               snapshot.data!.docs[index];
      //               // List<Map<String, dynamic>?> documentData = snapshot.data!.docs.map((e) => e.data() as Map<String, dynamic>?).toList();
      //               return Container(child: Text(documentSnapshot['petName']),);}
      //         );
      //
      //       }
      //       else {
      //         return Container(child: CircularProgressIndicator(),);
      //       }
      //     }
      // )
      );
  }
}
