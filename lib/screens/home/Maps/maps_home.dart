import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Maps_HomeScreen extends StatefulWidget {
  @override
  State<Maps_HomeScreen> createState() => _Maps_HomeScreenState();
}

class _Maps_HomeScreenState extends State<Maps_HomeScreen> {

  bool mapToggle= false;
  var currentLocation;
  var pets=[];
  late GoogleMapController mapController;
  List<Marker> _markers = <Marker>[];

  void initState(){
    super.initState();
    Geolocator.getCurrentPosition().then((currloc){
      setState(() {
        currentLocation=currloc;
        mapToggle = true;
        populatePets();

      });
    });
  }
  populatePets() async{
    FirebaseFirestore.instance.collection('pets').get().then((docs){
      if(docs.docs.isNotEmpty){
        for(int i=0; i<docs.docs.length;i++){
          initMarker(docs.docs[i].data,docs.docs[i].id);
        }
      }
    });
  }
  initMarker(pets,id) async{
    _markers.add(
      Marker(
        markerId: MarkerId(id),
        position: LatLng(pets['petLocation'].latitude, pets['petLocation'].longitude),
          draggable: false,
          infoWindow: InfoWindow(title:pets['petName'],snippet: pets['petDescription'])
      ),
    );
    // mapController.clearMarkers().then((val) {
    //   mapController.addMarker(MarkerOptions(
    //       position:
    //       LatLng(pets['petLocation'].latitude, pets['petLocation'].longitude),
    //       draggable: false,
    //       infoWindow: InfoWindow(title:pets['petName'],snippet: pets['petDescription'])));
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children:<Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                child: mapToggle
                    ? GoogleMap(
                  mapType: MapType.normal,
                  markers: Set.from(_markers),
                  // markers: Set<Marker>.of(_markers),
                  onMapCreated: onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(currentLocation.latitude, currentLocation.longitude),
                    //target: LatLng(20.5937, 78.9629),
                    zoom: 8.0),
                ):
                    Center(
                      child: Text('Loading..Please Wait',
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
              )
            ],
          )
        ],
      )
    );
  }
  void onMapCreated(controller){
    setState(() {
      mapController=controller;
    });
  }
}
