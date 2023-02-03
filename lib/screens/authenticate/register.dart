import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_proj/screens/home/basepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_proj/services/auth1.dart';
import 'package:cloud_proj/shared/loading.dart';



final namecontroller = TextEditingController();
final agecontroller = TextEditingController();
final phonecontroller = TextEditingController();
final emailcontroller = TextEditingController();
DocumentReference users = FirebaseFirestore.instance.collection("users").doc("$current_logged_uid");

class Register extends StatefulWidget {

  final Function toggleView;
  Register({required this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  void get_curent_uid() {
    User user = auth.currentUser!;
    current_logged_uid = user.uid;
    // here you write the codes to input the data into firestore
  }

  final AuthService _auth = AuthService();
  final _formKey=GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String email = "";
  String password = "";
  String error="";

  @override
  Widget build(BuildContext context) {
    return loading? Loading(): Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Sign up',style: TextStyle(color: Colors.black,fontSize: 30),),
        actions: <Widget>[
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)
              ),
            ),
            onPressed: (){
              widget.toggleView();
            },
            icon: Icon(Icons.person),
            label: Text('Sign In'),
          )
        ],
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20),
                TextFormField(
                  controller: namecontroller,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(width: 3, color: Colors.blue), //<-- SEE HERE
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      labelText: 'Name',
                    ),

                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: agecontroller,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(width: 3, color: Colors.blue), //<-- SEE HERE
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      labelText: 'Age',
                    ),

                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: phonecontroller,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(width: 3, color: Colors.blue), //<-- SEE HERE
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      labelText: 'Phone',
                    ),
                ),

                SizedBox(height: 20),
                TextFormField(
                  controller: emailcontroller,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(width: 3, color: Colors.blue), //<-- SEE HERE
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      labelText: 'Email',
                    ),

                  validator: (val)=>val!.isEmpty? 'Enter an email':null,
                  onChanged: (val){
                    setState(()=>email=val);
                  }
                ),
                SizedBox(height: 20),
                TextFormField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(width: 3, color: Colors.blue), //<-- SEE HERE
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      labelText: 'Password',
                    ),
                  obscureText: true,
                  validator: (val)=>val!.length<6? 'Enter a password of 6+':null,
                  onChanged: (val){
                    setState(()=>password=val);
                  }
                ),
                SizedBox(height: 20),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)
                      ),
                    ),
                    child: Text(
                      'Register',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async{

                      if(_formKey.currentState!.validate()){
                        setState(()=>loading=true);
                        dynamic result=await _auth.registerWithEmailAndPassword(email,password);
                        if(result==null){
                          setState((){
                            error='please supply valid email';
                            loading=false;
                            });
                        }
                      }
                      get_curent_uid();
                      await users.set({'uName':namecontroller.text,'uAge':agecontroller.text,'uEmail':emailcontroller.text,'uPhone':phonecontroller.text,},);

                    }
                ),
                SizedBox(height: 12),
                Text(
                  error,
                  style: TextStyle(color: Colors.red,fontSize:14),
                ),
              ],
            ),
          )
      ),
    );
  }
}
