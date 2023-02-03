import 'package:cloud_proj/screens/home/basepage.dart';
import 'package:cloud_proj/models/user.dart';
import 'package:cloud_proj/screens/authenticate/auth.dart';
import 'package:cloud_proj/screens/home/home.dart';
import 'package:cloud_proj/screens/home/Maps/maps_home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    final user = Provider.of<MyUser?>(context);

    //return either home or authentication widget
    if (user == null){
      return Authenticate();
    } else{
      return MyApp();
      // return Maps_HomeScreen();
      // return const ConvertLatLangToAddress();
    }
  }
}
