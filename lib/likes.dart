import 'package:cloud_proj/screens/home/basepage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'contact.dart';






var current_contacted_owner_phone;
var current_contacted_owner_email;


var pet_docs_len = 0;

List<DocumentSnapshot> _myDogsCount=[];
List<DocumentSnapshot> _myCatsCount=[];
List<DocumentSnapshot> _myBirdsCount=[];
List allData2 = ["Empty"];


getData() async {
  // Get docs from collection reference
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("users").doc("$current_logged_uid")
      .collection('swiped_pets').get();

  // Get data from docs and convert map to List
  // final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
  //for a specific field
  List allData = querySnapshot.docs.map((doc) => doc.reference.id).toList();
  if(allData.isNotEmpty){
   allData2 = allData;
 }
  if(allData.isEmpty){
    allData2[0] = "Empty";
  }


  QuerySnapshot _myDogs = await FirebaseFirestore.instance.collection("dogs"
  ).where(FieldPath.documentId, whereIn: allData2 ).get();
  QuerySnapshot _myCats = await FirebaseFirestore.instance.collection("cats"
  ).where(FieldPath.documentId, whereIn: allData2 ).get();
  QuerySnapshot _myBirds = await FirebaseFirestore.instance.collection("birds"
  ).where(FieldPath.documentId, whereIn: allData2 ).get();


    _myDogsCount = _myDogs.docs;
    _myCatsCount = _myCats.docs;
    _myBirdsCount = _myBirds.docs;




}


void fetchpets() async{
  QuerySnapshot _swipetpetDoc = await FirebaseFirestore.instance.collection("users").doc('$current_logged_uid')
      .collection('swiped_pets').get();

  List<DocumentSnapshot> _petDocCount = _swipetpetDoc.docs;

  var pet_doc_len = _petDocCount.length.toInt();
  pet_docs_len = pet_doc_len;

}

main() {

  runApp(likesPage());
}
class likesPage extends StatefulWidget {
  const likesPage({Key? key}) : super(key: key);

  @override
  State<likesPage> createState() => _likesPageState();
}



class _likesPageState extends State<likesPage> {
  @override

  void initState(){

    getData();

    super.initState();


  }

  Future deleteData(String id) async{
    try {
      await  FirebaseFirestore.instance
          .collection("users")
      // .doc(FirebaseAuth.instance.currentUser!.uid)
          .doc('$current_logged_uid')
          .collection('swiped_pets')
          .doc(id)
          .delete();
    }catch (e){
      return false;
    }}


