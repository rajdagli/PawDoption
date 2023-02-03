import 'package:cloud_proj/likes.dart';
import 'package:cloud_proj/featured.dart';
import 'package:cloud_proj/widgets/appBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
// import 'package:cloud_proj/widgets/bottomBar.dart';
import 'package:flutter/material.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_proj/profile.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_starter/screens/home/Maps/maps_home.dart';
import 'package:cloud_proj/screens/home/Maps/staticmaps_home.dart';
import 'package:cloud_proj/services/auth1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_proj/screens/home/pet_list.dart';


// import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
// import 'package:flutter_speed_dial/flutter_speed_dial.dart';

var call_animal_val = 'dogs'; //default category selection
var current_logged_uid = "";
var doc_len=5;

final FirebaseAuth auth = FirebaseAuth.instance;

void get_curent_uid() {
   User user = auth.currentUser!;
  current_logged_uid = user.uid;
  // here you write the codes to input the data into firestore
}

List<SwipeItem> _swipeItems = <SwipeItem>[];
List names = [];
int currentIndex = 0;
MatchEngine _matchEngine= MatchEngine();

CollectionReference dogs = FirebaseFirestore.instance.collection("dogs");
CollectionReference cats = FirebaseFirestore.instance.collection("cats");
CollectionReference birds = FirebaseFirestore.instance.collection("birds");
CollectionReference users = FirebaseFirestore.instance.collection("users");


// List<String> names = ["A","B","C"];

fetch_pets_len()async{
  QuerySnapshot _myDoc = await FirebaseFirestore.instance.collection("$call_animal_val"
  ).get();
  List<DocumentSnapshot> _myDocCount = _myDoc.docs;

  doc_len = _myDocCount.length.toInt();

}


countDocuments() async {
  QuerySnapshot _myDoc = await FirebaseFirestore.instance.collection("$call_animal_val"
  ).get();

  // Count of Documents in Collection
  _swipeItems = [];
  for(int i = 0;i<doc_len;i++){
    _swipeItems.add(SwipeItem(content: Content(),
        likeAction: (){
          FirebaseFirestore.instance
              .collection('users')
              // .doc('zhlrfn2RN0jY7l8pVsCK')
              .doc("$current_logged_uid")
              .collection('swiped_pets')
              .doc(_myDoc.docs[i].reference.id)
              .set({
          });

          //     .add({
          //   'pet_$call_animal_val$i': _myDoc.docs[i].reference.id
          // }


        },
        nopeAction: (){},
        superlikeAction: (){}));
  }
  _matchEngine = MatchEngine(swipeItems: _swipeItems);



}


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(new MyApp());
}


// random_func() async {
//
//   QuerySnapshot _mydogs = await FirebaseFirestore.instance.collection("dogs"
//   ).get();
//   // _random_list = List.from(data.docs.map((doc)=>dogs.fromSnapshot(doc)));
//   final allDa = _mydogs.docs.map((doc) => doc["Name"]).toList();
//   names = allDa;
//
// }





class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);




  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: Home(),
    );
  }
}


class Home extends StatefulWidget {

  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}


class _HomeState extends State<Home> {



