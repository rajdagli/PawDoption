import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});
  final CollectionReference petCollection = FirebaseFirestore.instance.collection('pets');

  Future updateUserData(String petName, int petAge, String petLocation, String petDescription) async{
    return await petCollection.doc(uid).set({
      'petName': petName,
      'petAge' : petAge,
      'petLocation': petLocation,
      'petDescription': petDescription,
    });
  }

  //Get Pets/Users Stream
  Stream<QuerySnapshot> get pets{
    return petCollection.snapshots();
  }
}
//Users
class DatabaseService1 {
  final String uid;
  DatabaseService1({required this.uid});
  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

  Future updateUserData(GeoPoint uLocation, String uName) async{
    return await usersCollection.doc(uid).set({
      'uName': uName,
      'uLocation': uLocation,
    });
  }
  //Get Users/Users Stream
  Stream<QuerySnapshot> get users{
    return usersCollection.snapshots();
  }

  Future getUsersList()async{
    List itemsList=[];
    try{
      await usersCollection.get().then((querySnapshot){
        querySnapshot.docs.forEach((element) {
          itemsList.add(element.data);
        });
      });
      return itemsList;
    } catch(e){
      print(e.toString());
      return null;
    }
  }
}