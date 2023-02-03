import 'dart:io';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_proj/screens/home/basepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;


List<dynamic> pnl=[];
CollectionReference pet_type_info = dogs;
String pet_type="";

class addpets extends StatefulWidget {
  const addpets({Key? key}) : super(key: key);


  @override
  State<addpets> createState() => _addpetsState();
}
class _addpetsState extends State<addpets> {
  File? _petImage;
  String? imageURL;

  Future getImage() async{
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if(image ==null) return;
      final imageTemporary = File(image.path);
      setState(() {
        this._petImage = imageTemporary;
      });
    } on Exception catch (e) {
      print("Failed to pick image");

    }
  }


  final namecontroller = TextEditingController();
  final agecontroller = TextEditingController();
  final gencontroller = TextEditingController();
  final addcontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  final phcontroller = TextEditingController();
  // CollectionReference dogs = FirebaseFirestore.instance.collection("dogs");

  // @override
  // void initState() {
  //   Navigator.push(context, MaterialPageRoute(builder: (context)=>documentSnapshot))
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        appBar: AppBar(centerTitle:true,title:Text("Add details",style: TextStyle(fontSize: 35),),
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              // mainAxisAlignment: MainAxisAlignment.spaceAround,

              children: <Widget>[
                SizedBox(height: 20),
                InkWell(
                  child: Container(

                    height: 150,
                    width: 150,decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(20),

                    boxShadow: [BoxShadow(
                      color: Colors.black45,
                      blurRadius: 3.0,
                    ),],


                  ),
                    child: FittedBox(child: _petImage!= null?
                    Image.file(_petImage!,fit: BoxFit.fill,):Icon(Icons.add_a_photo),fit: BoxFit.fill,),),

                  onTap: (){getImage();},
                ),
                SizedBox(height: 20),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(child: RadioListTile(
                        title: Text("Dog"),
                        value: dogs,
                        groupValue: pet_type_info,
                        onChanged: (value){
                          setState(() {
                            pet_type = "dogs";
                            pet_type_info = dogs;
                          });
                        },
                      ),),

                      Expanded(child: RadioListTile(
                        title: Text("Cat"),
                        value: cats,
                        groupValue: pet_type_info,
                        onChanged: (value){
                          setState(() {
                            pet_type = "cats";
                            pet_type_info = cats;
                          });
                        },
                      ),),
                      Expanded(child: RadioListTile(
                        title: Text("Bird"),
                        value: birds,
                        groupValue: pet_type_info,
                        onChanged: (value){
                          setState(() {
                            pet_type = "birds";
                            pet_type_info = birds;
                          });
                        },
                      ))
                    ],
                  ),),
                SizedBox(height: 20),
                SizedBox(
                  width: MediaQuery.of(context).size.width /1.15,
                  child: TextField(
                    controller: namecontroller,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(width: 3, color: Colors.blue), //<-- SEE HERE
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      labelText: 'Name',
                    ),),
                ),

                SizedBox(height: 20),

                SizedBox(
                  width: MediaQuery.of(context).size.width /1.15,
                  child: TextField(controller: agecontroller,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(width: 3, color: Colors.blue), //<-- SEE HERE
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      labelText: 'Age',
                    ),),
                ),

                SizedBox(height: 20),


                SizedBox(
                  width: MediaQuery.of(context).size.width /1.15,
                  child: TextField(controller: gencontroller,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(width: 3, color: Colors.blue), //<-- SEE HERE
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      labelText: 'Gender',
                    ),),
                ),

                SizedBox(height: 20),


                SizedBox(
                  width: MediaQuery.of(context).size.width /1.15,
                  child: TextField(controller: addcontroller,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(width: 3, color: Colors.blue), //<-- SEE HERE
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      labelText: 'Address',
                    ),),
                ),

                SizedBox(height: 20),


                SizedBox(
                  width: MediaQuery.of(context).size.width /1.15,
                  child: TextField(controller: emailcontroller,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(width: 3, color: Colors.blue), //<-- SEE HERE
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      labelText: 'Email',
                    ),),
                ),

                SizedBox(height: 20),


                SizedBox(
                  width: MediaQuery.of(context).size.width /1.15,
                  child: TextField(controller: phcontroller,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(width: 3, color: Colors.blue), //<-- SEE HERE
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      labelText: 'Phone Number',
                    ),),
                ),

                SizedBox(height: 20),



                ElevatedButton(

                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)
                    ),


                  ),
                  child: Text("Submit"),
                  onPressed: () async{


                    // var uplaod_pet_image = FirebaseStorage.instance.ref().child(_petImage!.path);
                    // var task = uplaod_pet_image.putFile(_petImage!);
                    FirebaseStorage storage = FirebaseStorage.instance;
                    String fileName = Path.basename(_petImage!.path);
                    Reference ref = storage.ref().child("$pet_type/").child(fileName);
                    UploadTask uploadTask = ref.putFile(_petImage!);
                    // imageURL = await (task.onComplete).ref.getDownloadURL();

                    // uploadTask.whenComplete(() async{
                    //   imageURL = await ref.getDownloadURL();
                    // }).catchError((onError) {
                    //   print(onError);
                    // });
                    imageURL = await (await uploadTask).ref.getDownloadURL();
                    await pet_type_info.add({'Name':namecontroller.text,'Age':agecontroller.text,'Gender':gencontroller.text,'Address':addcontroller.text,'uEmail':emailcontroller.text,'uPhone':phcontroller.text,'Picture':'$imageURL'},);
                    Navigator.push(context,MaterialPageRoute(builder: (context) => MyApp()));
                  },
                ),
                // Container(
                //     height: 100,
                //     width: 100,
                //     child: FutureBuilder<QuerySnapshot>(
                //         future: FirebaseFirestore.instance.collection("dogs").get(),
                //
                //         builder: (context, AsyncSnapshot<QuerySnapshot>  snapshot){
                //           if(snapshot.hasData) {
                //             return ListView.builder(
                //                 itemCount:snapshot.data!.docs.length,
                //                 itemBuilder: (context, int index) {
                //                   final DocumentSnapshot documentSnapshot =
                //                   snapshot.data!.docs[index];
                //                   // List<Map<String, dynamic>?> documentData = snapshot.data!.docs.map((e) => e.data() as Map<String, dynamic>?).toList();
                //                   return Container(child: Text(documentSnapshot['Name']),);}
                //             );
                //
                //           }
                //           else {
                //             return Container(child: CircularProgressIndicator(),);
                //           }
                //         }
                //     )
                // ),
                SizedBox(height: 20),
              ],
            ),
          )
        )
    );
  }
}