  @override
  void initState(){
    currentIndex = 1;
    get_curent_uid();
    // random_func();

    countDocuments();

    super.initState();



  }
  @override
  Widget build(BuildContext context) {


    return  StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance.collection("$call_animal_val").snapshots(),
                          builder: (context, AsyncSnapshot snapshot){
                            if(snapshot.hasData) {

                              swipe_container(){
                                void _timer() {
                                  Future.delayed(Duration(seconds: 3)).then((_) {
                                    setState(() {
                                    });
                                    _timer();
                                  });
                                }

                                return Container(
                                  child: Column(
                                    children: [
                                      // SizedBox(height: 70,),
                                      Container(height: 40,color: Colors.white,
                                      ),
                                      TopBar(),
                                      Expanded(child: Container(
                                        color: Colors.white,
                                        padding: EdgeInsets.fromLTRB(30,0, 30, 0),
                                        child:
                                        SwipeCards(matchEngine: _matchEngine,
                                          itemBuilder: (BuildContext context, int index){
                                            final DocumentSnapshot documentSnapshot =
                                            snapshot.data.docs[index];
                                            return Container(
                                              child: Container(
                                                  child: StreamBuilder<QuerySnapshot>(
                                                      stream: FirebaseFirestore.instance.collection("$call_animal_val").snapshots(),
                                                      builder: (context, AsyncSnapshot snapshot){
                                                        if(snapshot.hasData){

                                                          return Container(
                                                            padding: EdgeInsets.fromLTRB(10.0,10.0,10.0,10.0),alignment: Alignment.bottomLeft,
                                                            child: Text(documentSnapshot['Name']+'\n'+
                                                                documentSnapshot['Age']+" Years"+'\n'+documentSnapshot['Gender']+'\n'+
                                                                documentSnapshot['Address'],style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,foreground: Paint()
                                                              ..style = PaintingStyle.fill
                                                              ..strokeWidth = 1
                                                              ..color = Colors.white,
                                                              shadows: <Shadow>[
                                                                Shadow(
                                                                  offset: Offset(1.0, 1.0),
                                                                  blurRadius: 10.0,
                                                                  color: Color.fromARGB(255, 0, 0, 0),
                                                                ),
                                                              ],),),);
                                                        }
                                                        else {
                                                          _timer();
                                                          return Center(child:
                                                          Container(
                                                            child: CircularProgressIndicator(
                                                            ),
                                                          ));
                                                          setState(() {

                                                          });
                                                        }
                                                      }
                                                  )
                                              ),
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(image:NetworkImage(documentSnapshot['Picture']),fit: BoxFit.cover),
                                                  color: Colors.grey,
                                                  borderRadius: BorderRadius.circular(20),


                                              ),
                                            );
                                          },
                                          onStackFinished: (){
                                             // return ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("End of list")));
                                            return showDialog(context: context,barrierDismissible: false,
                                                builder: (context)=>AlertDialog(title: Center(child:Text("Thats all o(╥﹏╥)o")),
                                                  actions: [SizedBox(
                                                      width: MediaQuery.of(context).size.width,
                                                      child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [TextButton(onPressed:()=> [countDocuments(),
                                                            swipe_container(),
                                                            Navigator.pop(context),
                                                            setState(() {})],
                                                              child: Text("Review previous results")),])

                                                  )],));
                                           },),),
                                      ),


                                      // BottomBar()
                                    ],
                                  ),
                                );


                              }
                              refreshpage(){
                                setState(() {

                                });
                              };

                              final screens = [Maps_HomeScreen(),swipe_container(),featured(),likesPage()];

                            return Scaffold(


                               // bottomNavigationBar: BottomBar(),
                              bottomNavigationBar: SizedBox(

                                height: 90, child: BottomNavigationBar(
                                elevation: 0,
                                backgroundColor: Colors.white,
                                showSelectedLabels: false,
                                showUnselectedLabels: false,
                                selectedItemColor: Colors.blue,
                                unselectedItemColor: Colors.black,
                                type: BottomNavigationBarType.fixed,
                                currentIndex: currentIndex,

                                onTap: (int index)=> setState(()=>currentIndex = index,),
                                items: [BottomNavigationBarItem(icon: Icon(Icons.map_rounded, size: 50,), label: ''),
                                  BottomNavigationBarItem(icon: Icon(Icons.home_rounded, size: 50,), label: ''),
                                  BottomNavigationBarItem(icon: Icon(Icons.star_rounded, size: 50,), label: ''),
                                  // BottomNavigationBarItem(icon: Icon(Icons.chat_rounded, size: 50,), label: ''),
                                  BottomNavigationBarItem(icon: Icon(Icons.favorite_rounded, size: 50,), label: ''),],
                              ),),


                              body: screens[currentIndex]

                            );

                            }

                            else {
                              return Container(child: Text("Loading"));
                            }
                          }

                      );

  }
}


class Content{
  final String? text;
  Content({this.text});
}



// if(snapshot.hasData) {
// final DocumentSnapshot documentSnapshot =
// snapshot.data!.docs[index];
// // List<Map<String, dynamic>?> documentData = snapshot.data!.docs.map((e) => e.data() as Map<String, dynamic>?).toList();
// return Container(child: Text(documentSnapshot['Name']),);
// }
// else {
// return Container();
// }

