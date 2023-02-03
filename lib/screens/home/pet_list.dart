import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PetList extends StatefulWidget {
  @override
  State<PetList> createState() => _PetListState();
}

class _PetListState extends State<PetList> {
  @override
  Widget build(BuildContext context) {
    final pets= Provider.of<QuerySnapshot>(context);
    for (var doc in pets.docs) {
      print(doc.data());
    }
    return Container();
  }
}
