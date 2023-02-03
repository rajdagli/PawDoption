import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_proj/services/database.dart';
// List latList=[19.0759837,28.679079,26.850000,24.879999,16.166700,12.971599];
// List lngList=[72.8776559,77.069710,80.949997,74.629997,74.833298,77.594563];
List latList=[];
List lngList=[];
List nameList=[];

CollectionReference userCollection = FirebaseFirestore.instance.collection('users');
random_func() async {

  QuerySnapshot _myLat = await FirebaseFirestore.instance.collection("users"
  ).get();
  // _random_list = List.from(data.docs.map((doc)=>dogs.fromSnapshot(doc)));
  final allDa = _myLat.docs.map((doc) => doc["uLat"]).toList();
  latList = allDa;

  final allDa1 = _myLat.docs.map((doc) => doc["uLng"]).toList();
  lngList = allDa1;

  final names = _myLat.docs.map((doc) => doc["uName"]).toList();
  nameList = names;

}

class Maps_HomeScreen extends StatefulWidget {
  @override
  State<Maps_HomeScreen> createState() => _Maps_HomeScreenState();
}

class _Maps_HomeScreenState extends State<Maps_HomeScreen> {

  // created controller for displaying Google Maps
  Completer<GoogleMapController> _controller = Completer();

  // given camera position
  static final CameraPosition _kGoogle = const CameraPosition(
    target: LatLng(19.0759837, 72.8776559),
    zoom: 8,
  );

  final List<Marker> _markers = <Marker>[];
  final List<LatLng> _latLen = <LatLng>[];

  // final List<LatLng> _latLen = <LatLng>[
  //
  //   LatLng(19.0759837, 72.8776559),
  //   LatLng(28.679079, 77.069710),
  //   LatLng(26.850000, 80.949997),
  //   LatLng(24.879999, 74.629997),
  //   LatLng(16.166700, 74.833298),
  //   LatLng(12.971599, 77.594563),
  // ];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // initialize loadData method
    random_func();
    loadData();
  }

  // created method for displaying custom markers according to index
  loadData() async{
    QuerySnapshot _myDoc = await FirebaseFirestore.instance.collection("users").get();
    List<DocumentSnapshot> _myDocCount=_myDoc.docs;
    var doc_len=_myDocCount.length.toInt();

      setState(() {
        for(int i=0;i<doc_len;i++){
          // _latLen.add(LatLng(allData1[i]['uLat'], allData2[i]['uLng']));
          _latLen.add(LatLng(latList[i],lngList[i]));
        }
      });
    // for(int i=0;i<usersProfilesList.length;i++){
    //   // _latLen.add(LatLng(usersProfilesList[i]['uLocation'].latitude, usersProfilesList[i]['uLocation'].longitude));
    //   _latLen.add(LatLng(19.0759837, 72.8776559));
    // }
    for(int i=0 ;i<_latLen.length; i++){
      // makers added according to index
      _markers.add(
          Marker(
            // given marker id
            markerId: MarkerId(i.toString()),

            // given position
            position: _latLen[i],
            infoWindow: InfoWindow(
              // given title for marker
              title: nameList[i],
            ),
          )
      );
      setState(() {
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // on below line we have given title of app
        centerTitle: true,
        title: Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [Icon(Icons.map_rounded,size: 40,),Text("Pets near you",style: TextStyle(fontSize: 35),)],),
      ),
      body:Container(
      //     child:
      //     StreamBuilder<QuerySnapshot>(
      //     stream: FirebaseFirestore.instance.collection("$userCollection").snapshots(),
      //     builder: (context, AsyncSnapshot snapshot){
      //       if(snapshot.hasData) {
      //         return ListView.builder(
      //             itemCount:snapshot.data!.docs.length,
      //             itemBuilder: (context, int index) {
      //               final DocumentSnapshot documentSnapshot =
      //               snapshot.data!.docs[index];
      //               latList[index]=(documentSnapshot['uLat']);
      //               lngList[index]=(documentSnapshot['uLng']);
      //               return Container(child: Text(documentSnapshot['uLat'].toString()),);
      //             }
      //         );
      //       }else {
      //         return Container(child: CircularProgressIndicator(),);
      //       }
      //     }
      // )
      // )
        child: SafeArea(
          child: GoogleMap(
            // given camera position
            initialCameraPosition: _kGoogle,
            // set markers on google map
            markers: Set<Marker>.of(_markers),
            // on below line we have given map type
            mapType: MapType.normal,
            // on below line we have enabled location
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            // on below line we have enabled compass
            compassEnabled: true,
            // below line displays google map in our app
            onMapCreated: (GoogleMapController controller){
              _controller.complete(controller);
            },
          ),
        ),
      )
    );
  }
}