  @override
  Widget build(BuildContext context) {
    void _timer() {
      Future.delayed(Duration(seconds: 5)).then((_) {
        if (!mounted) return;
        setState(() {
        });
        _timer();
      });
    }

    // fetchpets();

    return Scaffold(

      // body: Container(),

      appBar: AppBar(centerTitle:true,
          title: Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [Icon(Icons.favorite_rounded,size: 40,),Text("Liked",style: TextStyle(fontSize: 35),)],),
      ),
      // body: Container(child: Text(pet_docs_len.toString()),),
      body: SingleChildScrollView(child:Container(
        width: MediaQuery.of(context).size.width /1.05,

          padding: new EdgeInsets.all(20.0),
          child: Column(children: [
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection("dogs"
                ).where(FieldPath.documentId, whereIn: allData2 ).snapshots(),

                builder: (context, AsyncSnapshot<QuerySnapshot>  snapshot){

                  if(allData2[0]=="Empty"){
                    return Container(child:Text("Swipe right on a few pets :)"));
                  }
                  if(snapshot.hasData){
                    return ListView.builder(
                        primary: false,
                          shrinkWrap: true,
                          itemCount:snapshot.data!.docs.length,
                          itemBuilder: (context, int index) {
                            final DocumentSnapshot documentSnapshot =
                            snapshot.data!.docs[index];
                            // List<Map<String, dynamic>?> documentData = snapshot.data!.docs.map((e) => e.data() as Map<String, dynamic>?).toList();
                            return Container(
                              padding: EdgeInsets.fromLTRB(0.0,15.0,0.0,0.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(

                                  height: 130,
                                  width: 120,decoration: BoxDecoration(
                                  image: DecorationImage(image:NetworkImage(documentSnapshot['Picture']),fit: BoxFit.cover),
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(20),
                                    boxShadow: [BoxShadow(
                                      color: Colors.black45,
                                      blurRadius: 3.0,
                                    ),],


                                ),),
                                Container(
                                  padding: EdgeInsets.fromLTRB(10.0,0.0,0.0,0.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,

                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children:  <Widget>[
                                          Text(documentSnapshot['Name'],style: TextStyle(fontSize: 17,),textAlign: TextAlign.left,),
                                          Text(documentSnapshot['Age']+" Years",style: TextStyle(fontSize: 17),textAlign: TextAlign.left,),
                                          Text(documentSnapshot['Gender'],style: TextStyle(fontSize: 17),textAlign: TextAlign.left,),
                                          Text(documentSnapshot['Address'],style: TextStyle(fontSize: 17),textAlign: TextAlign.left,),


                                      ],
                                      ),],
                                  ))
                                ,Row(children: [InkWell(
                                  child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.lightGreenAccent,
                                        shape: BoxShape.circle,
                                        // border: Border.all(color: Colors.black,width: 1)
                                      ),
                                      child: Icon(Icons.contact_mail,size: 35)
                                  ),

                                  onTap:() {
                                    current_contacted_owner_phone = documentSnapshot['uPhone'];
                                    current_contacted_owner_email = documentSnapshot['uEmail'];
                                    Navigator.push(context,MaterialPageRoute(builder: (context) => contact()));
                                  },
                                ),InkWell(
                                  child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle,
                                        // border: Border.all(color: Colors.black,width: 1)
                                      ),
                                      child: Icon(Icons.delete_forever_rounded,size: 35)
                                  ),

                                  onTap:() {
                                    // deleteData(collection_name.id);
                                    showDialog(context: context,barrierDismissible: false,
                                        builder: (context)=>AlertDialog(title: Center(child:Text("Are you sure?")),
                                          actions: [SizedBox(
                                              width: MediaQuery.of(context).size.width,
                                              child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [TextButton(onPressed:()=> [
                                                    Navigator.pop(context),
                                                    setState(() {;
                                                    })],
                                                      child: Text("Cancel")),

                                                    TextButton(onPressed:()=> [
                                                      deleteData(documentSnapshot.id),
                                                      Navigator.pop(context),
                                                      setState(() {
                                                        getData();
                                                        Navigator.pop(context);
                                                        Navigator.push(context,MaterialPageRoute(builder: (context) => Home()));
                                                      })],
                                                        child: Text("Delete")),])

                                          )],))
                                    ;  // pop current page
                                  }, //delete
                                )],)



                              ],
                            ),);}
                      );

                  }
                  else {
                    _timer();
                    return Container(child: CircularProgressIndicator(),);
                  }
                }
            )
          ,StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection("cats"
              ).where(FieldPath.documentId, whereIn: allData2 ).snapshots(),

              builder: (context, AsyncSnapshot<QuerySnapshot>  snapshot){

                if(snapshot.hasData){
                  return ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      itemCount:snapshot.data!.docs.length,
                      itemBuilder: (context, int index) {
                        final DocumentSnapshot documentSnapshot =
                        snapshot.data!.docs[index];
                        // List<Map<String, dynamic>?> documentData = snapshot.data!.docs.map((e) => e.data() as Map<String, dynamic>?).toList();
                        return Container(
                          padding: EdgeInsets.fromLTRB(0.0,15.0,0.0,0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(

                                height: 130,
                                width: 120,decoration: BoxDecoration(
                                image: DecorationImage(image:NetworkImage(documentSnapshot['Picture']),fit: BoxFit.cover),
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [BoxShadow(
                                  color: Colors.black45,
                                  blurRadius: 3.0,
                                ),],


                              ),),
                              Container(

                                  padding: EdgeInsets.fromLTRB(10.0,0.0,0.0,0.0),
                                  child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.end,
                                    // crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children:  <Widget>[
                                          Text(documentSnapshot['Name'],style: TextStyle(fontSize: 17,),textAlign: TextAlign.left,),
                                          Text(documentSnapshot['Age']+" Years",style: TextStyle(fontSize: 17),textAlign: TextAlign.left,),
                                          Text(documentSnapshot['Gender'],style: TextStyle(fontSize: 17),textAlign: TextAlign.left,),
                                          Text(documentSnapshot['Address'],style: TextStyle(fontSize: 17),textAlign: TextAlign.left,),


                                        ],
                                      ),],
                                  )),Row(children: [InkWell(
                                child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.lightGreenAccent,
                                      shape: BoxShape.circle,
                                      // border: Border.all(color: Colors.black,width: 1)
                                    ),
                                    child: Icon(Icons.contact_mail,size: 35)
                                ),

                                onTap:() {
                                  current_contacted_owner_phone = documentSnapshot['uPhone'];
                                  current_contacted_owner_email = documentSnapshot['uEmail'];
                                  Navigator.push(context,MaterialPageRoute(builder: (context) => contact()));
                                },
                              ),InkWell(
                                child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                      // border: Border.all(color: Colors.black,width: 1)
                                    ),
                                    child: Icon(Icons.delete_forever_rounded,size: 35)
                                ),

                                onTap:() {
                                  // deleteData(collection_name.id);
                                  showDialog(context: context,barrierDismissible: false,
                                      builder: (context)=>AlertDialog(title: Center(child:Text("Are you sure?")),
                                        actions: [SizedBox(
                                            width: MediaQuery.of(context).size.width,
                                            child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [TextButton(onPressed:()=> [
                                                  Navigator.pop(context),
                                                  setState(() {;
                                                  })],
                                                    child: Text("Cancel")),

                                                  TextButton(onPressed:()=> [
                                                    deleteData(documentSnapshot.id),
                                                    Navigator.pop(context),
                                                    setState(() {
                                                      getData();
                                                      Navigator.pop(context);
                                                      Navigator.push(context,MaterialPageRoute(builder: (context) => Home()));
                                                    })],
                                                      child: Text("Delete")),])

                                        )],))
                                  ;  // pop current page
                                }, //delete
                              )],)



                            ],
                          ),);}
                  );

                }
                else {
                  _timer();
                  return Container(
                    // child: CircularProgressIndicator(),
                  );
                }
              }
          ),StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection("birds"
              ).where(FieldPath.documentId, whereIn: allData2 ).snapshots(),

              builder: (context, AsyncSnapshot<QuerySnapshot>  snapshot){

                if(snapshot.hasData){
                  return ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      itemCount:snapshot.data!.docs.length,
                      itemBuilder: (context, int index) {
                        final DocumentSnapshot documentSnapshot =
                        snapshot.data!.docs[index];
                        // List<Map<String, dynamic>?> documentData = snapshot.data!.docs.map((e) => e.data() as Map<String, dynamic>?).toList();
                        return Container(
                          padding: EdgeInsets.fromLTRB(0.0,15.0,0.0,0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(

                                height: 130,
                                width: 120,decoration: BoxDecoration(
                                image: DecorationImage(image:NetworkImage(documentSnapshot['Picture']),fit: BoxFit.cover),
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [BoxShadow(
                                  color: Colors.black45,
                                  blurRadius: 3.0,
                                ),],


                              ),),
                              Container(
                                  padding: EdgeInsets.fromLTRB(10.0,0.0,0.0,0.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children:  <Widget>[
                                          Text(documentSnapshot['Name'],style: TextStyle(fontSize: 17,),textAlign: TextAlign.left,),
                                          Text(documentSnapshot['Age']+" Years",style: TextStyle(fontSize: 17),textAlign: TextAlign.left,),
                                          Text(documentSnapshot['Gender'],style: TextStyle(fontSize: 17),textAlign: TextAlign.left,),
                                          Text(documentSnapshot['Address'],style: TextStyle(fontSize: 17),textAlign: TextAlign.left,),


                                        ],
                                      ),],
                                  )),Row(children: [InkWell(
                                child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.lightGreenAccent,
                                      shape: BoxShape.circle,
                                      // border: Border.all(color: Colors.black,width: 1)
                                    ),
                                    child: Icon(Icons.contact_mail,size: 35)
                                ),

                                onTap:() {
                                  current_contacted_owner_phone = documentSnapshot['uPhone'];
                                  current_contacted_owner_email = documentSnapshot['uEmail'];
                                  Navigator.push(context,MaterialPageRoute(builder: (context) => contact()));
                                },
                              ),InkWell(
                                child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                      // border: Border.all(color: Colors.black,width: 1)
                                    ),
                                    child: Icon(Icons.delete_forever_rounded,size: 35)
                                ),

                                onTap:() {
                                  // deleteData(collection_name.id);
                                  showDialog(context: context,barrierDismissible: false,
                                      builder: (context)=>AlertDialog(title: Center(child:Text("Are you sure?")),
                                        actions: [SizedBox(
                                            width: MediaQuery.of(context).size.width,
                                            child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [TextButton(onPressed:()=> [
                                                  Navigator.pop(context),
                                                  setState(() {;
                                                  })],
                                                    child: Text("Cancel")),

                                                  TextButton(onPressed:()=> [
                                                    deleteData(documentSnapshot.id),
                                                    Navigator.pop(context),
                                                    setState(() {
                                                      getData();
                                                      Navigator.pop(context);
                                                      Navigator.push(context,MaterialPageRoute(builder: (context) => Home()));
                                                    })],
                                                      child: Text("Delete")),])

                                        )],))
                                  ;  // pop current page
                                }, //delete
                              )],)



                            ],
                          ),);}
                  );

                }
                else {
                  _timer();
                  return Container(
                    // child: CircularProgressIndicator(),
                  );
                }
              }
          )],)
      ),
    ));
  }
}

