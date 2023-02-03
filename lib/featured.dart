import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_proj/models/user.dart';
import 'package:cloud_proj/screens/wrapper.dart';
import 'package:cloud_proj/services/auth1.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(featured());
}

class featured extends StatefulWidget {
  const featured({Key? key}) : super(key: key);

  @override
  State<featured> createState() => _featuredState();
}

class _featuredState extends State<featured> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [Icon(Icons.star_border_rounded,size: 40,),Text("Featured",style: TextStyle(fontSize: 35),)],),
          ),
      body: Column(children: [
        SizedBox(height: 10,),
        Expanded(
          child: Center(
            child: Stack(
              children: [Container(height: MediaQuery.of(context).size.height/1.50,
                  width: MediaQuery.of(context).size.width/1.25,
                decoration: BoxDecoration(
                  image: DecorationImage(image:AssetImage("assets/dog1.jpg"),fit: BoxFit.cover),
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(20),




                ),child: Container(alignment:Alignment.bottomRight,
                    child: Row(children: [Padding(padding: EdgeInsets.symmetric(horizontal: 20,),
                        child: Text("Bond",style: TextStyle(fontSize: 55,fontWeight: FontWeight.bold,foreground: Paint()
                     ..style = PaintingStyle.fill
                     ..strokeWidth = 1
                     ..color = Colors.white,
                        shadows: <Shadow>[
                       Shadow(
                      offset: Offset(5.0, 5.0),
                          blurRadius: 3.0,
                        color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ],),
                        )),
                        Spacer(),
                      Icon(Icons.favorite,size: 100,color: Colors.redAccent,)])),),],
            ),
          ),
        )

      ],),
    );
  }
}
