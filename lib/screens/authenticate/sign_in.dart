import 'package:cloud_proj/services/auth1.dart';
import 'package:cloud_proj/shared/loading.dart';
import 'package:flutter/material.dart';
class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({required this.toggleView});


  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey=GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String email = "";
  String password = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    return loading? Loading(): Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Sign in to App',style: TextStyle(color: Colors.black,fontSize: 30),),
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
              label: Text('Register'),
          )
        ],
      ),
      body: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20),
                TextFormField(
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
                  // color: Colors.pink[400],
                  child: Text(
                    'Sign In',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async{
                    if(_formKey.currentState!.validate()){
                      setState(()=>loading=true);
                      dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                      if(result==null){
                        setState((){
                          error='Incorrect credentials';
                          loading=false;
                        });
                      }
                    }
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
