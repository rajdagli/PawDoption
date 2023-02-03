import 'package:cloud_proj/widgets/bottomBar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_proj/add_details_page.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_proj/screens/home/basepage.dart';
import 'package:cloud_proj/profile.dart';

var animalValue ;
class TopBar extends StatefulWidget {
  const TopBar({Key? key}) : super(key: key);


  @override
  State<TopBar> createState() => _TopBarState();

}

class _TopBarState extends State<TopBar> {

  var pet_types = ["dogs","cats",'birds'];


  showPicker() {

    showModalBottomSheet(

        context: context,
        builder: (BuildContext context) {
          return CupertinoPicker(
            scrollController: FixedExtentScrollController(initialItem: pet_types.indexOf("$animalValue")),
            // onSelectedItemChanged: (i) => setState(() => _chosenProvince = listProvince[i]),

            backgroundColor: Colors.white,

            onSelectedItemChanged: (value) {
              setState(() {
                if(value==0){
                  animalValue = "dogs";

                }
                else if (value==1){
                  animalValue = "cats";


                }
                else if (value==2){
                  animalValue = "birds";

                }
                call_animal_val = animalValue;
                countDocuments();
                setState(() {});

              });
            },

            itemExtent: 32.0,
            children: const [
              Text('Dog'),
              Text('Cat'),
              Text('Birds'),
            ],
          );
        }).whenComplete(() {if (mounted) {
      setState(() async{
        Navigator.pop(context);
        await Navigator.push(context,MaterialPageRoute(builder: (context) => Home()));
      });
    }
  });
  }

  @override
  Widget build(BuildContext context) {

    return Container(height: 70,
    color: Colors.white,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,

      children: [
        InkWell(
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black,width: 1)
              ),
              child:imageWidget("assets/pets_icon.png"),
            ),
          onTap: (){showPicker();}),

        Row(
          children: [
            Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
              ),
              child:imageWidget("assets/paw.jpg"),
            ),Text("Pawdoption",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),)
          ],
        ),

        InkWell(child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black,width: 1)
          ),
          child:imageWidget("assets/user.png"),
        ),
          onTap: (){Navigator.push(context,MaterialPageRoute(builder: (context) => profile_sec()));},),
      ],
    ),);
  }
}

Widget imageWidget(String image){
  return Container(
    height: 50,
    width: 50 ,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      image: DecorationImage(image: AssetImage(image),
      fit: BoxFit .cover )
    ),
  );

}